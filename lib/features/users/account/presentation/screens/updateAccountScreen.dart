import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountBirthDateRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountDisplayNameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountUsernameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/userFullAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/customUpdateAccountAvatarRequest.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdateAccountScreen extends StatefulWidget {
  final AccountRepository repository;

  const UpdateAccountScreen({super.key, required this.repository});

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  bool isLoading = false;
  bool isSaving = false;
  UserFullAccountResponse? user;
  
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _displayNameController = TextEditingController();
  DateTime? _birthDate;
  File? _imageFile;
  bool _hasUsernameChanged = false;
  bool _hasDisplayNameChanged = false;
  bool _hasBirthDateChanged = false;
  bool _hasAvatarChanged = false;

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
    
    Future.microtask(() async {
      if (!mounted) return;

      var res = await widget.repository.getFullAccount();

      if (res != null) {
        setState(() {
          user = res;
          _usernameController.text = res.username;
          _displayNameController.text = res.displayName;
          _birthDate = res.birthDate;
        });
      }
      
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
        _hasBirthDateChanged = true;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _hasAvatarChanged = true;
      });
    }
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSaving = true;
      });

      bool allSuccess = true;
      String errorMessage = '';

      try {
        // Update username if changed
        if (_hasUsernameChanged) {
          final usernameRequest = UpdateAccountUsernameRequest(
            username: _usernameController.text,
          );
          final usernameResult = await widget.repository.updateAccountUsername(usernameRequest);
          if (!usernameResult) {
            allSuccess = false;
            errorMessage += 'Failed to update username. ';
          }
        }

        // Update display name if changed
        if (_hasDisplayNameChanged) {
          final displayNameRequest = UpdateAccountDisplayNameRequest(
            displayName: _displayNameController.text,
          );
          final displayNameResult = await widget.repository.updateAccountDisplayName(displayNameRequest);
          if (!displayNameResult) {
            allSuccess = false;
            errorMessage += 'Failed to update display name. ';
          }
        }

        // Update birth date if changed
        if (_hasBirthDateChanged && _birthDate != null) {
          final birthDateRequest = UpdateAccountBirthDateRequest(
            birthDate: _birthDate!,
          );
          final birthDateResult = await widget.repository.updateAccountBirthDate(birthDateRequest);
          if (!birthDateResult) {
            allSuccess = false;
            errorMessage += 'Failed to update birth date. ';
          }
        }

        // Update avatar if changed
        if (_hasAvatarChanged && _imageFile != null) {
          final avatarRequest = CustomUpdateAccountAvatarRequest(
            avatar: _imageFile!,
          );
          final avatarResult = await widget.repository.customUpdateAccountAvatar(avatarRequest);
          if (avatarResult == null) {
            allSuccess = false;
            errorMessage += 'Failed to update avatar. ';
          }
        }

        if (mounted) {
          if (allSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );
            GoRouter.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage.isEmpty ? 'Failed to update profile' : errorMessage)),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            isSaving = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: isSaving ? null : _saveChanges,
            child: isSaving 
              ? const SizedBox(
                  width: 20, 
                  height: 20, 
                  child: CircularProgressIndicator(strokeWidth: 2)
                )
              : const Text('Save'),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: DotLoader())
          : user == null
              ? const Center(child: Text('Failed to load user data'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile picture
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: _imageFile != null
                                    ? FileImage(_imageFile!) as ImageProvider
                                    : user!.avatar?.images.isNotEmpty == true
                                        ? NetworkImage(user!.avatar!.images.first.fullPath)
                                        : const AssetImage('assets/default_avatar.png') as ImageProvider,
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Theme.of(context).primaryColor,
                                  child: IconButton(
                                    icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                                    onPressed: _pickImage,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Username
                        _buildTextField(
                          label: 'Username',
                          controller: _usernameController,
                          icon: Icons.alternate_email,
                          onChanged: (value) {
                            if (value != user!.username) {
                              setState(() {
                                _hasUsernameChanged = true;
                              });
                            } else {
                              setState(() {
                                _hasUsernameChanged = false;
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is required';
                            }
                            if (value.length < 3) {
                              return 'Username must be at least 3 characters';
                            }
                            return null;
                          },
                        ),
                        
                        // Display Name
                        _buildTextField(
                          label: 'Full Name',
                          controller: _displayNameController,
                          icon: Icons.person,
                          onChanged: (value) {
                            if (value != user!.displayName) {
                              setState(() {
                                _hasDisplayNameChanged = true;
                              });
                            } else {
                              setState(() {
                                _hasDisplayNameChanged = false;
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Full name is required';
                            }
                            return null;
                          },
                        ),
                        
                        // Birth Date
                        InkWell(
                          onTap: () => _selectDate(context),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
                              prefixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              _birthDate == null 
                                ? 'Select date' 
                                : DateFormat('dd/MM/yyyy').format(_birthDate!),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Phone number (read-only)
                        if (user!.phoneNumber != null)
                          _buildReadOnlyField(
                            label: 'Phone Number',
                            value: user!.phoneNumber!,
                            icon: Icons.phone,
                          ),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Profile),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(value),
      ),
    );
  }
}
