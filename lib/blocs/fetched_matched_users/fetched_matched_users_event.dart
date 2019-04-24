import 'package:meta/meta.dart';

@immutable
abstract class FetchedMatchedUsersEvent {}

class FetchMatchedUsers extends FetchedMatchedUsersEvent {}

class FetchingMatchedUsersError extends FetchedMatchedUsersEvent {}
