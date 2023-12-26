import 'package:flutter/material.dart';
import 'package:timekeeping/configs/themes/colors.dart';

class Action {
  final String text;
  final Color? color;
  final Function()? onPressed;

  Action({
    required this.text,
    this.color,
    this.onPressed,
  });
}

class Params {
  final String title;
  final String message;
  final List<Action>? actions;
  final Function()? onDismiss;

  Params({
    required this.title,
    required this.message,
    this.actions,
    this.onDismiss,
  });
}

class DialogHelper {
  static void show({
    required BuildContext context,
    required Params params,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Text(params.title),
          titleTextStyle: const TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          content: Text(params.message),
          contentTextStyle: TextStyle(
            color: AppColors.black.withOpacity(0.5),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          actions: params.actions != null
              ? params.actions?.map((action) {
                  return TextButton(
                    child: Text(
                      action.text,
                      style: TextStyle(
                        color: action.color ?? AppColors.black.withOpacity(0.6),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (action.onPressed != null) {
                        action.onPressed!();
                      }
                    },
                  );
                }).toList()
              : [
                  TextButton(
                    child: Text(
                      'OK',
                      style: TextStyle(color: AppColors.black.withOpacity(0.5)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      params.onDismiss;
                    },
                  ),
                ],
        );
      },
    );
    params.onDismiss;
  }
}
