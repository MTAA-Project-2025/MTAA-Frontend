import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtaa_frontend/core/constants/images/image_size_type.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/features/images/data/models/requests/update_image_request.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/images/data/storages/my_image_storage.dart';
import 'package:mtaa_frontend/features/images/domain/utils/cropAspectRatioPresetCustom.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/add_location_request.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/posts/data/models/requests/update_post_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/add_post_form.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/themes/button_theme.dart';

class UpdatePostScreen extends StatefulWidget {
  final PostsRepository repository;
  final LocationsRepository locationsRepository;
  final MyToastService toastService;
  final MyImageStorage imageStorage;
  final FullPostResponse post;

  const UpdatePostScreen({super.key, required this.repository, required this.toastService, required this.imageStorage, required this.post, required this.locationsRepository});

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  final descriptionController = TextEditingController();
  String startStr = '';
  bool isLoading = false;
  List<UpdatePostImageScreenDTO> addImagesDTOs = [];

  List<ImageDTO> images = [];

  bool isAspectRatioError = false;
  final int maxImageCount = 10;
  List<String> imagePathsForDelete = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddLocationRequest addLocationRequest = AddLocationRequest(latitude: -200, longitude: -200, eventTime: DateTime.now());

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (!mounted) return;

      LocationPostResponse? location;
      if (widget.post.locationId != null) {
        location =  await widget.locationsRepository.getLocationPostById(widget.post.locationId!);
      }

