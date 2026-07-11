part of 'get_sessions_count_cubit.dart';

@immutable
sealed class GetSessionsCountState {}

final class GetSessionsCountInitial extends GetSessionsCountState {}
final class GetSessionsCountLoading extends GetSessionsCountState {}
final class GetSessionsCountSuccess extends GetSessionsCountState {
  final int count;
  GetSessionsCountSuccess(this.count);
}
final class GetSessionsCountError extends GetSessionsCountState {}
