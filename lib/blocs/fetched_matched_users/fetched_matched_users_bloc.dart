import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/models/user.dart';
import './fetched_matched_users.dart';
import 'package:proposal/exceptions/data_fetch_exception.dart';

class FetchedMatchedUsersBloc
    extends Bloc<FetchedMatchedUsersEvent, FetchedMatchedUsersState> {
  final ProposalDataRepository dataRepository;
  final CurrentUser currentUser;
  FetchedMatchedUsersBloc(this.dataRepository, this.currentUser);

  final String _tag = "FetchedMatchedUsersBloc: ";

  void loadData() async {
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
    } else if (event is FetchingMatchedUsersError) {
      yield (FetchMatchUsersErrorState(event.msg));
    }
  }

  Stream<FetchedMatchedUsersState> fetchMatchedUsers() async* {
    print(" $_tag Fetching Matched Users");
    try {
      List<ProposalUser> matchedUsers =
          await dataRepository.fetchMatchedUsers(currentUser);
      print("$_tag Successfully Fetched Matched Users: ${matchedUsers.length}");
      yield (FetchMatchedUsersStateSuccess(matchedUsers));
    } on DataFetchException catch (e) {
      print("$_tag Failed Fetching Matched Users: ${e.message}");
      yield (FetchMatchUsersErrorState(e.toString()));
    }
  }
}
