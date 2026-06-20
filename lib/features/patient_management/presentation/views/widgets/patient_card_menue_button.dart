import 'package:flutter/material.dart';
import 'package:medistats/features/patient_management/presentation/views/widgets/patient_menue_options.dart';

class PatientCardMenuButton extends StatelessWidget {
  const PatientCardMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.black45),
      elevation: 6,
      offset: const Offset(0, 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      color: Colors.white,
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'edit',
          child: CustomPatientMenuOption(
            icon: Icons.edit_outlined,
            iconColor: Color(0xFF2C7A8C),
            label: 'Edit',
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: CustomPatientMenuOption(
            icon: Icons.delete_outline,
            iconColor: Colors.redAccent,
            label: 'Delete',
          ),
        ),
      ],
      onSelected: (value) {
        // No logic implemented (UI only)
      },
    );
  }
}