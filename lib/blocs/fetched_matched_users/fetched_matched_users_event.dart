import 'package:meta/meta.dart';

@immutable
abstract class FetchedMatchedUsersEvent {}

class FetchMatchedUsersEvent extends FetchedMatchedUsersEvent {}

class FetchingMatchedUsersError extends FetchedMatchedUsersEvent {
  final String msg;

  FetchingMatchedUsersError(this.msg);
}
