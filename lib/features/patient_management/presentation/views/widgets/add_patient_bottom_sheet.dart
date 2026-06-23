import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/helper_functions/build_show_snack_bar.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/features/patient_management/presentation/managers/add_patient_cubit/add_patient_cubit.dart';
import 'package:medistats/features/patient_management/presentation/managers/update_patient_cubit/update_patient_cubit.dart';
import '../../../../../core/widgets/closed_button_sheet.dart';
import '../../../data/models/patient_model.dart';
import 'custom_text_field.dart';
import '../../../../../core/widgets/custom_action_button.dart';

class AddPatientBottomSheet extends StatefulWidget {
  const AddPatientBottomSheet({super.key, this.patientToEdit});
  final PatientModel? patientToEdit;
  @override
  State<AddPatientBottomSheet> createState() => _AddPatientBottomSheetState();
}

class _AddPatientBottomSheetState extends State<AddPatientBottomSheet> {
  late String _fullName;
  late int _age;
  late String _phoneNumber;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isEditing = widget.patientToEdit != null;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.only(
        top: 12,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: autovalidateMode,
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
                    Text(
                      isEditing ? 'Edit Patient' : 'Add New Patient',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    buildCloseButton(context, () {
                      log('close button tapped');
                      context.read<AddPatientCubit>().cancelAddingPatient();
                      Navigator.pop(context);
                    }),
                  ],
                ),

                const SizedBox(height: 24),

                CustomTextField(
                  hintText: 'Full Name',
                  initialValue: widget.patientToEdit?.name,
                  keyboardType: TextInputType.name,
                  onSaved: (value) {
                    _fullName = value!;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Age',
                  initialValue: widget.patientToEdit?.age.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _age = int.parse(value!);
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Phone Number',
                  initialValue: widget.patientToEdit?.phoneNumber,
                  keyboardType: TextInputType.phone,
                  onSaved: (value) {
                    _phoneNumber = value!;
                  },
                ),

                const SizedBox(height: 24),

                // 🔄 3. دمجنا الـ Consumers بترتيب نظيف ومنطقي جداً
                BlocConsumer<UpdatePatientCubit, UpdatePatientState>(
                  listener: (context, state) {
                    if (state is UpdatePatientSuccess) {
                      showSnackBar(
                        context,
                        message: 'Patient updated successfully',
                      );
                      Navigator.pop(context);
                    } else if (state is UpdatePatientFailure) {
                      showSnackBar(
                        context,
                        message: state.errorMessage,
                        color: Colors.red,
                      );
                    }
                  },
                  builder: (context, updateState) {
                    return BlocConsumer<AddPatientCubit, AddPatientState>(
                      listener: (context, state) {
                        if (state is AddPatientSuccess) {
                          showSnackBar(
                            context,
                            message: 'Patient added successfully',
                          );
                          Navigator.pop(context);
                        } else if (state is AddPatientFailure) {
                          showSnackBar(
                            context,
                            message: state.errorMessage,
                            color: Colors.red,
                          );
                        }
                      },
                      builder: (context, addState) {
                        // 🧠 لو أي كوبيت فيهم شغال Loading، اعرض الـ Indicator فوراً
                        final isLoading =
                            addState is AddPatientLoading ||
                            updateState is UpdatePatientLoading;

                        return isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              )
                            : CustomActionButton(
                                text: isEditing ? 'UPDATE' : 'SAVE',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    if (isEditing) {
                                      final updatedPatient = PatientModel(
                                        id: widget.patientToEdit!.id,
                                        name: _fullName,
                                        age: _age,
                                        phoneNumber: _phoneNumber,
                                        createdAt:
                                            widget.patientToEdit!.createdAt,
                                      );
                                      context
                                          .read<UpdatePatientCubit>()
                                          .updatePatient(
                                            patient: updatedPatient,
                                          );
                                      log(
                                        'Updating patient: ${updatedPatient.name}',
                                      );
                                    } else {
                                      final patient = PatientModel(
                                        id: '',
                                        name: _fullName,
                                        age: _age,
                                        phoneNumber: _phoneNumber,
                                        createdAt: DateTime.now(),
                                      );
                                      context
                                          .read<AddPatientCubit>()
                                          .addPatient(patient);
                                    }
                                  } else {
                                    autovalidateMode = AutovalidateMode.always;
                                    setState(() {});
                                  }
                                },
                              );
                      },
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
}
