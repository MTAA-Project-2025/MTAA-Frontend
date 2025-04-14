import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/customUpdateAccountAvatarRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountBirthDateRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountDisplayNameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountUsernameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/userFullAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/updateFieldWidget.dart';

class UpdateAccountScreen extends StatefulWidget {
  final AccountRepository repository;

  const UpdateAccountScreen({Key? key, required this.repository}) : super(key: key);

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  bool isLoading = false;
  bool isSaving = false;
  UserFullAccountResponse? user;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  File? selectedImageFile;
  
  @override
  void initState() {
    super.initState();

    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    setState(() {
      isLoading = true;
    });
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (!mounted) return;

    var res = await widget.repository.getFullAccount();

    if (res != null) {
      setState(() {
        user = res;
        usernameController.text = res.username;
        fullNameController.text = res.displayName;
        phoneController.text = res.phoneNumber ?? '';
        birthDateController.text = res.birthDate != null
    ? formatDate(res.birthDate!)
    : '13/05/2005';
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  DateTime? parseBirthDate(String text) {
    try {
      final parts = text.split('/');
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> saveUserData() async {
    if (user == null) return;

    setState(() {
      isSaving = true;
    });

    bool hasError = false;
    String errorMessage = '';

    if (usernameController.text != user!.username) {
      final usernameSuccess = await widget.repository.updateAccountUsername(
        UpdateAccountUsernameRequest(username: usernameController.text)
      );
      
      if (!usernameSuccess) {
        hasError = true;
        errorMessage = 'Failed to update username';
      }
    }

    // Update display name if changed
    if (!hasError && fullNameController.text != user!.displayName) {
      final displayNameSuccess = await widget.repository.updateAccountDisplayName(
        UpdateAccountDisplayNameRequest(displayName: fullNameController.text)
      );
      
      if (!displayNameSuccess) {
        hasError = true;
        errorMessage = 'Failed to update display name';
      }
    }

    // Update birth date if changed
    final parsedDate = parseBirthDate(birthDateController.text);
    final existingDate = user?.birthDate;

    if (!hasError &&
        parsedDate != null &&
        existingDate != null &&
        parsedDate != existingDate) {
      final birthDateSuccess = await widget.repository.updateAccountBirthDate(
        UpdateAccountBirthDateRequest(birthDate: parsedDate),
      );

      if (!birthDateSuccess) {
        hasError = true;
        errorMessage = 'Failed to update birth date';
      }
    }

    // Update avatar if a new image was selected
    if (!hasError && selectedImageFile != null) {
      final avatarSuccess = await widget.repository.customUpdateAccountAvatar(
        CustomUpdateAccountAvatarRequest(avatar: selectedImageFile!)
      );
      
      if (avatarSuccess == null) {
        hasError = true;
        errorMessage = 'Failed to update avatar';
      }
    }

    if (mounted) {
      setState(() {
        isSaving = false;
      });

      if (hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        GoRouter.of(context).pop();
        }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null && mounted) {
      setState(() {
        selectedImageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        actions: [
          if (!isLoading && !isSaving)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: saveUserData,
            ),
        ],
      ),
      body: isLoading
          ? const DotLoader()
          : isSaving
              ? const Center(child: CircularProgressIndicator(color: Color(0xFFFF7043)))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Profile Avatar
                      _buildProfileAvatar(),
                      
                      const SizedBox(height: 24),
                      
                      // Profile Fields
                      ProfileFieldEditor(
                        controller: usernameController,
                        iconPath: 'assets/icons/username_icon.png', 
                        label: 'Username',
                        hintText: 'Enter username',
                      ),
                      
                      const SizedBox(height: 16),
                      
                      ProfileFieldEditor(
                        controller: fullNameController,
                        iconPath: 'assets/icons/name_icon.png', 
                        label: 'Full name',
                        hintText: 'Enter full name',
                      ),
                      
                      const SizedBox(height: 16),
                      
                      ProfileFieldEditor(
                        controller: birthDateController,
                        iconPath: 'assets/icons/birthday_icon.png', 
                        label: 'Date of birth',
                        hintText: 'DD/MM/YYYY',
                        isDate: true,
                        onDateSelected: (date) {
                          // Format the selected date to your required format
                          final day = date.day.toString().padLeft(2, '0');
                          final month = date.month.toString().padLeft(2, '0');
                          final year = date.year.toString();
                          birthDateController.text = '$day/$month/$year';
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      ProfileFieldEditor(
                        controller: phoneController,
                        iconPath: 'assets/icons/phone_icon.png', 
                        label: 'Phone number',
                        hintText: 'Enter phone number',
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: const PhoneBottomMenu(sellectedType: MenuButtons.Home),
    );
  }

  Widget _buildProfileAvatar() {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: selectedImageFile != null
                ? FileImage(selectedImageFile!) as ImageProvider
                : (user?.avatar?.images.isNotEmpty == true 
                  ? NetworkImage(user!.avatar!.images.first.fullPath) 
                  : const AssetImage('assets/default_avatar.png') as ImageProvider),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFFF7043),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  onPressed: () {
                    _showImagePickerOptions(context);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          user?.displayName ?? "",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF375563),
          ),
        ),
        Text(
          '@${user?.username ?? ""}',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF99A5AC),
          ),
        ),
      ],
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
