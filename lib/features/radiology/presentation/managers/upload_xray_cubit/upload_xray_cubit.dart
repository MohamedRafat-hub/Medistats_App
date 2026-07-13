import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/radiology_repo.dart';

part 'upload_xray_state.dart';

class UploadXrayCubit extends Cubit<UploadXrayState> {
  final RadiologyRepo radiologyRepo;
  UploadXrayCubit({required this.radiologyRepo}) : super(UploadXrayInitial());


  Future<void> uploadXRay(RadiologyModel radiologyModel) async
  {
    try {
      File? file =await radiologyRepo.captureXRay();

      if(file == null) return;

      emit(UploadXrayLoading());
      var result = await radiologyRepo.uploadXRayImage(file);

      result.fold((error){
        emit(UploadXrayFailure(error.message));
      },(imageUrl) async{
        final updatedModelWithUrl = radiologyModel.copyWith(imageUrl: imageUrl);
        var result = await radiologyRepo.uploadRadiology(radiologyModel: updatedModelWithUrl);
        result.fold((error){
          emit(UploadXrayFailure(error));
        }, (id){
          final finalModel = updatedModelWithUrl.copyWith(id: id);
          emit(UploadXraySuccess(finalModel));
        });
      });
    } catch (e) {
      emit(UploadXrayFailure(e.toString()));
    }
  }
}
