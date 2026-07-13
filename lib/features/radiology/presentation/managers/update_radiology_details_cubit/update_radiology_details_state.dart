part of 'update_radiology_details_cubit.dart';

@immutable
sealed class UpdateRadiologyDetailsState {}

final class UpdateRadiologyDetailsInitial extends UpdateRadiologyDetailsState {}
final class UpdateRadiologyDetailsLoading extends UpdateRadiologyDetailsState {}
final class UpdateRadiologyDetailsSuccess extends UpdateRadiologyDetailsState {}
final class UpdateRadiologyDetailsFailure extends UpdateRadiologyDetailsState {
  final String errorMessage;
  UpdateRadiologyDetailsFailure(this.errorMessage);
}
