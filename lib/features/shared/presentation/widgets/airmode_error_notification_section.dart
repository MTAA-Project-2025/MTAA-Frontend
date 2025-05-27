import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:open_settings_plus/core/open_settings_plus.dart';

/// Displays an error notification for airplane mode with options to open settings or retry.
class AirModeErrorNotificationSectionWidget extends StatelessWidget {
  final void Function() onPressed;

  /// Creates an [AirModeErrorNotificationSectionWidget] with a retry callback.
  const AirModeErrorNotificationSectionWidget({
    super.key,
    required this.onPressed,
  });

  /// Builds the UI with an SVG image, error message, and action buttons.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(padding: EdgeInsets.all(20), child: SvgPicture.asset('assets/svgs/kitsune_for_flight_mode.svg', fit: BoxFit.fitWidth)),
        const SizedBox(height: 20),
        Text('You are in airplane mode', style: Theme.of(context).textTheme.headlineLarge),
        Text('Please turn off airplane mode to load new posts', style: Theme.of(context).textTheme.bodyMedium),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                switch (OpenSettingsPlus.shared) {
                  case OpenSettingsPlusAndroid settings:
                    settings.airplaneMode();
                  case OpenSettingsPlusIOS settings:
                    settings.wifi();
                  default:
                    throw Exception('Platform not supported');
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.secondary,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Text('Open settings'),
            ),
            const SizedBox(width: 5),
            TextButton(
              onPressed: () async {
                context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));
                onPressed();
              },
              style: Theme.of(context).textButtonTheme.style!.copyWith(
                    minimumSize: WidgetStateProperty.all(Size(100, 39)),
                  ),
              child: Text('Try again'),
            ),
          ],
        )
      ],
    );
  }
}
