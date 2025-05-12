import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/add_post_screen.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/full_data_time_input.dart';

class AddSchedulePostDateScreen extends StatefulWidget {
  final MyToastService toastService;
  final AddScheduleDateDTO addDateDTO;

  const AddSchedulePostDateScreen({super.key, required this.toastService, required this.addDateDTO});

  @override
  State<AddSchedulePostDateScreen> createState() => _AddSchedulePostDateScreenState();
}

class _AddSchedulePostDateScreenState extends State<AddSchedulePostDateScreen> {
  DateTime? selectedDate;
  final GlobalKey<FormState> birthDateFormKey = GlobalKey<FormState>();
  final mapController = MapController();

  @override
  void initState() {
    super.initState();
  }

  void navigateBack() {
    Future.microtask(() async {
      if (!mounted && !context.mounted) return;
      GoRouter.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Schedule Date'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Text(
              'Add Schedule Date',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 18),
            Center(
              child: SizedBox(
                  height: 65,
                  child: FullDateTimeInput(
                    placeholder: 'Schedule date',
                    onChanged: (date) async {
                      if (!mounted) return;
                      if (date.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch) {
                        widget.toastService.showErrorWithContext('Please select a valid date in the future', context);
                        return;
                      }
                      if(!mounted)return;
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    minDate: DateTime.now().subtract(Duration(days: 1)),
                    maxDisplayedDate: DateTime.now().add(Duration(days: 356)),
                    maxDate: DateTime.now().add(Duration(days: 356)),
                    initialDate: widget.addDateDTO.date==null ? DateTime.now() : widget.addDateDTO.date!,
                    initialIsFirstTime: widget.addDateDTO.date!=null ? false : true,
                  )),
            ),
            const SizedBox(height: 19),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    navigateBack();
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
                    if (selectedDate == null) {
                      widget.toastService.showErrorWithContext('Please select an schedule date', context);
                      return;
                    }
                    widget.addDateDTO.date = selectedDate!;
                    navigateBack();
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: Text(
                    'Save',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
