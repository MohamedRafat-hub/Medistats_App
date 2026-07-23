
import 'package:flutter/material.dart';
import 'package:medistats/core/utils/app_theme.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(BuildContext context , {required String message , Color? color}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:  Text(message),
      backgroundColor: color ?? AppColors.primaryColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
