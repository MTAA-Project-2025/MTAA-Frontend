import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';

class EmptyErrorNotificationSectionWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final String imgPath;
  final double aspectRatio;

  const EmptyErrorNotificationSectionWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.imgPath = 'assets/svgs/kitsune_empty_array.svg',
    this.aspectRatio = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: SvgPicture.asset(imgPath, fit: BoxFit.fitWidth),
          ),
        ),
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 10),
        if (onPressed != null)
          TextButton(
            key: const Key('try_again_button'),
            onPressed: () {
              context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));
              onPressed!();
            },
            style: Theme.of(context).textButtonTheme.style!.copyWith(
                  minimumSize: WidgetStateProperty.all(Size(100, 39)),
                ),
            child: Text(
              'Try again',
            ),
          ),
      ],
    );
  }
}
