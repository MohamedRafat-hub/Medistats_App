import 'package:flutter/material.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/radiology_image_preview.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/section_label.dart';

import '../../../../core/widgets/custom_action_button.dart';
import '../../../patient_management/presentation/views/widgets/custom_text_field.dart';
import '../../data/models/radiology_model.dart';


class RadiologyDetailsEditView extends StatefulWidget {
  final RadiologyModel radiologyModel;

  const RadiologyDetailsEditView({
    super.key,
    required this.radiologyModel,
  });

  @override
  State<RadiologyDetailsEditView> createState() => _RadiologyDetailsEditViewState();
}

class _RadiologyDetailsEditViewState extends State<RadiologyDetailsEditView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.radiologyModel.xrayType);
    _detailsController = TextEditingController(text: widget.radiologyModel.notes);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadiologyImagePreview(imageUrl: widget.radiologyModel.imageUrl),
                const SizedBox(height: 28),

                const SectionLabel(label: 'Radiology Name'),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'e.g., Chest X-Ray, Panoramic',
                ),
                const SizedBox(height: 20),

                const SectionLabel(label: 'Radiology Details / Notes'),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _detailsController,
                  hintText: 'Write clinical findings or notes here...',
                  maxLines: 5,
                ),
                const SizedBox(height: 40),

                CustomActionButton(
                  onPressed: _onSavePressed,
                  widget: const Text(
                    'Save Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const BackButton(color: Color(0xFF1E293B)),
      title: const Text(
        'Radiology Details',
        style: TextStyle(
          color: Color(0xFF1E293B),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  void _onSavePressed() {
    if (_formKey.currentState!.validate()) {
      debugPrint('Name: ${_nameController.text}');
      debugPrint('Details: ${_detailsController.text}');
    }
  }
}



