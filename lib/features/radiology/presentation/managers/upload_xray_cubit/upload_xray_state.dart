part of 'upload_xray_cubit.dart';

@immutable
sealed class UploadXrayState {}

final class UploadXrayInitial extends UploadXrayState {}
final class UploadXrayLoading extends UploadXrayState {}
final class UploadXraySuccess extends UploadXrayState {
  final RadiologyModel radiologyModel;

  UploadXraySuccess(this.radiologyModel);
}
final class UploadXrayFailure extends UploadXrayState {
  final String errorMessage;

  UploadXrayFailure(this.errorMessage);
}
