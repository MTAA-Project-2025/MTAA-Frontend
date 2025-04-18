import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountUsernameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicFullAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';

class UpdateAccountScreen extends StatefulWidget {
  final AccountRepository repository;
  final MyToastService toastService;

  const UpdateAccountScreen({Key? key, required this.repository, required this.toastService}) : super(key: key);

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

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit $fieldName',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        content: isDateField ? _buildDatePicker(currentValue, fieldName) : CustomTextInput(placeholder: fieldName, controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              switch (fieldName.toLowerCase()) {
                case 'username':
                  if (user != null) {
                    var res = await widget.repository.updateAccountUsername(UpdateAccountUsernameRequest(username: controller.text));

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
          ElevatedButton(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: initialDate,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                selectedDate = picked;
              }
            },
            child: const Text('Select Date'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          color: Colors.white,
          width: double.infinity,
          child: isLoading
              ? const Center(child: DotLoader())
              : SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Column(
                      children: [
                        _buildProfileContent(),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Profile));
  }

  Widget _buildProfileContent() {
    String username = user?.username ?? "@username";
    String fullName = user?.displayName ?? "User";
    String birthDate = "";
    String phoneNumber = "";
    String avatarUrl = user?.avatar?.images.first.fullPath ?? 'assets/default_avatar.png';

    ImageProvider<Object> avatarImage;
    if (avatarUrl.startsWith('http')) {
      avatarImage = NetworkImage(avatarUrl);
    } else {
      avatarImage = AssetImage(avatarUrl);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Profile Image and Name
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipOval(
                      child: Image(
                        image: user!.avatar != null
                            ? NetworkImage(
                                user!.avatar!.images
                                    .firstWhere(
                                      (item) => item.width == 300,
                                      orElse: () => user!.avatar!.images.first,
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

          // Divider
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Divider(
              color: Color(0xFFE0E0E0),
              thickness: 1,
            ),
          ),

          // Username Section
          _buildEditableField(
            icon: Icons.person,
            label: "Username",
            value: username,
            onEdit: () => _editField("Username", username.startsWith('@') ? username.substring(1) : username),
          ),

          // Full Name Section
          _buildEditableField(
            icon: Icons.badge,
            label: "Full name",
            value: fullName,
            onEdit: () => _editField("Full Name", fullName),
          ),

          // Date of Birth Section
          _buildEditableField(
            icon: Icons.calendar_today,
            label: "Date of birth",
            value: birthDate,
            onEdit: () => _editField("Date of Birth", birthDate, isDateField: true),
          ),

          // Phone Number Section
          _buildEditableField(
            icon: Icons.phone,
            label: "Phone number",
            value: phoneNumber,
            onEdit: () => _editField("Phone Number", phoneNumber),
          ),

          // Second Divider
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Divider(
              color: Color(0xFFE0E0E0),
              thickness: 1,
            ),
          ),

          // Share Button
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 326),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share, color: Color(0xFF375563)),
                  label: const Text(
                    "Share",
                    style: TextStyle(
                      color: Color(0xFF375563),
                      fontSize: 14,
                      fontFamily: "Almarai",
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.3,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onEdit,
  }) {
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
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF375563),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF99A5AC),
                      fontSize: 10,
                      fontFamily: "Almarai",
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.3,
                      height: 1.9,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFF375563),
                      fontSize: 14,
                      fontFamily: "Almarai",
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.3,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Color(0xFF375563),
              size: 20,
            ),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}
