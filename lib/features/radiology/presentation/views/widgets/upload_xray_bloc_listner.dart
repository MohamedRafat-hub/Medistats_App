import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medistats/features/radiology/presentation/views/widgets/add_xray_button.dart';

import '../../../../../core/helper_functions/build_show_snack_bar.dart';
import '../../../data/models/radiology_model.dart';
import '../../managers/upload_xray_cubit/upload_xray_cubit.dart';
import '../radiology_details_edit_view.dart';

class UploadXrayBlocListener extends StatelessWidget {
  const UploadXrayBlocListener({super.key, required this.patientId, required this.sessionId});
  final String patientId;
  final String sessionId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadXrayCubit, UploadXrayState>(
      listener: (context, state) {
        if (state is UploadXrayFailure) {
          showSnackBar(context, message: state.errorMessage, color: Colors.red);
        } else if (state is UploadXraySuccess) {
          showSnackBar(context, message: 'X-ray uploaded successfully');
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return RadiologyDetailsEditView(radiologyModel: state.radiologyModel);
          }));
        }
      },
      builder: (context, state) {
        return AddXrayButton(
          child: state is UploadXrayLoading
              ? CircularProgressIndicator(color: Colors.white)
              : const Icon(Icons.camera_alt_outlined, size: 24),
          onPressed: state is UploadXrayLoading ? () {} : () {
            final initialModel = RadiologyModel(id: '',
                imageUrl: '',
                uploadedAt: DateTime.now(),
                patientId: patientId,
                sessionId: sessionId);
            context.read<UploadXrayCubit>().uploadXRay(
                initialModel
            );
          },
        );
      },
    );
  }
}