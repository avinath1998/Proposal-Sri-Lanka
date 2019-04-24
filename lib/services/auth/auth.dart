abstract class Auth {
  Future<String> signIn(String username, String password);
  Future<void> signout();
  Future<String> isSignedIn();
}

class FirebaseAuth extends Auth {
  @override
  Future<String> isSignedIn() async {
    return null;
  }

  @override
  Future<String> signIn(String username, String password) async {
    String fixedUserDevelopment = "NQFS2rJraETbFaAqMNgejMfPFWB2";
    return fixedUserDevelopment;
  }

  @override
  Future<void> signout() async {
    return null;
  }
}
