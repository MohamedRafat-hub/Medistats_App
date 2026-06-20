import 'package:flutter/material.dart';
import 'custom_text_field.dart';
import 'custom_action_button.dart';

class AddPatientBottomSheet extends StatelessWidget {
  const AddPatientBottomSheet({super.key});

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
                'Add New Patient',
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
          const SizedBox(height: 24),

          const CustomTextField(hintText: 'Full Name'),
          const SizedBox(height: 16),
          const CustomTextField(hintText: 'Age', keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          const CustomTextField(hintText: 'Phone Number', keyboardType: TextInputType.phone),
          const SizedBox(height: 20),


          const SizedBox(height: 24),

          CustomActionButton(
            text: 'SAVE',
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