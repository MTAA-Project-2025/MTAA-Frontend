import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/features/images/data/models/requests/add_image_request.dart';
import 'package:mtaa_frontend/features/images/domain/utils/cropAspectRatioPresetCustom.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/themes/button_theme.dart';

class AddPostScreen extends StatefulWidget {
  final PostsRepository repository;
  final MyToastService toastService;

  const AddPostScreen({super.key, required this.repository, required this.toastService});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final descriptionController = TextEditingController();
  bool isLoading = false;
  List<AddImageRequest> images = [];
  List<XFile> origs = [];
  int currentPos = 0;
  bool isAspectRatioError = false;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void _navigateToGroupListScreen() {
    Future.microtask(() {
      if (!mounted) return;
      GoRouter.of(context).go(userGroupListScreenRoute);
    });
  }

  void deleteImg(int pos) {
    setState(() {
      List<AddImageRequest> newImages = [];
      for (int i = 0; i < images.length; i++) {
        if (i < pos) {
          newImages.add(images[i]);
        } else if (i > pos) {
          newImages.add(images[i]);
          newImages[i - 1].position--;
        }
      }
      images = newImages;
      origs.removeAt(currentPos);
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
                  'Create Post',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 20),
                Container(
                    height: 200,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      cacheExtent: 9999,
                      itemCount: images.length + 1,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 10);
                      },
                      itemBuilder: (context, index) {
                        if (index < images.length) {
                          return Container(
                              height: 100,
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      currentPos = index;
                                      _cropImage(context, false);
                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: ColorFiltered(
                                            colorFilter: images[index].isAspectRatioError
                                                ? ColorFilter.mode(errorColor.withAlpha(200), BlendMode.multiply)
                                                : ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                                            child: Image(
                                              image: FileImage(images[index].image),
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: IconButton(
                                      icon: Icon(Icons.close_rounded, weight: 800),
                                      style: Theme.of(context).textButtonTheme.style!.copyWith(
                                            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(8)),
                                            minimumSize: WidgetStateProperty.all(Size(0, 0)),
                                            shape: WidgetStateProperty.all<OutlinedBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(1000),
                                              ),
                                            ),
                                          ),
                                      onPressed: () {
                                        deleteImg(index);
                                      },
                                    ),
                                  ),
                                ],
                              ));
                        }

                        return AspectRatio(
                            aspectRatio: images.isEmpty ? 1 : images[0].aspectRatioPreset!.width / images[0].aspectRatioPreset!.height,
                            child: GestureDetector(
                                onTap: () {
                                  currentPos = images.length;
                                  _uploadImage(context);
                                },
                                child: IconButton(
                                  onPressed: () {
                                    currentPos = images.length;
                                    _uploadImage(context);
                                  },
                                  style: IconButton.styleFrom(
                                    backgroundColor: Theme.of(context).secondaryHeaderColor.withAlpha(25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: secondary1InvincibleColor,
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Icon(Icons.add_rounded, color: whiteColor, size: 36),
                                  ),
                                )));
                      },
                    )),
                if (isAspectRatioError)
                  Padding(
                      padding: EdgeInsets.fromLTRB(10,20,10,10),
                      child: Text(
                        'All images should have the same aspect ratio. Please change the aspect ratio of conflicted images',
                        style: Theme.of(context).textTheme.labelSmall,
                      )),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextInput(placeholder: 'Description', controller: descriptionController, validator: descriptionValidator, maxLines: 5),
                ),
                const SizedBox(height: 20),
                Expanded(flex: 1, child: Container()),
                isLoading
                    ? const DotLoader()
                    : ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(width: 300),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              GoRouter.of(context).push(logInScreenRoute);
                            },
                            style: specialTextButtonThemeData.style,
                            child: Text(
                              'Create',
                            ),
                          ),
                        ),
                      ),
              ],
            )));
  }

  bool isImageUploadActive = false;
  Future<void> _uploadImage(BuildContext context) async {
    if (isImageUploadActive) return;
    isImageUploadActive = true;
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    isImageUploadActive = false;
    if (pickedFile != null) {
      if (!isImage(pickedFile)) {
        if (context.mounted && mounted) {
          await widget.toastService.showErrorWithContext('Image is not valid', context);
        }
        return;
      }

      setState(() {
        currentPos = images.length;
        origs.add(pickedFile);
      });
      if (mounted && context.mounted) {
        await _cropImage(context, true);
      }
    }
  }

  Future<void> _cropImage(BuildContext context, bool isFromUpload) async {
    if (currentPos >= 0 && currentPos < origs.length) {
      List<CropAspectRatioPresetCustom> aspectRatios = [];
      for (int i = 0; i < images.length; i++) {
        if (aspectRatios.any((e) => (e.width.toDouble() / e.height.toDouble() - images[i].aspectRatioPreset!.width.toDouble() / images[i].aspectRatioPreset!.height.toDouble()).abs() <= 0.01)) {
          continue;
        }
        aspectRatios.add(images[i].aspectRatioPreset!);
      }
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: origs[currentPos].path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).appBarTheme.backgroundColor,
            toolbarWidgetColor: Theme.of(context).appBarTheme.foregroundColor,
            initAspectRatio: aspectRatios.isEmpty ? CropAspectRatioPreset.square : aspectRatios[0],
            lockAspectRatio: aspectRatios.isNotEmpty && isFromUpload || !isFromUpload && images[currentPos].isAspectRatioError,
            aspectRatioPresets: aspectRatios.isEmpty
                ? [
                    CropAspectRatioPreset.square,
                  ]
                : aspectRatios,
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioLockEnabled: !(aspectRatios.isNotEmpty && isFromUpload || !isFromUpload && images[currentPos].isAspectRatioError),
            aspectRatioPresets: aspectRatios.isEmpty
                ? [
                    CropAspectRatioPreset.square,
                  ]
                : aspectRatios,
          ),
          WebUiSettings(
            context: context,
            presentStyle: WebPresentStyle.dialog,
            initialAspectRatio: 1,
          ),
        ],
      );
      if (croppedFile != null) {
        AddImageRequest image = AddImageRequest(image: File(croppedFile.path), position: currentPos);

        final decodedImage = await decodeImageFromList(image.image.readAsBytesSync());
        final width = decodedImage.width;
        final height = decodedImage.height;
        final String name = currentPos == 0 ? 'first image' : 'other images';
        image.aspectRatioPreset = CropAspectRatioPresetCustom(width, height, name);

        double aspectRatio = width.toDouble() / height.toDouble();
        if (aspectRatio < minPostImageAspectRatio || aspectRatio > maxPostImageAspectRatio) {
          if (context.mounted && mounted) {
            await widget.toastService.showErrorWithContext('Image aspect ratio must be between $minPostImageAspectRatio and $maxPostImageAspectRatio',context);
          }
          if (isFromUpload) {
            origs.removeAt(currentPos);
          }
          return;
        }
        setState(() {
          if (currentPos < images.length) {
            images[currentPos] = image;
          } else {
            images.add(image);
          }
        });

        if (!isFromUpload) {
          var firstImg = images[0];
          bool flag = false;
          for (var img in images) {
            if (!((img.aspectRatioPreset!.width.toDouble() / img.aspectRatioPreset!.height.toDouble() - firstImg.aspectRatioPreset!.width.toDouble() / firstImg.aspectRatioPreset!.height.toDouble())
                    .abs() <=
                0.01)) {
              flag = true;
              setState(() {
                img.isAspectRatioError = true;
              });
            } else {
              setState(() {
                img.isAspectRatioError = false;
              });
            }
          }
          if (flag) {
            if (context.mounted && mounted) {
              await widget.toastService.showErrorWithContext('Images must have the same aspect ratio', context);
            }
          }
          setState(() {
            if (flag) {
              isAspectRatioError = true;
            } else {
              isAspectRatioError = false;
            }
          });
        }
      }
    }
  }
}
