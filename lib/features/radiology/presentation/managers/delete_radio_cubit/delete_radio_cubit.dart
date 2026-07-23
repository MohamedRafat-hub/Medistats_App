import 'package:bloc/bloc.dart';
import 'package:medistats/features/radiology/data/models/radiology_model.dart';
import 'package:medistats/features/radiology/data/repos/radiology_repo.dart';
import 'package:meta/meta.dart';

part 'delete_radio_state.dart';

class DeleteRadioCubit extends Cubit<DeleteRadioState> {
  DeleteRadioCubit(this.radiologyRepo) : super(DeleteRadioInitial());

  final RadiologyRepo radiologyRepo;

  void deleteRadio({required String radiologyId}) async {
    emit(DeleteRadioLoading());

    var result = await radiologyRepo.deleteRadiology(radiologyId: radiologyId);

    result.fold((error){
      emit(DeleteRadioError(error.message));
    }, (success){
      emit(DeleteRadioSuccess());
    });
  }
}
