import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/features/images/data/storages/my_image_storage.dart';
import 'package:mtaa_frontend/features/images/domain/utils/cropAspectRatioPresetCustom.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';

class AddPostForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController descriptionController;
  final List<ImageDTO> images;
  final void Function(int) onDelete;
  final void Function(XFile, File) onUpload;
  final void Function(int, File) onUpdate;

  final bool isAspectRatioError;
  final MyToastService toastService;
  final MyImageStorage imageStorage;

  const AddPostForm(
      {super.key,
      required this.formKey,
      required this.descriptionController,
      required this.images,
      required this.onDelete,
      required this.onUpload,
      required this.onUpdate,
      required this.isAspectRatioError,
      required this.toastService,
      required this.imageStorage});

  @override
  State<AddPostForm> createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  int currentPos = 0;
  XFile? pickedFile;
  List<String> imagesForDelete = [];

  @override
  void dispose() {
    Future.microtask(() async {
      for (var path in imagesForDelete) {
        widget.imageStorage.deleteImage(path);
      }
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(children: [
          SizedBox(
              height: 200,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                cacheExtent: 9999,
                itemCount: widget.images.length < 10 ? widget.images.length + 1 : 10,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 10);
                },
                itemBuilder: (context, index) {
                  if (index < widget.images.length) {
                    return SizedBox(
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
                                      colorFilter: widget.images[index].isAspectRatioError
                                          ? ColorFilter.mode(errorColor.withAlpha(200), BlendMode.multiply)
                                          : ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                                      child: widget.images[index].image)),
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
                                  widget.onDelete.call(index);
                                },
                              ),
                            ),
                          ],
                        ));
                  }

                  return AspectRatio(
                      aspectRatio: widget.images.isEmpty ? 1 : widget.images[0].aspectRatioPreset.width / widget.images[0].aspectRatioPreset.height,
                      child: GestureDetector(
                          onTap: () {
                            currentPos = widget.images.length;
                            _uploadImage(context);
                          },
                          child: IconButton(
                            onPressed: () {
                              currentPos = widget.images.length;
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
          if (widget.isAspectRatioError)
            Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Text(
                  'All images should have the same aspect ratio. Please change the aspect ratio of conflicted images',
                  style: Theme.of(context).textTheme.labelSmall,
                )),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CustomTextInput(placeholder: 'Description', controller: widget.descriptionController, validator: descriptionValidator, maxLines: 5),
          ),
        ]));
  }

  bool isImageUploadActive = false;
  Future<void> _uploadImage(BuildContext context) async {
    if (isImageUploadActive) return;
    isImageUploadActive = true;
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    isImageUploadActive = false;
    if (pickedFile != null) {
      if (!isImage(pickedFile!)) {
        if (context.mounted && mounted) {
          await widget.toastService.showErrorWithContext('Image is not valid', context);
        }
        return;
      }
      if (mounted && context.mounted) {
        await _cropImage(context, true);
      }
    }
  }

  Future<void> _cropImage(BuildContext context, bool isFromUpload) async {
    if (currentPos >= 0) {
      List<CropAspectRatioPresetCustom> aspectRatios = [];
      for (int i = 0; i < widget.images.length; i++) {
        if (aspectRatios
            .any((e) => (e.width.toDouble() / e.height.toDouble() - widget.images[i].aspectRatioPreset.width.toDouble() / widget.images[i].aspectRatioPreset.height.toDouble()).abs() <= 0.01)) {
          continue;
        }
        aspectRatios.add(widget.images[i].aspectRatioPreset);
      }
      String originalPath = '';
      if (isFromUpload) {
        originalPath = pickedFile!.path;
      } else {
        if (widget.images[currentPos].originalPath.startsWith('http')) {
          var data = await widget.imageStorage.urlToUint8List(widget.images[currentPos].originalPath);
          if (data != null) {
            originalPath = await widget.imageStorage.saveStortLifeTempImage(data, 'original_img');
            widget.images[currentPos].originalPath = originalPath;
            imagesForDelete.add(originalPath);
          } else {
            if (context.mounted && mounted) {
              await widget.toastService.showErrorWithContext('Internal storage error', context);
            }
            return;
          }
        }
      }

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: originalPath,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).appBarTheme.backgroundColor,
            toolbarWidgetColor: Theme.of(context).appBarTheme.foregroundColor,
            initAspectRatio: aspectRatios.isEmpty ? CropAspectRatioPreset.square : aspectRatios[0],
            lockAspectRatio: aspectRatios.isNotEmpty && isFromUpload || !isFromUpload && widget.images[currentPos].isAspectRatioError,
            aspectRatioPresets: aspectRatios.isEmpty
                ? [
                    CropAspectRatioPreset.square,
                  ]
                : aspectRatios,
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioLockEnabled: !(aspectRatios.isNotEmpty && isFromUpload || !isFromUpload && widget.images[currentPos].isAspectRatioError),
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
        if (isFromUpload) {
          widget.onUpload.call(pickedFile!, File(croppedFile.path));
        } else {
          widget.onUpdate.call(currentPos, File(croppedFile.path));
        }
      }
    }
  }
}

class ImageDTO {
  Image image;
  String originalPath;
  bool isAspectRatioError;
  CropAspectRatioPresetCustom aspectRatioPreset;

  ImageDTO({required this.image, required this.originalPath, required this.isAspectRatioError, required this.aspectRatioPreset});
}
