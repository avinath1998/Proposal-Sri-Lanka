import 'package:flutter/material.dart';
import 'package:proposal/blocs/auth/auth_bloc.dart';
import 'package:proposal/screens/root_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/services/auth/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final AuthBloc _authBloc = new AuthBloc(new FirebaseAuth());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proposal',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.pink,
          textTheme: TextTheme()),
      home: BlocProvider(bloc: _authBloc, child: RootScreen()),
    );
  }
}
