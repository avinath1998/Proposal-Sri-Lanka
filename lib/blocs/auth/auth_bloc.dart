import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:proposal/services/auth/auth.dart';
import './auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Auth auth;
  String currentUserId;
  String errorMsg;
  String _TAG = "AuthBloc: ";
  AuthBloc(this.auth);

  @override
  AuthState get initialState => InitialAuthState();

  void initialSignin() async {
    print("$_TAG, Initial Signing In");
    auth.isSignedIn().then((String val) {
      if (currentUserId != null) {
        print("$_TAG, Initial Signing In a Success: $val");
        this.currentUserId = currentUserId;
        dispatch(SignInEvent());
      } else {
        print("$_TAG Initial Signing Failed, Signing Out State Revelead");
        dispatch(SignOutEvent());
      }
    }).catchError((error) {
      print("$_TAG Error Signing in: ${error.toString()}");
      this.errorMsg = error.toString();
      dispatch(SigningInErrorEvent());
    });
  }

  void signIn(String username, String password) async {
    print("$_TAG Signing In");
    auth.signIn(username, password).then((String val) {
      if (val != null) {
        print("$_TAG Signing in a succes: $val");
        this.currentUserId = currentUserId;
        dispatch(SignInEvent());
      } else {
        print("$_TAG Signing in failed");
        dispatch(SignOutEvent());
      }
    }).catchError((error) {
      print("$_TAG, Error Signing Out: ${error.toString()}");
      this.errorMsg = error.toString();
      dispatch(SigningInErrorEvent());
    });
  }

  void signOut() async {
    print("$_TAG Signing out");
    auth.signout().then((val) {
      print("$_TAG Signed Out");
    }).catchError((error) {
      print("$_TAG, Error Signing Out: ${error.toString()}");
      this.errorMsg = error.toString();
      dispatch(SigningOutErrorEvent());
    });
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SignInEvent) {
      yield (SignedInState(currentUserId));
    } else if (event is SignOutEvent) {
      yield (SignedOutState());
    } else if (event is SigningInErrorEvent) {
      yield (SigningInErrorState(errorMsg));
    } else if (event is SigningOutErrorEvent) {
      yield (SigningOutErrorState(errorMsg));
    }
  }
}
