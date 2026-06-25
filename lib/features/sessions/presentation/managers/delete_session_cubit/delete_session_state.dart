part of 'delete_session_cubit.dart';

@immutable
sealed class DeleteSessionState {}

final class DeleteSessionInitial extends DeleteSessionState {}
final class DeleteSessionLoading extends DeleteSessionState {}
final class DeleteSessionSuccess extends DeleteSessionState {}
final class DeleteSessionFailure extends DeleteSessionState {
  final String errorMessage;
  DeleteSessionFailure(this.errorMessage);
}
