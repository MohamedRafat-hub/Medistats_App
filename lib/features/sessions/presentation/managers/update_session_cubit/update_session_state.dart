part of 'update_session_cubit.dart';

@immutable
sealed class UpdateSessionState {}

final class UpdateSessionInitial extends UpdateSessionState {}
final class UpdateSessionLoading  extends UpdateSessionState {}
final class UpdateSessionSuccess extends UpdateSessionState {}
final class UpdateSessionFailure extends UpdateSessionState {
  final String errorMessage;
  UpdateSessionFailure(this.errorMessage);
}
