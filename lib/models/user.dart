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

  ProposalUser(String id) : super(id);

  static User fromMap(Map<String, dynamic> data, String id) {
    ProposalUser user = new ProposalUser(id);
    user.firstName = data['firstName'];
    user.lastName = data['lastName'];
    user.city = data['city'];
    user.dob = data['dob'];
    user.thumbnail = data['thumbnail'];
    user.creationTime = data['creationTime'];
    data['job'] != null ? user.job = data['job'] : null;
    data['profilePic'] != null ? user.job = data['profilePic'] : null;
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
    user.dob = data['dob'];
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
