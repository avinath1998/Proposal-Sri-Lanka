import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/blocs/appbar/appbar_bloc.dart';
import 'package:proposal/blocs/auth/auth_bloc.dart';
import 'package:proposal/blocs/auth/auth_state.dart';
import 'package:proposal/screens/home_screen.dart';
import 'package:proposal/screens/signin_screen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).initialSignin();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AuthBloc>(context),
      builder: (BuildContext context, AuthState state) {
        print(state.toString());
        if (state is SignedInState) {
          return BlocProvider(bloc: AppbarBloc(), child: HomeScreen());
        } else if (state is SignedOutState) {
          return SignInScreen();
        } else if (state is SigningInErrorState) {
          return Container(
            child: Scaffold(
              body: Center(
                child: Text("An error has occured, try again later."),
              ),
            ),
          );
        } else if (state is SigningOutErrorState) {}
        return Container(
          child: Scaffold(
            body: Center(
              child: Text("An error has occured, try again later."),
            ),
          ),
        );
      },
    );
  }
}
