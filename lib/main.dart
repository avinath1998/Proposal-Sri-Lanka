import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proposal/blocs/auth/auth_bloc.dart';
import 'package:proposal/screens/root_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/services/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final AuthBloc _authBloc = new AuthBloc(new FirebaseAuth());

  @override
  Widget build(BuildContext context) {
    // List<String> jobs = ['Software Engineer', "Chemical Engineer", "Mechanic"];
    // List<String> maritalStatus = [
    //   'Never married',
    //   "Divorced",
    //   "Anulled",
    //   "Widowed"
    // ];
    // List<String> martitalStatusPref = [
    //   'Never married',
    //   "Divorced",
    //   "Anulled",
    //   "Widowed"
    // ];
    // List<String> nativeLanguages = ['Sinhalese', "Tamil", "English", "Malay"];
    // List<String> phoneNum = ["0768043123", "0768043183"];
    // List<String> religions = ['Christianity', 'Islam', "Buddhism", "Hinduism"];
    // List<String> schools = [
    //   'University of Moratuwa',
    //   'Informatics Institute of Technology'
    // ];
    // List<String> degree = [
    //   'Bsc. Software Engineering',
    //   'Bxc. Buisness Analysis'
    // ];
    // List<String> cities = [
    //   'Anuradhapura, Sri Lanka',
    //   'Colombo, Sri Lanka',
    //   'Ampara, Sri Lanka',
    //   'Badulla, Sri Lanka',
    //   'Batticaloa, Sri Lanka',
    //   'Gampaha, Sri Lanka',
    //   'Hambantota, Sri Lanka',
    //   'Kalutara, Sri Lanka'
    // ];
    // List<String> firstName = ["Lang", "Mabelle", "Hobert", "Linh"];
    // List<String> lastName = ["Milbrandt", "Bartholomew", "Hobert", "Linh"];
    // List<DateTime> dob = [
    //   new DateTime.utc(1989, 11, 9),
    //   new DateTime.utc(1990, 11, 9),
    //   new DateTime.utc(1991, 11, 9),
    //   new DateTime.utc(1992, 11, 9),
    //   new DateTime.utc(1990, 11, 9),
    //   new DateTime.utc(1994, 11, 9),
    //   new DateTime.utc(1985, 11, 9),
    //   new DateTime.utc(1976, 11, 9),
    //   new DateTime.utc(1977, 11, 9),
    //   new DateTime.utc(1965, 11, 9),
    //   new DateTime.utc(1969, 11, 9),
    //   new DateTime.utc(1997, 11, 9),
    //   new DateTime.utc(1987, 11, 9),
    //   new DateTime.utc(1945, 11, 9),
    //   new DateTime.utc(1939, 11, 9),
    //   new DateTime.utc(1998, 11, 9),
    //   new DateTime.utc(1978, 11, 9),
    //   new DateTime.utc(1989, 11, 9),
    //   new DateTime.utc(1989, 11, 9),
    //   new DateTime.utc(1990, 11, 9),
    //   new DateTime.utc(1989, 11, 9),
    //   new DateTime.utc(1989, 11, 9),
    //   new DateTime.utc(1990, 11, 9),
    //   new DateTime.utc(1989, 11, 9),
    //   new DateTime.utc(1989, 11, 9),
    //   new DateTime.utc(1990, 11, 9),
    //   new DateTime.utc(1989, 11, 9),
    //   new DateTime.utc(1989, 11, 9),
    //   new DateTime.utc(1990, 11, 9),
    //   new DateTime.utc(1989, 11, 9),
    // ];
    // for (int i = 0; i < 10000; i++) {
    //   print("Uploading user");
    //   Random random = new Random();
    //   ProposalUser user = new ProposalUser("1");
    //   user.firstName = firstName[random.nextInt(firstName.length)];
    //   user.lastName = lastName[random.nextInt(lastName.length)];
    //   user.city = cities[random.nextInt(cities.length)];
    //   user.dob = dob[random.nextInt(dob.length)];
    //   user.regilion = religions[random.nextInt(religions.length)];
    //   user.phoneNum = phoneNum[random.nextInt(phoneNum.length)];
    //   user.nativeLanguage =
    //       nativeLanguages[random.nextInt(nativeLanguages.length)];
    //   user.maritalStatusPref =
    //       martitalStatusPref[random.nextInt(martitalStatusPref.length)];
    //   user.maritalStatus = maritalStatus[random.nextInt(maritalStatus.length)];
    //   user.profilePic = "https://picsum.photos/700/600?image=$i";
    //   user.thumbnail = "https://picsum.photos/300/300?image=$i";
    //   user.interestIn =
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries";
    //   user.desc =
    //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries";
    //   user.creationTime = new DateTime.now().millisecondsSinceEpoch;
    //   user.lastModified = new DateTime.now().millisecondsSinceEpoch;
    //   user.gender = 'female';
    //   user.prefGender = 'male';
    //   user.images = [
    //     "https://picsum.photos/800/600?image=$i",
    //     "https://picsum.photos/700/600?image=${i + 10}"
    //         "https://picsum.photos/600/600?image=${i + 20}"
    //   ];
    //   Firestore.instance.collection("Users").add(ProposalUser.toMap(user));
    // }

    return MaterialApp(
      title: 'Proposal',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.blue,
          textTheme: TextTheme()),
      home: BlocProvider(bloc: _authBloc, child: RootScreen()),
    );
  }
}
