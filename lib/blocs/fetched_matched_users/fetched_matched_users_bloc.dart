import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/models/user.dart';
import './fetched_matched_users.dart';
import 'package:proposal/exceptions/no_initial_match_fetch_occured_exception.dart';

class FetchedMatchedUsersBloc
    extends Bloc<FetchedMatchedUsersEvent, FetchedMatchedUsersState> {
  final ProposalDataRepository dataRepository;
  final CurrentUser currentUser;
  FetchedMatchedUsersBloc(this.dataRepository, this.currentUser);
  final List<ProposalUser> matchedUsers = new List();

  void loadData(bool loadNext) async {
    if (loadNext)
      dispatch(FetchNextMatchedUsersEvent());
    else
      dispatch(FetchMatchedUsersEvent());
  }

  @override
  FetchedMatchedUsersState get initialState =>
      InitialFetchedMatchedUsersState();

  @override
  Stream<FetchedMatchedUsersState> mapEventToState(
    FetchedMatchedUsersEvent event,
  ) async* {
    if (event is FetchMatchedUsersEvent) {
      yield* fetchMatchedUsers();
    } else if (event is FetchNextMatchedUsersEvent) {
      yield* fetchNextMatchedUsers();
    }
  }

  Stream<FetchedMatchedUsersState> fetchMatchedUsers() async* {
    print("Fetching Matched Users");
    List<ProposalUser> fetchedUsers =
        await dataRepository.fetchMatchedUsers(currentUser);
    fetchedUsers.forEach((user) {
      matchedUsers.add(user);
    });
    yield (FetchMatchedUsersStateSuccess(matchedUsers));
  }

  Stream<FetchedMatchedUsersState> fetchNextMatchedUsers() async* {
    try {
      List<ProposalUser> fetchedUsers =
          await dataRepository.fetchNextMatchedUsers(currentUser);
      fetchedUsers.forEach((user) {
        if (!fetchedUsers.contains(user)) {
          matchedUsers.add(user);
        }
      });
      yield (FetchNextMatchedUsersStateSuccess(matchedUsers));
    } on NoInitialMatchFetchOccuredException catch (e) {
      yield (FetchMatchUsersErrorState(e.toString()));
    }
  }
}
