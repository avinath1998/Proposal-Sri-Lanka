class User {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final String city;
  final DateTime dob;
  final int creationTime;

  User(this.firstName, this.lastName, this.gender, this.city, this.dob,
      this.creationTime, this.id);
}

class ProposalUser extends User {
  final String maritalStatus;
  final String degree;
  final String school;
  final String job;
  final String nativeLanguage;
  final String phoneNum;
  final String regilion;
  final String maritalStatusPref;
  final String thumbnail;
  final List<dynamic> images;
  final bool isMatch;

  ProposalUser(
      String firstName,
      String lastName,
      String gender,
      String city,
      DateTime dob,
      String id,
      int creationTime,
      this.maritalStatus,
      this.degree,
      this.school,
      this.job,
      this.nativeLanguage,
      this.phoneNum,
      this.regilion,
      this.maritalStatusPref,
      this.thumbnail,
      this.images,
      this.isMatch)
      : super(firstName, lastName, gender, city, dob, creationTime, id);
}

class CurrentUser extends User {
  final String maritalStatus;
  final String degree;
  final String school;
  final String job;
  final String nativeLanguage;
  final String phoneNum;
  final String regilion;
  final String maritalStatusPref;
  final String thumbnail;
  final List<dynamic> images;

  CurrentUser(
      String firstName,
      String lastName,
      String gender,
      String city,
      DateTime dob,
      int creationTime,
      this.maritalStatus,
      this.degree,
      this.school,
      this.job,
      this.nativeLanguage,
      this.phoneNum,
      this.regilion,
      this.maritalStatusPref,
      this.thumbnail,
      this.images)
      : super(firstName, lastName, gender, city, dob, creationTime);
}
