part of 'addsesion_cubit.dart';

@immutable
sealed class AddSessionState {}

final class AddSessionInitial extends AddSessionState {}
final class AddSessionLoading extends AddSessionState {}
final class AddSessionSuccess extends AddSessionState {}
final class AddSessionFailure extends AddSessionState {
  final String errorMessage;

  AddSessionFailure(this.errorMessage);
}
