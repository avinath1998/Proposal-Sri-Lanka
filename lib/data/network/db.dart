import 'package:proposal/exceptions/data_fetch_exception.dart';
import 'package:proposal/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DB {
  Future<CurrentUser> fetchCurrentUser(String id);
  Future<ProposalUser> fetchUser(String userId);
  Future<List<ProposalUser>> fetchUsers(
      {Map<String, dynamic> query, ProposalUser lastFetchedUser});
  Future<List<ProposalUser>> fetchRequestees(String currentUserId);
  Future<void> setCurrentUserSetting(CurrentUser user);
  Future<String> sendRequestToProposalUser(
      CurrentUser user, ProposalUser toUserId);
  Future<void> acceptRequestFromProposalUser(CurrentUser user, String toUserId);
  Future<void> declineRequestFromProposalUser(
      CurrentUser user, String toUserId);
  Future<void> saveProposalUser(CurrentUser user, String toUserId);
  Future<void> removeSavedProposalUser(CurrentUser user, String toUserId);
  Future<bool> hasProposalUserContactBeenRequested(
      CurrentUser currentUser, ProposalUser user);
  void printVersion();
}

class FirestoreDB extends DB {
  final Firestore db = Firestore.instance;

  @override
  Future<void> acceptRequestFromProposalUser(
      CurrentUser user, String toUserId) {
    // TODO: implement acceptRequestFromProposalUser
    return null;
  }

  @override
  Future<void> declineRequestFromProposalUser(
      CurrentUser user, String toUserId) {
    // TODO: implement declineRequestFromProposalUser
    return null;
  }

  @override
  Future<List<ProposalUser>> fetchRequestees(String currentUserId) {
    // TODO: implement fetchRequestees
    return null;
  }

  @override
  Future<ProposalUser> fetchUser(String userId) {
    // TODO: implement fetchUser
    return null;
  }

  @override
  Future<void> removeSavedProposalUser(CurrentUser user, String toUserId) {
    // TODO: implement removeSavedProposalUser
    return null;
  }

  @override
  Future<void> saveProposalUser(CurrentUser user, String toUserId) {
    // TODO: implement saveProposalUser
    return null;
  }

  @override
  Future<void> setCurrentUserSetting(CurrentUser user) {
    // TODO: implement setCurrentUserSetting
    return null;
  }

  @override
  Future<List<ProposalUser>> fetchUsers(
      {Map<String, dynamic> query, ProposalUser lastFetchedUser}) async {
    List<ProposalUser> users = List();
    Query firestoreQuery =
        buildFirestoreUserFetchQueryFromMap(query, lastFetchedUser);
    QuerySnapshot ref = await firestoreQuery.getDocuments();
    if (ref.documents.length > 0) {
      ref.documents.forEach((dc) {
        ProposalUser user = ProposalUser.fromMap(dc.data, dc.documentID);
        users.add(user);
      });
    }
    return users;
  }

  Query buildFirestoreUserFetchQueryFromMap(
      Map<String, dynamic> map, ProposalUser lastFetchedUser) {
    Query query;
    var _isCurrentQueryInvolveDate = false;
    query = Firestore.instance.collection('Users');
    if (map != null) {
      if (map.containsKey("Gender")) {
        query = query.where('gender', isEqualTo: map['Gender']);
      }
      if (map.containsKey('District')) {
        query = query.where('city', isEqualTo: map['city']);
      }
      if (map.containsKey('Age')) {
        _isCurrentQueryInvolveDate = true;
        DateTime startTime = getStartTime(map['Age']);
        DateTime endTime = getEndTime(map['Age']);
        query = query
            .where('dob', isGreaterThanOrEqualTo: endTime)
            .where('dob', isLessThanOrEqualTo: startTime);
      }
      if (map.containsKey('Religion')) {
        query = query.where('religion', isEqualTo: map['Religion']);
      }
      if (map.containsKey('Native Language')) {
        query =
            query.where('nativeLanguage', isEqualTo: map['Native Language']);
      }
      if (map.containsKey('currWorking')) {
        query = query.where('hasJob', isEqualTo: true);
      }
      if (map.containsKey('academicDegree')) {
        query = query.where('hasDegree', isEqualTo: true);
      }
      if (map.containsKey('Marital Status')) {
        if (map['Marital Status'] != 'All')
          query =
              query.where('maritalStatus', isEqualTo: map['Marital Status']);
      }
      if (_isCurrentQueryInvolveDate) query = query.orderBy('dob');

      if (lastFetchedUser != null) {
        query = query.startAfter([lastFetchedUser.creationTime]);
      }
      query = query.orderBy('creationTime');
    }
    return query.limit(10);
  }

  DateTime getStartTime(String age) {
    DateTime time;
    switch (age) {
      case '20-24':
        time = new DateTime(new DateTime.now().year - 20);
        break;
      case '25-29':
        time = new DateTime(new DateTime.now().year - 25);
        break;
      case '30-34':
        time = new DateTime(new DateTime.now().year - 30);
        break;
      case '35-39':
        time = new DateTime(new DateTime.now().year - 35);
        break;
      case '40-44':
        time = new DateTime(new DateTime.now().year - 40);
        break;
      case '45-49':
        time = new DateTime(new DateTime.now().year - 44);
        break;
      case '50-54':
        time = new DateTime(new DateTime.now().year - 50);
        break;
      case '55-59':
        time = new DateTime(new DateTime.now().year - 55);
        break;
      case '60-64':
        time = new DateTime(new DateTime.now().year - 60);
        break;
      case '65+':
        time = new DateTime(new DateTime.now().year - 65);
        break;
    }
    return time;
  }

  DateTime getEndTime(String age) {
    DateTime time;
    switch (age) {
      case '20-24':
        time = new DateTime(new DateTime.now().year - 24);
        break;
      case '25-29':
        time = new DateTime(new DateTime.now().year - 29);
        break;
      case '30-34':
        time = new DateTime(new DateTime.now().year - 34);
        break;
      case '35-39':
        time = new DateTime(new DateTime.now().year - 39);
        break;
      case '40-44':
        time = new DateTime(new DateTime.now().year - 44);
        break;
      case '45-49':
        time = new DateTime(new DateTime.now().year - 49);
        break;
      case '50-54':
        time = new DateTime(new DateTime.now().year - 54);
        break;
      case '55-59':
        time = new DateTime(new DateTime.now().year - 59);
        break;
      case '60-64':
        time = new DateTime(new DateTime.now().year - 64);
        break;
      case '65+':
        time = new DateTime(new DateTime.now().year - 65);
        break;
    }
    return time;
  }

  @override
  void printVersion() {
    print("1.0.0");
  }

  @override
  Future<CurrentUser> fetchCurrentUser(String id) async {
    DocumentSnapshot dc = await db.collection("Users").document(id).get();
    CurrentUser user = CurrentUser.fromMap(dc.data, dc.documentID);
    return user;
  }

  @override
  Future<bool> hasProposalUserContactBeenRequested(
      CurrentUser currentUser, ProposalUser user) async {
    DocumentSnapshot sp = await db
        .collection("Users")
        .document(currentUser.id)
        .collection("requestedContacts")
        .document(user.id)
        .get();
    return sp.exists;
  }

  @override
  Future<String> sendRequestToProposalUser(
      CurrentUser user, ProposalUser toUserId) {
    // TODO: implement sendRequestToProposalUser
    return null;
  }
}
