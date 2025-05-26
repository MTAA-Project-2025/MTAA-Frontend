import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';

/// Displays a notification for empty user data with an optional retry action.
class UsersEmptyErrorNotificationSectionWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final String imgPath;

  /// Creates a [UsersEmptyErrorNotificationSectionWidget] with required properties and optional retry callback.
  const UsersEmptyErrorNotificationSectionWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.imgPath = 'assets/svgs/kitsune_empty_array.svg'
  });

  /// Builds the UI with an SVG image, title, and optional retry button.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.all(20),
          child: SvgPicture.asset(imgPath, fit: BoxFit.fitWidth),
        ),
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 10),
        if (onPressed != null)
          TextButton(
            onPressed: () {
              context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));
              onPressed!();
            },
            style: Theme.of(context).textButtonTheme.style!.copyWith(
                  minimumSize: WidgetStateProperty.all(Size(100, 39)),
                ),
            child: Text('Try again'),
          ),
      ],
    );
  }
}
