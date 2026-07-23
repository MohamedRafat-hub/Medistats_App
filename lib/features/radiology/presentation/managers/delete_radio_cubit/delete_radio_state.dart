part of 'delete_radio_cubit.dart';

@immutable
sealed class DeleteRadioState {}

final class DeleteRadioInitial extends DeleteRadioState {}
final class DeleteRadioLoading extends DeleteRadioState {}
final class DeleteRadioSuccess extends DeleteRadioState {}
final class DeleteRadioError extends DeleteRadioState {
  final String errorMessage;
  DeleteRadioError(this.errorMessage);
}
