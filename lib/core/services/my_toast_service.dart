import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';

abstract class MyToastService {
  Future showError(String msg);
  Future showErrorWithContext(String msg, BuildContext context);

  Future showMsg(String msg);
  Future showMsgWithContext(String msg, BuildContext context);
}

class MyToastServiceImpl extends MyToastService {
  @override
  Future showError(String msg) async {
    BuildContext context = getIt<BuildContext>();
    showErrorWithContext(msg, context);
  }

  @override
  Future showErrorWithContext(String msg, BuildContext context) async {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
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
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  @override
  Future showMsg(String msg) async {
    BuildContext context = getIt<BuildContext>();
    showMsgWithContext(msg, context);
  }

  @override
  Future showMsgWithContext(String msg, BuildContext context) async {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
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
          Image.asset(
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
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }
}
