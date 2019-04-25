import 'package:meta/meta.dart';

@immutable
abstract class FetchedMatchedUsersEvent {}

class FetchMatchedUsersEvent extends FetchedMatchedUsersEvent {}

class FetchNextMatchedUsersEvent extends FetchedMatchedUsersEvent {}

class FetchingMatchedUsersError extends FetchedMatchedUsersEvent {}
