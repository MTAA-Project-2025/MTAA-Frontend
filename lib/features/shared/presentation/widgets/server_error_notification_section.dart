import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';

/// Displays a server error notification with a retry action.
class ServerErrorNotificationSectionWidget extends StatelessWidget {
  final void Function() onPressed;

  /// Creates a [ServerErrorNotificationSectionWidget] with a retry callback.
  const ServerErrorNotificationSectionWidget({
    super.key,
    required this.onPressed,
  });

  /// Builds the UI with an error image, message, and retry button.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(padding: EdgeInsets.all(20), child: Image.asset('assets/images/kistune_server_error.png', fit: BoxFit.fitWidth)),
        const SizedBox(height: 20),
        Text('Server communication error', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));
            onPressed();
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
