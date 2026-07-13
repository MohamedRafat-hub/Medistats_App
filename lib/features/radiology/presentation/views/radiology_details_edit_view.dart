import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/features/radiology/presentation/managers/update_radiology_details_cubit/update_radiology_details_cubit.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/radiology_image_preview.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/section_label.dart';

import '../../../../core/helper_functions/build_show_snack_bar.dart';
import '../../../../core/widgets/custom_action_button.dart';
import '../../../patient_management/presentation/views/widgets/custom_text_field.dart';
import '../../data/models/radiology_model.dart';

class RadiologyDetailsEditView extends StatefulWidget {
  final RadiologyModel radiologyModel;

  const RadiologyDetailsEditView({super.key, required this.radiologyModel});

  @override
  State<RadiologyDetailsEditView> createState() =>
      _RadiologyDetailsEditViewState();
}

class _RadiologyDetailsEditViewState extends State<RadiologyDetailsEditView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.radiologyModel.xrayType,
    );
    _detailsController = TextEditingController(
      text: widget.radiologyModel.notes,
    );
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

                BlocConsumer<
                  UpdateRadiologyDetailsCubit,
                  UpdateRadiologyDetailsState
                >(
                  listener: (context, state) {
                    if (state is UpdateRadiologyDetailsSuccess) {
                      showSnackBar(
                        context,
                        message: 'Radiology details updated successfully',
                      );
                      Navigator.pop(context);
                    } else if(state is UpdateRadiologyDetailsFailure) {
                      showSnackBar(
                        context,
                        message:
                            'Failed to update radiology details please try again later ${state.errorMessage}',
                        color: Colors.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is UpdateRadiologyDetailsLoading
                        ? Center(
                          child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                        )
                        : CustomActionButton(
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
                          );
                  },
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
      context.read<UpdateRadiologyDetailsCubit>().updateRadiologyDetails(
        radiologyModel: widget.radiologyModel.copyWith(
          xrayType: _nameController.text,
          notes: _detailsController.text,
        ),
      );
      debugPrint('Name: ${_nameController.text}');
      debugPrint('Details: ${_detailsController.text}');
    }
  }
}