      if (!mounted) return;
      setState(() {
        descriptionController.text = widget.post.description;

        if (location != null) {
            addLocationRequest = AddLocationRequest(latitude: location.point.latitude, longitude: location.point.longitude, eventTime: location.eventTime);
        }

        for (var img in widget.post.images) {
          var middleImg = img.images.where((e) => e.type == ImageSizeType.middle).first;
          var addImageDTO = UpdatePostImageScreenDTO(
            position: img.position,
            onlineImage: middleImg,
            onlineOriginalImage: img.images.where((e) => e.type == ImageSizeType.large).first,
          );
          addImagesDTOs.add(addImageDTO);
          images.add(ImageDTO(
            image: Image(image: NetworkImage(middleImg.fullPath), fit: BoxFit.fitHeight),
            originalPath: img.images.where((e) => e.type == ImageSizeType.large).first.fullPath,
            isAspectRatioError: false,
            aspectRatioPreset: CropAspectRatioPresetCustom(middleImg.width, middleImg.height, 'original2'),
          ));
        }
      });
    });
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void _navigateToGroupListScreen() {
    Future.microtask(() async {
      if (!mounted) return;
      await widget.repository.deleteTempPostAddForm();

      if (!mounted && !context.mounted) return;
      GoRouter.of(context).go(userRecommendationsScreenRoute);
    });
  }

  void deleteImg(int pos) {
    if(!mounted)return;
    setState(() {
      images.removeAt(pos);
      addImagesDTOs.removeAt(pos);
      for (int i = pos; i < addImagesDTOs.length; i++) {
        addImagesDTOs[i].position--;
      }
    });
  }

  Future<CropAspectRatioPresetCustom?> rewiewAspectRatio(File image) async {
    final decodedImage = await decodeImageFromList(image.readAsBytesSync());
    final width = decodedImage.width;
    final height = decodedImage.height;
    final String name = images.isEmpty ? 'first image' : 'other images';
    var aspectRatioPreset = CropAspectRatioPresetCustom(width, height, name);

    double aspectRatio = width.toDouble() / height.toDouble();
    if (aspectRatio < minPostImageAspectRatio || aspectRatio > maxPostImageAspectRatio) {
      if (context.mounted && mounted) {
        await widget.toastService.showErrorWithContext('Image aspect ratio must be between $minPostImageAspectRatio and $maxPostImageAspectRatio', context);
      }
      return null;
    }

    return aspectRatioPreset;
  }

  void uploadImg(XFile orig, File cropped) {
    UpdatePostImageScreenDTO newImage = UpdatePostImageScreenDTO(position: images.length);
    newImage.originalImage = orig;
    newImage.image = cropped;
    ImageDTO newImageDTO =
        ImageDTO(image: Image(image: FileImage(cropped), fit: BoxFit.fitHeight), originalPath: orig.path, isAspectRatioError: false, aspectRatioPreset: CropAspectRatioPresetCustom(1, 1, '1x1'));

    Future.microtask(() async {
      var res = await rewiewAspectRatio(cropped);
      if (res != null) {
        if (!mounted) return;
        setState(() {
          newImageDTO.aspectRatioPreset = res;
          addImagesDTOs.add(newImage);
          images.add(newImageDTO);
        });
      }
    });
  }

  void updateImg(int pos, File cropped) async {
    var aspectRatio = await rewiewAspectRatio(cropped);
    if (aspectRatio == null) {
      return;
    }
    if (!mounted) return;
    setState(() {
      images[pos].image = Image(image: FileImage(cropped), fit: BoxFit.fitHeight);

      addImagesDTOs[pos].image = cropped;
      addImagesDTOs[pos].onlineImage = null;
    });
    images[pos].aspectRatioPreset = aspectRatio;

    var firstImg = images[0];

    bool flag = false;
    for (var img in images) {
      if (!((img.aspectRatioPreset.width.toDouble() / img.aspectRatioPreset.height.toDouble() - firstImg.aspectRatioPreset.width.toDouble() / firstImg.aspectRatioPreset.height.toDouble()).abs() <=
          0.01)) {
        flag = true;
        if (!mounted) return;
        setState(() {
          img.isAspectRatioError = true;
        });
      } else {
        if (!mounted) return;
        setState(() {
          img.isAspectRatioError = false;
        });
      }
    }
    if (flag) {
      if (context.mounted && mounted) {
        Future.microtask(() async {
          if (context.mounted && mounted) {
            await widget.toastService.showErrorWithContext('Images must have the same aspect ratio', context);
          }
        });
      }
    }
    if (!mounted) return;
    setState(() {
      if (flag) {
        isAspectRatioError = true;
      } else {
        isAspectRatioError = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 26, 10, 30),
          child: Column(
            children: [
              Text(
                'Update Post',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              AddPostForm(
                  formKey: formKey,
                  descriptionController: descriptionController,
                  images: images,
                  onDelete: deleteImg,
                  onUpload: uploadImg,
                  onUpdate: updateImg,
                  isAspectRatioError: isAspectRatioError,
                  toastService: widget.toastService,
                  imageStorage: widget.imageStorage),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(addPostLocationScreenRoute, extra: addLocationRequest);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_pin, color: Theme.of(context).textTheme.bodySmall!.color),
                            const SizedBox(width: 5),
                            Text(
                              addLocationRequest.latitude > -200 ? "${double.parse((addLocationRequest.latitude).toStringAsFixed(7))} ${double.parse((addLocationRequest.longitude).toStringAsFixed(7))}" : 'Choose your location (optional)',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        if (addLocationRequest.latitude > -200)
                          IconButton(
                              onPressed: () {
                                if (!mounted) return;
                                setState(() {
                                  addLocationRequest.latitude = -200;
                                  addLocationRequest.longitude = -200;
                                });
                              },
                              icon: Icon(Icons.cancel_outlined, color: Theme.of(context).textTheme.bodySmall!.color))
                      ],
                    ),
                  )),
              Expanded(flex: 1, child: Container()),
              isLoading
                  ? const DotLoader()
                  : ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(width: 300),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async {
                            if (images.isEmpty) {
                              await widget.toastService.showError('Please add at least one image');
                              return;
                            }
                            if (images.length > maxImageCount) {
                              await widget.toastService.showError('You can add at most $maxImageCount images');
                              return;
                            }
                            if (formKey.currentState!.validate()) {
                              if(!mounted)return;
                              setState(() => isLoading = true);
                              List<UpdateImageRequest> updateImageRequests = [];
                              for (int i = 0; i < addImagesDTOs.length; i++) {
                                if (addImagesDTOs[i].image != null) {
                                  updateImageRequests.add(UpdateImageRequest(newImage: addImagesDTOs[i].image!, position: i));
                                } else if (addImagesDTOs[i].onlineImage != null) {
                                  updateImageRequests.add(UpdateImageRequest(oldImageId: addImagesDTOs[i].onlineImage!.id, position: i));
                                }
                              }
                              var res = await widget.repository.updatePost(UpdatePostRequest(
                                  id: widget.post.id, images: updateImageRequests, description: descriptionController.text, location: addLocationRequest.latitude > -200 ? addLocationRequest : null));
                              if(!mounted)return;
                              setState(() => isLoading = false);
                              if (res) {
                                _navigateToGroupListScreen();
                              }
                            }
                          },
                          style: specialTextButtonThemeData.style,
                          child: Text(
                            'Update',
                          ),
                        ),
                      ),
                    ),
            ],
          )),
    );
  }
}

class UpdatePostImageScreenDTO {
  File? image;
  XFile? originalImage;

  MyImageResponse? onlineOriginalImage;
  MyImageResponse? onlineImage;

  int position;
  bool isLocal = false;

  UpdatePostImageScreenDTO({
    required this.position,
    this.image,
    this.originalImage,
    this.isLocal = false,
    this.onlineOriginalImage,
    this.onlineImage,
  });
}
