import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:mtaa_frontend/features/images/data/network/preset_avatar_images_api.dart';
import 'package:mtaa_frontend/features/images/presentation/widgets/preset-images-list.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_bloc.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_events.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/customUpdateAccountAvatarRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/presetUpdateAccountAvatarRequest.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_event.dart';

class UpdateAvatarScreen extends StatefulWidget {
  final AccountRepository repository;
  final MyToastService toastService;

  const UpdateAvatarScreen({super.key, required this.repository, required this.toastService});

  @override
  State<UpdateAvatarScreen> createState() => _UpdateAvatarScreenState();
}

class _UpdateAvatarScreenState extends State<UpdateAvatarScreen> {
  final displayNameController = TextEditingController();
  bool isLoading = false;
  bool isError = false;
  MyImageGroupResponse? selectedPresetImage;
  File? selectedCustomImage;
  XFile? _pickedFile;

  @override
  void dispose() {
    displayNameController.dispose();
    super.dispose();
  }

  void _navigateBackScreen() {
    Future.microtask(() {
      if (!mounted) return;
      GoRouter.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 21, 0),
              child: IconButton(
                icon: const Icon(Icons.dark_mode),
                tooltip: 'Change theme',
                onPressed: () {
                  context.read<ThemeBloc>().add(ToggleThemeEvent());
                },
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Text(
              'Update Profile Picture',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 9),
            Text(
              'Choose a photo that fits you',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            if (selectedCustomImage != null || selectedPresetImage != null)
              SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipOval(
                        child: Image(
                          image: selectedPresetImage != null
                              ? NetworkImage(
                                  selectedPresetImage!.images
                                      .firstWhere(
                                        (item) => item.width == 300,
                                        orElse: () => selectedPresetImage!.images.first,
                                      )
                                      .fullPath,
                                )
                              : FileImage(selectedCustomImage!) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: Icon(Icons.add, color: whiteColor),
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
                          _uploadImage(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 32),
            if (selectedCustomImage != null || selectedPresetImage != null)
              Text(
                'or choose an avatar from Likely',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: PresetImagesList(
                  onChanged: (image) {
                    setState(() {
                      selectedPresetImage = image;
                      selectedCustomImage = null;
                      _pickedFile = null;
                    });
                  },
                  presetAvatarImagesApi: getIt<PresetAvatarImagesApi>()),
            ),
            const SizedBox(height: 19),
            isLoading
                ? const DotLoader()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.secondary,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Text(
                          'Cancel',
                        ),
                      ),
                      const SizedBox(width: 5),
                      TextButton(
                        onPressed: () async {
                          if (selectedPresetImage == null && selectedCustomImage == null) {
                            setState(() {
                              isError = true;
                            });
                            return;
                          } else {
                            isError = false;
                            setState(() => isLoading = true);

                            MyImageGroupResponse? res;
                            if (selectedPresetImage != null) {
                              res = await widget.repository.presetUpdateAccountAvatar(PresetUpdateAccountAvatarRequest(imageGroupId: selectedPresetImage!.id));
                            } else if (selectedCustomImage != null) {
                              res = await widget.repository.customUpdateAccountAvatar(CustomUpdateAccountAvatarRequest(avatar: selectedCustomImage!));
                            }
                            setState(() => isLoading = false);
                            if (res != null) {
                              if (context.mounted) {
                                context.read<AccountBloc>().add(ChangeAccountAvatarEvent(newImage: res));
                              }
                              _navigateBackScreen();
                            }
                          }
                        },
                        style: Theme.of(context).textButtonTheme.style,
                        child: Text(
                          'Update',
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Future<void> _uploadImage(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (!isImage(pickedFile)) {
        if (context.mounted && mounted) {
          await widget.toastService.showErrorWithContext('Image is not valid', context);
        }
        return;
      }

      setState(() {
        _pickedFile = pickedFile;
        _cropImage(context);
      });
    }
  }

  Future<void> _cropImage(BuildContext context) async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).appBarTheme.backgroundColor,
            toolbarWidgetColor: Theme.of(context).appBarTheme.foregroundColor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioLockEnabled: true,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
          WebUiSettings(
            context: context,
            presentStyle: WebPresentStyle.dialog,
            initialAspectRatio: 1,
            size: const CropperSize(
              width: 300,
              height: 300,
            ),
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          selectedCustomImage = File(croppedFile.path);
          _pickedFile = null;
          selectedPresetImage = null;
        });
      }
    }
  }
}
