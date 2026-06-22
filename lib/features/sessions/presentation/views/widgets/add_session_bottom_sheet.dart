import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_action_button.dart';
import '../../../../patient_management/presentation/views/widgets/custom_text_field.dart';

class AddSessionBottomSheet extends StatelessWidget {
  const AddSessionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(
        top: 12,
        left: 24,
        right: 24,
        bottom: 24 + bottomInset,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xffD3D3D3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'Add New Session',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              _buildCloseButton(context),
            ],
          ),
          const SizedBox(height: 20),

          const CustomTextField(hintText: 'Diagnosis'),
          const SizedBox(height: 10),
          const CustomTextField(hintText: 'Prescription/Plan' , maxLines: 3),
          const SizedBox(height: 10),
          const CustomTextField(hintText: 'Notes', maxLines: 2),

          const SizedBox(height: 18),

          CustomActionButton(
            text: 'Add Session',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Color(0xffE5E5E5),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.close,
          size: 18,
          color: Color(0xff5A5A5A),
        ),
      ),
    );
  }
}