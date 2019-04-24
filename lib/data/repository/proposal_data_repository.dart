import 'package:proposal/data/network/db.dart';
import 'package:proposal/exceptions/no_initial_match_fetch_occured_exception.dart';
import 'package:proposal/models/user.dart';

class ProposalDataRepository {
  final DB database;
  ProposalUser _lastFetchedMatchedUser;
  ProposalUser _lastFetchedExploreUser;

  ProposalDataRepository(this.database);

  Future<List<ProposalUser>> fetchMatchedUsers(CurrentUser user) async {
    List<ProposalUser> matchedUsers = await database.fetchUsers(query: {
      'religion': user.regilion,
      'nativeLanguage': user.nativeLanguage
    });
    _lastFetchedMatchedUser = matchedUsers[matchedUsers.length - 1];
    return matchedUsers;
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
