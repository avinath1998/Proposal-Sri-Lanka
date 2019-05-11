import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/blocs/profile/profile_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:proposal/blocs/profile/profile_state.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/models/user.dart';

class LargeTimelineProfileView extends StatefulWidget {
  final ProposalUser user;
  final CurrentUser currentUser;
  final ProposalDataRepository dataRepository;

  const LargeTimelineProfileView(
      {Key key, this.user, this.currentUser, this.dataRepository})
      : super(key: key);

  @override
  _LargeTimelineProfileViewState createState() =>
      _LargeTimelineProfileViewState();
}

class _LargeTimelineProfileViewState extends State<LargeTimelineProfileView> {
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc =
        new ProfileBloc(widget.user, widget.currentUser, widget.dataRepository);
  }

  @override
  void dispose() {
    super.dispose();
    _profileBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProposalUser user = widget.user;
    return BlocProvider(
      bloc: _profileBloc,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: BlocBuilder(
            bloc: _profileBloc,
            builder: (context, ProfileState state) {
              if (state is InitialProfileState) {
                return _buildContainer(user: user, isRequesting: false);
              } else if (state is RequestingContactState) {
                return _buildContainer(user: user, isRequesting: true);
              } else if (state is RequestedContactState) {
                return _buildContainer(user: user, isRequesting: false);
              } else if (state is NoRequestedContactState) {
                return _buildContainer(user: user, isRequesting: false);
              } else if (state is RequestingContactErrorState) {
                return _buildContainer(user: user, isRequesting: false);
              }
            }),
      ),
    );
  }

  Widget _buildContainer(
      {@required ProposalUser user, @required isRequesting}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: 200.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: user.thumbnail,
                placeholder: (context, state) {
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
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
    );
  }
}
