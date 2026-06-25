import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/core/helper_functions/build_show_snack_bar.dart';
import 'package:medistats/core/utils/app_theme.dart';
import 'package:medistats/core/widgets/closed_button_sheet.dart';
import 'package:medistats/features/sessions/data/models/session_model.dart';
import 'package:medistats/features/sessions/presentation/managers/add_session_cubit/add_session_cubit.dart';

import '../../../../../core/widgets/custom_action_button.dart';
import '../../../../patient_management/presentation/views/widgets/custom_text_field.dart';

class AddSessionBottomSheet extends StatefulWidget {
  const AddSessionBottomSheet({super.key, required this.patientId});

  final String patientId;

  @override
  State<AddSessionBottomSheet> createState() => _AddSessionBottomSheetState();
}

class _AddSessionBottomSheetState extends State<AddSessionBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String? _diagnosis;
  String? _prescription;
  String? _notes;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery
        .of(context)
        .viewInsets
        .bottom;
    return Form(
      key: _formKey,
      autovalidateMode: autoValidateMode,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height*.85,
        ),
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                  buildCloseButton(context, () {
                    context.read<AddSessionCubit>().cancelAddingSession();
                    Navigator.pop(context);
                  }),
                ],
              ),
              const SizedBox(height: 20),

              CustomTextField(
                hintText: 'Diagnosis',
                onSaved: (value) {
                  _diagnosis = value;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Prescription/Plan',
                maxLines: 3,
                onSaved: (value) {
                  _prescription = value;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hintText: 'Notes',
                maxLines: 2,
                onSaved: (value) {
                  _notes = value;
                },
              ),

              const SizedBox(height: 18),

              BlocConsumer<AddSessionCubit, AddSessionState>(
                listener: (context, state) {
                  if(state is AddSessionSuccess)
                    {
                      showSnackBar(context, message: 'Add Session successfully');
                      Navigator.pop(context);
                    }
                  else if(state is AddSessionFailure)
                  {
                    showSnackBar(context, message: 'Add Session Failure try again');
                  }
                },
                builder: (context, state) {
                  return state is AddSessionLoading ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ) : CustomActionButton(
                    text: 'Add Session',
                    onPressed: () {
                      _formKey.currentState!.save();
                      SessionModel sessionModel = SessionModel(sessionId: '',
                          patientId: widget.patientId,
                          title: 'متابعة دورية للكشف',
                          createdAt: DateTime.now(),
                          diagnosis: _diagnosis ?? '',
                          prescription: _prescription ?? '',
                          notes: _notes ?? '');
                      context.read<AddSessionCubit>().addSession(
                          sessionModel: sessionModel);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
