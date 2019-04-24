import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/blocs/auth/auth_bloc.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: RaisedButton(
          child: Text("Sign in"),
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).signIn("avinath", "avinath");
          },
        )),
      ),
    );
  }
}
