import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/models/user.dart';
import './fetched_matched_users.dart';

class FetchedMatchedUsersBloc
    extends Bloc<FetchedMatchedUsersEvent, FetchedMatchedUsersState> {
  final ProposalDataRepository dataRepository;
  final CurrentUser currentUser;
  FetchedMatchedUsersBloc(this.dataRepository, this.currentUser);
  final List<ProposalUser> matchedUsers = new List();

  void loadData(bool loadNext) async {
    if (loadNext) {
      List<ProposalUser> fetchedUsers =
          await dataRepository.fetchNextMatchedUsers(currentUser);
      fetchedUsers.forEach((user) {
        if (!fetchedUsers.contains(user)) {
          matchedUsers.add(user);
        }
      });
    } else {
      List<ProposalUser> fetchedUsers =
          await dataRepository.fetchMatchedUsers(currentUser);
      fetchedUsers.forEach((user) {
        matchedUsers.add(user);
      });
    }
  }

  @override
  FetchedMatchedUsersState get initialState =>
      InitialFetchedMatchedUsersState();

  @override
  Stream<FetchedMatchedUsersState> mapEventToState(
    FetchedMatchedUsersEvent event,
  ) async* {
    if (event is FetchMatchedUsersCompleteEvent) {
      yield (FetchedMatchedUsersState());
    }
  }
}
