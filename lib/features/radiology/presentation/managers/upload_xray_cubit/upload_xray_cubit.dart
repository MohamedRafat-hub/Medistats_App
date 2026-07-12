import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/radiology_repo.dart';

part 'upload_xray_state.dart';

class UploadXrayCubit extends Cubit<UploadXrayState> {
  final RadiologyRepo radiologyRepo;
  UploadXrayCubit({required this.radiologyRepo}) : super(UploadXrayInitial());


  void captureXRay() async
  {
    try {
      File? file =await radiologyRepo.captureXRay();

      if(file == null) return;
      emit(UploadXraySuccess(file));
    } catch (e) {
      emit(UploadXrayFailure(e.toString()));
    }
  }
}
