import 'package:proposal/data/network/db.dart';
import 'package:proposal/exceptions/data_fetch_exception.dart';
import 'package:proposal/exceptions/no_initial_match_fetch_occured_exception.dart';
import 'package:proposal/models/user.dart';

class ProposalDataRepository {
  DB database;
  ProposalUser _lastFetchedMatchedUser;
  ProposalUser _lastFetchedExploreUser;
  final String _tag = "ProposalDataRepository: ";
  final List<ProposalUser> _fetchedUsers = List();

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
    try {
      CurrentUser user = await database.fetchCurrentUser(id);
      return user;
    } catch (e) {
      throw DataFetchException(e.toString());
    }
  }

  //Change this, the null will return first.
  Future<List<ProposalUser>> fetchMatchedUsers(CurrentUser user) async {
    print("$_tag fetching matched users");
    try {
      List<ProposalUser> users = new List();
      if (_lastFetchedMatchedUser == null) {
        print("$_tag fetching initial set of matched users");
        users = await database.fetchUsers(query: {
          'religion': user.regilion,
          'nativeLanguage': user.nativeLanguage
        });
      } else {
        print("$_tag fetching next set of matched users");
        users = await database.fetchUsers(query: {
          'religion': user.regilion,
          'nativeLanguage': user.nativeLanguage
        }, lastFetchedUser: _lastFetchedMatchedUser);
      }

      if (users.length > 0) {
        _lastFetchedMatchedUser = users[users.length - 1];
      }

      users.forEach((user) {
        user.isMatch = true;
        _fetchedUsers.add(user);
        print("$_tag Added: " + user.firstName);
      });

      return _fetchedUsers.where((user) => user.isMatch).toList();
    } catch (e) {
      throw DataFetchException(e.toString());
    }
  }
}
