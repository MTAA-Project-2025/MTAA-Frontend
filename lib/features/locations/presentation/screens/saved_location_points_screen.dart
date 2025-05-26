import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/features/locations/presentation/widgets/saved_location_points_list.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';

/// Displays a screen with a list of saved location points.
class SavedLocationsPointsScreen extends StatefulWidget {
  final PostsRepository repository;

  /// Creates a [SavedLocationsPointsScreen] with required dependencies.
  const SavedLocationsPointsScreen({super.key, required this.repository});

  @override
  State<SavedLocationsPointsScreen> createState() => _SavedLocationsPointsScreenState();
}

/// Manages the state and UI for the saved locations screen.
class _SavedLocationsPointsScreenState extends State<SavedLocationsPointsScreen> {
  /// Builds the UI with a scrollable list of saved locations.
  @override
  Widget build(BuildContext contex) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Saved Locations'),
        ),
        body:
          SingleChildScrollView(
            child: SavedLocationsPointsList(
              repository: widget.repository,
            ),
          ),
        bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Map));
  }
}
