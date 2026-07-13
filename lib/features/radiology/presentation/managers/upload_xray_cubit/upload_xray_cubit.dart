import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/radiology_repo.dart';

part 'upload_xray_state.dart';

class UploadXrayCubit extends Cubit<UploadXrayState> {
  final RadiologyRepo radiologyRepo;
  UploadXrayCubit({required this.radiologyRepo}) : super(UploadXrayInitial());


  void uploadXRay() async
  {
    try {
      File? file =await radiologyRepo.captureXRay();

      if(file == null) return;

      emit(UploadXrayLoading());
      var result = await radiologyRepo.uploadXRayImage(file);

      result.fold((error){
        emit(UploadXrayFailure(error.message));
      },(success){
        emit(UploadXraySuccess());
      });
    } catch (e) {
      emit(UploadXrayFailure(e.toString()));
    }
  }
}
