import 'package:proposal/data/network/db.dart';
import 'package:proposal/exceptions/data_fetch_exception.dart';
import 'package:proposal/exceptions/no_initial_match_fetch_occured_exception.dart';
import 'package:proposal/models/user.dart';

class ProposalDataRepository {
  DB database;
  ProposalUser _lastFetchedMatchedUser;
  ProposalUser _lastFetchedExploreUser;

  static final ProposalDataRepository _repo =
      new ProposalDataRepository._internal();

  static ProposalDataRepository get() {
    return _repo;
  }

  ProposalDataRepository._internal() {
    database = FirestoreDB();
  }

  Future<CurrentUser> fetchCurrentUser(String id) async {
    print("Fetching Current User");
    CurrentUser user = await database.fetchCurrentUser(id);
    return user;
  }

  //Change this, the null will return first.
  Future<List<ProposalUser>> fetchMatchedUsers(CurrentUser user) async {
    print("Repository: Fetching Users");
    List<ProposalUser> users = await database.fetchUsers(query: {
      'religion': user.regilion,
      'nativeLanguage': user.nativeLanguage
    });
    return users;
  }

  Future<List<ProposalUser>> fetchNextMatchedUsers(CurrentUser user) async {
    if (_lastFetchedMatchedUser == null) {
      throw new NoInitialMatchFetchOccuredException(
          "Initial Matches Fetch hasn't occured yet, cannot fetch next matched users.");
    } else {
      List<ProposalUser> matchedUsers = await database.fetchUsers(query: {
        'religion': user.regilion,
        'nativeLanguage': user.nativeLanguage
      }, lastFetchedUser: _lastFetchedMatchedUser);
      _lastFetchedMatchedUser = matchedUsers[matchedUsers.length - 1];
      return matchedUsers;
    }
  }
}
