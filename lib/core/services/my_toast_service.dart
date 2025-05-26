import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';

/// Defines methods for displaying toast notifications.
abstract class MyToastService {
  /// Shows an error toast with a message.
  Future showError(String msg);
  
  /// Shows an error toast with a message using a specific context.
  Future showErrorWithContext(String msg, BuildContext context);

  /// Shows a general message toast.
  Future showMsg(String msg);
  
  /// Shows a general message toast using a specific context.
  Future showMsgWithContext(String msg, BuildContext context);
}

/// Implements toast notifications with custom error and message displays.
class MyToastServiceImpl extends MyToastService {
  /// Shows an error toast using the default context.
  @override
  Future showError(String msg) async {
    BuildContext context = getIt<BuildContext>();
    showErrorWithContext(msg, context);
  }

  /// Shows an error toast with a custom UI and message.
  @override
  Future showErrorWithContext(String msg, BuildContext context) async {
    if (!context.mounted) return;
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = IntrinsicHeight(
        child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          left: BorderSide(color: errorColor, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/glitched_logo.png',
            width: 65,
            height: 64,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Error",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: errorColor),
                ),
                const SizedBox(height: 5),
                Text(
                  msg,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    ));

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3)
    );
  }

  /// Shows a general message toast using the default context.
  @override
  Future showMsg(String msg) async {
    BuildContext context = getIt<BuildContext>();
    showMsgWithContext(msg, context);
  }

  /// Shows a general message toast with a custom UI.
  @override
  Future showMsgWithContext(String msg, BuildContext context) async {
    if (!context.mounted) return;
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = IntrinsicHeight(
        child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          left: BorderSide(color: third1InvincibleColor, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svgs/small_logo.svg',
            width: 65,
            height: 64,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Message", style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 5),
                Text(
                  msg,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    ));

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }
}
