import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/helper_functions/build_show_snack_bar.dart';
import 'package:medistats/features/patient_management/presentation/managers/add_patient_cubit/add_patient_cubit.dart';
import '../../../../../core/widgets/closed_button_sheet.dart';
import '../../../data/models/patient_model.dart';
import 'custom_text_field.dart';
import '../../../../../core/widgets/custom_action_button.dart';

class AddPatientBottomSheet extends StatefulWidget {
  const AddPatientBottomSheet({super.key});

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
      child: Form(
        key: _formKey,
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
                  buildCloseButton(context),
                ],
              ),


            const SizedBox(height: 24),

            CustomTextField(
              hintText: 'Full Name',
              keyboardType: TextInputType.name,
              onSaved: (value) {
                _fullName = value!;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: 'Age',
              keyboardType: TextInputType.number,
              onSaved: (value) {
                _age = int.parse(value!);
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hintText: 'Phone Number',
              keyboardType: TextInputType.phone,
              onSaved: (value) {
                _phoneNumber = value!;
              },
            ),

            const SizedBox(height: 24),

            BlocConsumer<AddPatientCubit, AddPatientState>(
              listener: (context, state) {
                if (state is AddPatientSuccess) {
                  showSnackBar(context, message: 'Patient added successfully');
                  Navigator.pop(context);
                } else if (state is AddPatientFailure) {
                  showSnackBar(context, message: state.errorMessage, color: Colors.red);
                }
              },
              builder: (context, state) {
                return state is AddPatientLoading ? Center(child: CupertinoActivityIndicator(
                  radius: 12,
                )) : CustomActionButton(
                  text: 'SAVE',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final patient = PatientModel(id: '', name: _fullName, age: _age, phoneNumber: _phoneNumber);
                      context.read<AddPatientCubit>().addPatient(patient);
                    }
                    else
                      {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
