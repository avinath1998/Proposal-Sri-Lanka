import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/blocs/profile/profile_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:proposal/models/user.dart';

class LargeTimelineProfileView extends StatefulWidget {
  @override
  _LargeTimelineProfileViewState createState() =>
      _LargeTimelineProfileViewState();
}

class _LargeTimelineProfileViewState extends State<LargeTimelineProfileView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<ProfileBloc>(context).dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProposalUser user = BlocProvider.of<ProfileBloc>(context).proposalUser;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: user.thumbnail,
            placeholder: (context, state) {
              return CircularProgressIndicator();
            },
          ),
          Container(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    user.firstName + " " + user.lastName,
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    "${user.getUserAge()}",
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    "${user.city}",
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
