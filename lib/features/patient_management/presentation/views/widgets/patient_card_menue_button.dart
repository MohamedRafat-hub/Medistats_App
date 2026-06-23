import 'package:flutter/material.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patient_menue_options.dart';

class PatientCardMenuButton extends StatelessWidget {
  const PatientCardMenuButton({super.key, this.onDeletePressed, this.onUpdatePressed});

  final void Function()? onDeletePressed;
  final void Function()? onUpdatePressed;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.black45),
      elevation: 4,
      offset: const Offset(0, 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,

      constraints: const BoxConstraints(
        maxWidth: 130,
        minWidth: 110,
      ),

      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'edit',
          height: 38,
          child: CustomPatientMenuOption(
            icon: Icons.edit_outlined,
            iconColor: Color(0xFF2C7A8C),
            label: 'Edit',
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          height: 38,
          child: CustomPatientMenuOption(
            icon: Icons.delete_outline,
            iconColor: Colors.redAccent,
            label: 'Delete',
          ),
        ),
      ],

      onSelected: (value) {
        if (value == 'edit' && onUpdatePressed != null) {
          onUpdatePressed!();
        } else if (value == 'delete' && onDeletePressed != null) {
          onDeletePressed!();
        }
      },
    );
  }
}