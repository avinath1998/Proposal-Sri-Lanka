import 'package:meta/meta.dart';
import 'package:proposal/models/user.dart';

@immutable
abstract class FetchedMatchedUsersState {}

class InitialFetchedMatchedUsersState extends FetchedMatchedUsersState {}

class FetchMatchedUsersStateSuccess extends FetchedMatchedUsersState {
  final List<ProposalUser> matches;
  FetchMatchedUsersStateSuccess(this.matches);
}

class FetchMatchUsersErrorState extends FetchedMatchedUsersState {
  final String message;

  FetchMatchUsersErrorState(this.message);
}
