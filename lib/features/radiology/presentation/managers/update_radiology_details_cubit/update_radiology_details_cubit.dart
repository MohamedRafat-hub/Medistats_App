import 'package:bloc/bloc.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';
import 'package:medistats/features/radiology/data/repos/radiology_repo.dart';
import 'package:meta/meta.dart';

part 'update_radiology_details_state.dart';

class UpdateRadiologyDetailsCubit extends Cubit<UpdateRadiologyDetailsState> {
  UpdateRadiologyDetailsCubit(this.radiologyRepo) : super(UpdateRadiologyDetailsInitial());
  final RadiologyRepo radiologyRepo;
  void updateRadiologyDetails({required RadiologyModel radiologyModel})async {
    emit(UpdateRadiologyDetailsLoading());

    var result =await  radiologyRepo.updateRadiologyData(radiologyModel: radiologyModel);

    result.fold((error){
      emit(UpdateRadiologyDetailsFailure(error.message));
    }, (_){
      emit(UpdateRadiologyDetailsSuccess());
    });
  }
}
