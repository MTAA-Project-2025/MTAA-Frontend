import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dataTimeInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountUsernameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicFullAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';

class UpdateAccountScreen extends StatefulWidget {
  final AccountRepository repository;
  final MyToastService toastService;

  const UpdateAccountScreen({super.key, required this.repository, required this.toastService});

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  bool isLoading = false;
  PublicFullAccountResponse? user;
  final AccountRepository repository = getIt<AccountRepository>();

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
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _editField(String fieldName, String currentValue, {bool isDateField = false}) {
    TextEditingController controller = TextEditingController(text: currentValue);
    final formKey = GlobalKey<FormState>();

    final requiredValidator = RequiredValidator(errorText: 'This field is required');
    final minLengthValidator = MinLengthValidator(3, errorText: 'Minimum 3 characters required');

    final Map<String, MultiValidator> _validators = {
      'username': MultiValidator([
        requiredValidator,
        minLengthValidator,
      ]),
      'full name': MultiValidator([
        requiredValidator,
      ]),
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit $fieldName',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        content: isDateField 
          ? _buildDatePicker(currentValue, fieldName) 
          : Form(
              key: formKey,
              child: CustomTextInput(
                placeholder: fieldName, 
                controller: controller,
                validator: _validators[fieldName.toLowerCase()],
              ),
            ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (!isDateField && !(formKey.currentState?.validate() ?? false)) {
                return;
              }

              switch (fieldName.toLowerCase()) {
                case 'username':
                  if (user != null) {
                    var res = await widget.repository.updateAccountUsername(
                      UpdateAccountUsernameRequest(username: controller.text)
                    );

                    if (res) {
                      setState(() {
                        user?.username = controller.text;
                      });
                    }
                  }
                  break;
                case 'full name':
                  if (user != null) {
                    setState(() {
                      user?.displayName = controller.text;
                    });
                  }
                  break;
                default:
                  break;
              }

              Navigator.pop(context);
              widget.toastService.showMsgWithContext('$fieldName updated successfully', context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(String currentDate, String fieldName) {
    List<String> dateParts = currentDate.split('/');
    DateTime initialDate = DateTime(
      int.parse(dateParts[2]),
      int.parse(dateParts[1]),
      int.parse(dateParts[0]),
    );

    DateTime selectedDate = initialDate;

    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Text('Current $fieldName: $currentDate'),
          const SizedBox(height: 20),
          DateTimeInput(
            placeholder: 'Select Date',
            onChanged: (pickedDate) {
              selectedDate = pickedDate;
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(child: DotLoader())
          : SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: _buildProfileContent(context),
              ),
            ),
      bottomNavigationBar: const PhoneBottomMenu(sellectedType: MenuButtons.Profile),
    );
  }

  ImageProvider<Object> getImage(MyImageResponse? img) {
  if (img == null) {
    return const AssetImage('assets/images/kistune_server_error.png');
  }

  if (img.fullPath.startsWith('http')) {
    return NetworkImage(img.fullPath);
  }

  final file = File(img.localPath);
  if (file.existsSync()) {
    return FileImage(file);
  }

  return const AssetImage('assets/images/kistune_server_error.png');
}

  Widget _buildProfileContent(BuildContext context) {
    final theme = Theme.of(context);
    final username = user?.username ?? "@username";
    final fullName = user?.displayName ?? "User";
    final birthDate = "";
    final phoneNumber = "";

    final avatarImage = getImage(user?.avatar?.images.first);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Avatar
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipOval(
                      child: Image(
                        image: avatarImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      color: theme.colorScheme.primary,
                      onPressed: () => GoRouter.of(context).push(updateAccountAvatarRoute),
                      style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.secondary,
                        shape: const CircleBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),

          // Fields
          _buildEditableField(Icons.person, "Username", username,
              () => _editField("Username", username.replaceFirst('@', ''))),
          _buildEditableField(Icons.badge, "Full name", fullName, () => _editField("Full Name", fullName)),
          _buildEditableField(Icons.calendar_today, "Date of birth", birthDate,
              () => _editField("Date of Birth", birthDate, isDateField: true)),
          _buildEditableField(Icons.phone, "Phone number", phoneNumber,
              () => _editField("Phone Number", phoneNumber)),

          const Divider(),

          // Share button
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.share, color: theme.colorScheme.primary),
                label: Text("Share", style: theme.textTheme.labelSmall),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: theme.dividerColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(IconData icon, String label, String value, VoidCallback onEdit) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: theme.colorScheme.primary, size: 20),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.bodySmall),
                  const SizedBox(height: 8),
                  Text(value, style: theme.textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.edit, color: theme.colorScheme.primary, size: 20),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}
