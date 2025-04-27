import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/locations/presentation/widgets/saved_location_points_list.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';

class SavedLocationsPointsScreen extends StatefulWidget {
  final PostsRepository repository;

  const SavedLocationsPointsScreen({super.key, required this.repository});

  @override
  State<SavedLocationsPointsScreen> createState() => _SavedLocationsPointsScreenState();
}

class _SavedLocationsPointsScreenState extends State<SavedLocationsPointsScreen> {
  @override
  void initState() {
    super.initState();
    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Saved Locations'),
        ),
        body: Column(children: [
          SavedLocationsPointsList(
            repository: widget.repository,
          ),
        ]),
        bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Map));
  }
}
