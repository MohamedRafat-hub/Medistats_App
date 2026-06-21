import 'package:flutter/material.dart';

import '../../../../../core/utils/app_theme.dart';

/// Simple app bar with a "Back" text button and a title,
/// matching the design's custom back navigation style.
class PatientHistoryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const PatientHistoryAppBar({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: 90,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon:
        const Icon(Icons.arrow_back_ios),
      ),
      title: Text(title, style: AppTextStyles.screenTitle),
    );
  }
}
