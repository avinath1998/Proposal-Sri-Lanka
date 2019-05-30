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

  List<ProposalUser> get fetchedUsers => _fetchedUsers;

  ProposalDataRepository._internal() {
    database = FirestoreDB();
    database.init();
  }

  Future<ProposalUser> requestAContact(
      ProposalUser user, CurrentUser currentUser, bool requesting) async {
    print("$_tag Requesting a Contact: ${user.id} to ${currentUser.id}");
    try {
      await database.sendRequestToProposalUser(currentUser, user, requesting);
      user.isContactRequested = requesting;
      _fetchedUsers.forEach((forUser) {
        if (forUser.id == user.id) {
          forUser.isContactRequested = requesting;
        }
      });
      return user;
    } catch (e) {
      print("$_tag ${e.toString()}");
      throw DataFetchException(e.toString());
    }
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

  Future<ProposalUser> fetchProposalUserInFullDetails(
      CurrentUser user, ProposalUser userToFetch) async {
    print("Fetching Proposal User in Full Details");
    if (userToFetch.hasUserBeenFetchedInFull) {
      print(
          "Proposal user: ${userToFetch.firstName} has already been fetched in full.");
      return userToFetch;
    } else {
      print(
          "Proposal user: ${userToFetch.firstName} will be fetched in full.....");
      //for now, the only thing extra needed to get the details for the user in full
      //is if the user has sent a contact request to the proposal user.
      try {
        bool isRequested = await database.hasProposalUserContactBeenRequested(
            user, userToFetch);
        if (isRequested) {
          userToFetch.hasContactAcceptedContactRequest = await database
              .hasProposalUserAcceptedCurrentUserRequest(user, userToFetch);
        }
        userToFetch.isContactRequested = isRequested;
        userToFetch.hasUserBeenFetchedInFull = true;
        _fetchedUsers.remove(userToFetch);
        _fetchedUsers.add(userToFetch);
        return userToFetch;
      } catch (e) {
        print(e.toString());
        throw DataFetchException(e.toString());
      }
    }
  }

  Future<List<ProposalUser>> fetchMatchedUsers(CurrentUser currentUser) async {
    print("$_tag fetching matched users");
    try {
      List<ProposalUser> users = new List();
      if (_lastFetchedMatchedUser == null) {
        print("$_tag fetching initial set of matched users");
        users = await database.fetchUsers(query: {
          'religion': currentUser.regilion,
          'nativeLanguage': currentUser.nativeLanguage
        });
        print(currentUser.regilion);
        print(currentUser.nativeLanguage);
      } else {
        print("$_tag fetching next set of matched users");
        users = await database.fetchUsers(query: {
          'religion': currentUser.regilion,
          'nativeLanguage': currentUser.nativeLanguage
        }, lastFetchedUser: _lastFetchedMatchedUser);
      }

      if (users.length > 0) {
        _lastFetchedMatchedUser = users[users.length - 1];
      }

      for (ProposalUser userToAdd in users) {
        if (userToAdd.id != currentUser.id) {
          if (!_fetchedUsers.contains(userToAdd)) {
            userToAdd.isMatch = true;

            userToAdd.isContactRequested = await database
                .hasProposalUserContactBeenRequested(currentUser, userToAdd);
            if (userToAdd.isContactRequested) {
              userToAdd.hasContactAcceptedContactRequest =
                  await database.hasProposalUserAcceptedCurrentUserRequest(
                      currentUser, userToAdd);
            }

            _fetchedUsers.add(userToAdd);
            print("$_tag Added: " + userToAdd.firstName);
          } else {
            print("$_tag Already in array: " + userToAdd.firstName);
          }
        }
      }
      return _fetchedUsers.where((user) => user.isMatch).toList();
    } catch (e) {
      throw DataFetchException(e.toString());
    }
  }
}
