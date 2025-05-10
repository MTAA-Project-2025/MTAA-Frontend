import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_image_hive.dart';
import 'package:mtaa_frontend/features/images/data/models/requests/add_image_request.dart';
import 'package:mtaa_frontend/features/images/data/storages/my_image_storage.dart';
import 'package:mtaa_frontend/features/images/domain/utils/cropAspectRatioPresetCustom.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/add_location_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/requests/add_post_request.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/add_post_form.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/themes/button_theme.dart';

class AddPostScreen extends StatefulWidget {
  final PostsRepository repository;
  final MyToastService toastService;
  final MyImageStorage imageStorage;

  const AddPostScreen({super.key, required this.repository, required this.toastService, required this.imageStorage});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final descriptionController = TextEditingController();
  String startStr = '';
  bool isLoading = false;
  bool isEdited = false;
  List<AddPostImageScreenDTO> addImagesDTOs = [];

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
      var hiveData = await widget.repository.getTempPostAddForm();
      if (hiveData != null) {
        if (!mounted) return;
        setState(() {
          descriptionController.text = hiveData.description;
          if (hiveData.location != null) {
            addLocationRequest = AddLocationRequest.fromHive(hiveData.location!);
          }

          bool flag = false;
          for (var img in hiveData.images) {
            var addImageDTO = AddPostImageScreenDTO.fromHive(img);
            var imageDTO = ImageDTO(
                image: Image(image: FileImage(File(img.imagePath)), fit: BoxFit.fitHeight),
                originalPath: img.origImagePath,
                isAspectRatioError: img.isAspectRatioError,
                aspectRatioPreset: CropAspectRatioPresetCustom(img.aspectRatioPreset!.width, img.aspectRatioPreset!.height, img.aspectRatioPreset!.name));

            addImagesDTOs.add(addImageDTO);
            images.add(imageDTO);
            if (imageDTO.isAspectRatioError) {
              flag = true;
            }
          }

          if (flag) isAspectRatioError = true;
        });
      }
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
    if (!mounted) return;
    setState(() {
      var addImgDTO = addImagesDTOs[pos];
      if (addImgDTO.isLocal) {
        if (addImgDTO.originalImageLocalPath != null) {
          imagePathsForDelete.add(addImgDTO.originalImageLocalPath!);
        }
        if (addImgDTO.imagePath != null) {
          imagePathsForDelete.add(addImgDTO.imagePath!);
        }
      }

      images.removeAt(pos);
      addImagesDTOs.removeAt(pos);
      for (int i = pos; i < addImagesDTOs.length; i++) {
        addImagesDTOs[i].position--;
      }
    });
    isEdited = true;
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
    if (!mounted) return;
    AddPostImageScreenDTO newImage = AddPostImageScreenDTO(position: images.length);
    newImage.originalImage = orig;
    newImage.image = cropped;

    ImageDTO newImageDTO =
        ImageDTO(image: Image(image: FileImage(cropped), fit: BoxFit.fitHeight), originalPath: orig.path, isAspectRatioError: false, aspectRatioPreset: CropAspectRatioPresetCustom(1, 1, '1x1'));

    Future.microtask(() async {
      var res = await rewiewAspectRatio(cropped);
      if(!mounted)return;
      setState(() {
        if (res != null) {
          newImageDTO.aspectRatioPreset = res;
          addImagesDTOs.add(newImage);
          images.add(newImageDTO);
        }
      });
    });
    if(!mounted)return;
    setState(() {
      isEdited = true;
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

      if (addImagesDTOs[pos].imagePath != null) {
        imagePathsForDelete.add(addImagesDTOs[pos].imagePath!);
        addImagesDTOs[pos].imagePath = null;
        addImagesDTOs[pos].image = cropped;
      }
      images[pos].aspectRatioPreset = aspectRatio;
    });

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
          await widget.toastService.showErrorWithContext('Images must have the same aspect ratio', context);
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
    isEdited = true;
  }

  Future<bool> _onWillPop() async {
    if (descriptionController.text.isNotEmpty || images.isNotEmpty || imagePathsForDelete.isNotEmpty) {
      var res = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Unsaved Changes'),
          content: Text('Do you want to save changes before leaving?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.secondary,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                minimumSize: Size(75, 39),
              ),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                if (descriptionController.text.isNotEmpty || images.isNotEmpty) {
                  await widget.repository.setTempPostAddForm(addImagesDTOs, images, descriptionController.text, addLocationRequest);
                } else {
                  await widget.repository.deleteTempPostAddForm();
                }
                for (var path in imagePathsForDelete) {
                  await widget.imageStorage.deleteImage(path);
                }
                Navigator.of(context).pop(true);
              },
              style: Theme.of(context).textButtonTheme.style!.copyWith(
                    minimumSize: WidgetStateProperty.all(Size(75, 39)),
                  ),
              child: Text('Yes'),
            ),
          ],
        ),
      );
      if (res == null) return false;
      return true;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[],
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(10, 26, 10, 30),
            child: Column(
              children: [
                Text(
                  'Create Post',
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
                                addLocationRequest.latitude > -200
                                    ? "${double.parse((addLocationRequest.latitude).toStringAsFixed(7))} ${double.parse((addLocationRequest.longitude).toStringAsFixed(7))}"
                                    : 'Choose your location (optional)',
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
                                if (!mounted) return;
                                setState(() => isLoading = true);
                                List<AddImageRequest> addImageRequests = [];
                                for (int i = 0; i < addImagesDTOs.length; i++) {
                                  if (addImagesDTOs[i].image != null) {
                                    addImageRequests.add(AddImageRequest(image: addImagesDTOs[i].image!, position: i));
                                  } else if (addImagesDTOs[i].imagePath != null) {
                                    addImageRequests.add(AddImageRequest(image: File(addImagesDTOs[i].imagePath!), position: i));
                                  }
                                }
                                var id = await widget.repository.addPost(
                                    AddPostRequest(images: addImageRequests, description: descriptionController.text, location: addLocationRequest.latitude > -200 ? addLocationRequest : null));
                                if (!mounted) return;
                                setState(() => isLoading = false);
                                if (id != null) {
                                  _navigateToGroupListScreen();
                                }
                              }
                            },
                            style: specialTextButtonThemeData.style,
                            child: Text(
                              'Create',
                            ),
                          ),
                        ),
                      ),
              ],
            )),
      ),
    );
  }
}

class AddPostImageScreenDTO {
  File? image;
  XFile? originalImage;

  String? originalImageLocalPath;
  String? imagePath;

  int position;
  bool isLocal = false;

  AddPostImageScreenDTO({
    required this.position,
    this.image,
    this.originalImage,
    this.isLocal = false,
    this.originalImageLocalPath,
    this.imagePath,
  });

  factory AddPostImageScreenDTO.fromHive(AddImageHive hive) {
    return AddPostImageScreenDTO(imagePath: hive.imagePath, originalImageLocalPath: hive.origImagePath, position: hive.position, isLocal: true);
  }
}
