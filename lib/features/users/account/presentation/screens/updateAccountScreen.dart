import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_bloc.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_events.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_state.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountBirthDateRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountDisplayNameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountUsernameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/birthDateForm.dart';

/// Screen for updating user account details such as username, display name, and birth date.
class UpdateAccountScreen extends StatefulWidget {
  final AccountRepository repository;
  final MyToastService toastService;

  /// Creates an [UpdateAccountScreen] with required dependencies.
  const UpdateAccountScreen({super.key, required this.repository, required this.toastService});

  @override
  State<UpdateAccountScreen> createState() => _UpdateAccountScreenState();
}

/// Manages the state for updating account information.
class _UpdateAccountScreenState extends State<UpdateAccountScreen> {
  bool isLoading = false;
  final AccountRepository repository = getIt<AccountRepository>();
  File? selectedCustomImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  /// Initializes state and loads account if necessary.
  @override
  void initState() {
    super.initState();
    final accountState = context.read<AccountBloc>().state;
    if (accountState.account == null) {
      loadAccount();
    }
  }

  /// Opens a dialog to edit a specific account field.
  void _editField(String fieldName, String currentValue, AccountState accountState, {bool isDateField = false}) {
    TextEditingController controller = TextEditingController(text: currentValue);
    final formKey = GlobalKey<FormState>();
    final requiredValidator = RequiredValidator(errorText: 'This field is required');
    final minLengthValidator = MinLengthValidator(3, errorText: 'Minimum 3 characters required');
    final Map<String, MultiValidator> _validators = {
      'username': MultiValidator([requiredValidator, minLengthValidator]),
      'full name': MultiValidator([requiredValidator]),
    };
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $fieldName', style: Theme.of(context).textTheme.headlineMedium),
        content: isDateField
            ? BirthDateForm(
                formKey: _formKey,
                onChanged: (date) async {
                  selectedDate = date;
                },
              )
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
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.secondary,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
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
                  if (accountState.account != null) {
                    var res = await widget.repository.updateAccountUsername(UpdateAccountUsernameRequest(username: controller.text));
                    if (res) {
                      if (!mounted || !context.mounted) return;
                      context.read<AccountBloc>().add(ChangeAccountUsernameEvent(newUsername: controller.text));
                    }
                  }
                  break;
                case 'full name':
                  var res = await widget.repository.updateAccountDisplayName(UpdateAccountDisplayNameRequest(displayName: controller.text));
                  if (res) {
                    if (accountState.account != null) {
                      if (!mounted) return;
                      context.read<AccountBloc>().add(ChangeAccountDisplayNameEvent(newDisplayName: controller.text));
                    }
                  }
                  break;
                case 'date of birth':
                  if (selectedDate == null) return;
                  var res = await widget.repository.updateAccountBirthDate(UpdateAccountBirthDateRequest(birthDate: selectedDate!));
                  if (res) {
                    if (!mounted) return;
                    if (accountState.account != null) {
                      context.read<AccountBloc>().add(ChangeAccountBirthdateEvent(newBirthdate: selectedDate!));
                    }
                  }
                  break;
                default:
                  break;
              }
              if (!mounted || !context.mounted) return;
              Navigator.pop(context);
              if (!mounted || !context.mounted) return;
              widget.toastService.showMsg('$fieldName updated successfully');
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  /// Loads account data from the repository.
  Future loadAccount() async {
    if (isLoading) return;
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    var res = await widget.repository.getFullAccount();
    if (res != null) {
      if (!mounted || !context.mounted) return;
      context.read<AccountBloc>().add(LoadAccountEvent(account: res));
    }
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  /// Builds the main UI with profile content or loading indicator.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, accountState) {
      return Scaffold(
        appBar: AppBar(),
        body: isLoading
            ? const Center(child: DotLoader())
            : SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: _buildProfileContent(context, accountState),
                ),
              ),
        bottomNavigationBar: const PhoneBottomMenu(sellectedType: MenuButtons.Profile),
      );
    });
  }

  /// Resolves the image provider for the account avatar.
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

  /// Builds the profile content with editable fields.
  Widget _buildProfileContent(BuildContext context, AccountState accountState) {
    final username = accountState.account?.username ?? "@username";
    final fullName = accountState.account?.displayName ?? "User";
    String birthDate = "none";
    if (accountState.account?.birthDate != null) {
      birthDate = DateFormat('dd MMMM yyyy').format(accountState.account!.birthDate!);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipOval(
                      child: Image(
                        image: accountState.account!.avatar != null
                            ? NetworkImage(
                                accountState.account!.avatar!.images
                                    .firstWhere(
                                      (item) => item.width == 300,
                                      orElse: () => accountState.account!.avatar!.images.first,
                                    )
                                    .fullPath,
                              )
                            : const AssetImage('assets/images/kitsune_server_error.png'),
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
                        GoRouter.of(context).push(updateAccountAvatarRoute);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Divider(
              color: Color(0xFFE0E0E0),
              thickness: 1,
            ),
          ),
          _buildEditableField(Icons.person, "Username", username, () => _editField("Username", username.replaceFirst('@', ''), accountState)),
          _buildEditableField(Icons.badge, "Full name", fullName, () => _editField("Full Name", fullName, accountState)),
          _buildEditableField(Icons.calendar_today, "Date of birth", birthDate, () => _editField("Date of Birth", birthDate, accountState, isDateField: true)),
        ],
      ),
    );
  }

  /// Builds an editable field row with icon, label, and edit button.
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
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: theme.colorScheme.primary, size: 24),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.bodySmall),
                  const SizedBox(height: 2),
                  Text(value, style: theme.textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.edit, color: theme.colorScheme.primary, size: 24),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}
