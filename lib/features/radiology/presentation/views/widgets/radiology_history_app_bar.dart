import 'package:flutter/material.dart';
import 'package:medistats/core/utils/app_theme.dart';

class RadiologyHistoryAppBar extends StatelessWidget {
  const RadiologyHistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Center(
        child: const Text(
          textAlign: TextAlign.center,
          'Mohamed Rafat Radiology History',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
