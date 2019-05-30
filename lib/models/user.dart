import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String gender;
  String city;
  DateTime dob;
  int creationTime;

  User(this.id);

  int getUserAge() {
    return ((DateTime.now().difference(dob)).inDays / 365).truncate();
  }

  @override
  bool operator ==(Object other) {
    if (other is User) {
      return this.id == other.id;
    } else {
      return false;
    }
  }
}

class ProposalUser extends User {
  String maritalStatus;
  String degree;
  String school;
  String job;
  String nativeLanguage;
  String phoneNum;
  String regilion;
  String maritalStatusPref;
  String thumbnail;
  String profilePic;
  String desc;
  String interestIn;
  String email;
  String prefGender;
  int lastModified;
  List<dynamic> images;
  bool isMatch;
  bool isContactRequested;
  bool hasContactAcceptedContactRequest;
  bool hasUserBeenFetchedInFull;

  ProposalUser(String id) : super(id);

  static Map<String, dynamic> toMap(ProposalUser user) {
    Map<String, dynamic> map = new Map();
    map['firstName'] = user.firstName;
    map['lastName'] = user.lastName;
    map['city'] = user.city;
    map['dob'] = Timestamp.fromDate(user.dob);
    map['profilePic'] = user.profilePic;
    map['religion'] = user.regilion;
    map['desc'] = user.desc;
    map['interestIn'] = user.interestIn;
    map['images'] = user.images;
    map['thumbnail'] = user.thumbnail;
    map['degree'] = user.degree;
    map['school'] = user.school;
    map['email'] = user.email;
    map['gender'] = user.gender;
    map['prefGender'] = user.prefGender;
    map['maritalStatus'] = user.maritalStatus;
    map['maritalStatusPref'] = user.maritalStatusPref;
    map['nativeLanguage'] = user.nativeLanguage;
    map['lastModified'] = user.lastModified;
    map['creationTime'] = user.creationTime;

    map['phoneNumber'] = user.phoneNum;
    return map;
  }

  static User fromMap(Map<String, dynamic> data, String id) {
    ProposalUser user = new ProposalUser(id);
    user.firstName = data['firstName'];
    user.lastName = data['lastName'];
    user.city = data['city'];
    user.dob = data['dob'].toDate();
    user.creationTime = data['creationTime'];
    data['job'] != null ? user.job = data['job'] : null;
    data['profilePic'] != null ? user.profilePic = data['profilePic'] : null;
    data['religion'] != null ? user.regilion = data['religion'] : null;
    data['desc'] != null ? user.desc = data['desc'] : null;
    data['interestIn'] != null ? user.interestIn = data['interestIn'] : null;
    data['images'] != null ? user.images = data['images'] : null;
    data['thumbnail'] != null ? user.thumbnail = data['thumbnail'] : null;
    data['degree'] != null ? user.degree = data['degree'] : null;
    data['school'] != null ? user.school = data['school'] : null;
    data['email'] != null ? user.email = data['email'] : null;
    data['gender'] != null ? user.gender = data['gender'] : null;
    data['prefGender'] != null ? user.prefGender = data['prefGender'] : null;
    data['maritalStatus'] != null
        ? user.maritalStatus = data['maritalStatus']
        : null;
    data['maritalStatusPref'] != null
        ? user.maritalStatusPref = data['maritalStatusPref']
        : null;
    data['nativeLanguage'] != null
        ? user.nativeLanguage = data['nativeLanguage']
        : null;
    data['lastModified'] != null
        ? user.lastModified = data['lastModified']
        : null;
    data['phoneNumber'] != null ? user.phoneNum = data['phoneNumber'] : null;
    user.hasUserBeenFetchedInFull = false;
    return user;
  }
}

class CurrentUser extends User {
  String maritalStatus;
  String degree;
  String school;
  String job;
  String nativeLanguage;
  String phoneNum;
  String regilion;
  String maritalStatusPref;
  String thumbnail;
  String desc;
  String interestIn;
  String email;
  String prefGender;
  int lastModified;
  List<dynamic> images;

  static CurrentUser fromMap(Map<String, dynamic> data, String id) {
    CurrentUser user = new CurrentUser(id);
    user.firstName = data['firstName'];
    user.lastName = data['lastName'];
    user.city = data['city'];
    user.dob = data['dob'].toDate();
    user.thumbnail = data['thumbnail'];
    user.creationTime = data['creationTime'];
    data['job'] != null ? user.job = data['job'] : null;
    data['religion'] != null ? user.regilion = data['religion'] : null;
    data['desc'] != null ? user.desc = data['desc'] : null;
    data['interestIn'] != null ? user.interestIn = data['interestIn'] : null;
    data['images'] != null ? user.images = data['images'] : null;
    data['thumbnail'] != null ? user.thumbnail = data['thumbnail'] : null;
    data['degree'] != null ? user.degree = data['degree'] : null;
    data['school'] != null ? user.school = data['school'] : null;
    data['email'] != null ? user.email = data['email'] : null;
    data['gender'] != null ? user.gender = data['gender'] : null;
    data['prefGender'] != null ? user.prefGender = data['prefGender'] : null;
    data['maritalStatus'] != null
        ? user.maritalStatus = data['maritalStatus']
        : null;
    data['maritalStatusPref'] != null
        ? user.maritalStatusPref = data['maritalStatusPref']
        : null;
    data['nativeLanguage'] != null
        ? user.nativeLanguage = data['nativeLanguage']
        : null;
    data['lastModified'] != null
        ? user.lastModified = data['lastModified']
        : null;
    data['phoneNumber'] != null ? user.phoneNum = data['phoneNumber'] : null;
    return user;
  }

  CurrentUser(String id) : super(id);
}
