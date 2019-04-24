import 'package:meta/meta.dart';

@immutable
abstract class FetchedMatchedUsersState {}

class InitialFetchedMatchedUsersState extends FetchedMatchedUsersState {}

class FetchNextMatchedUsersState extends FetchedMatchedUsersState {}
