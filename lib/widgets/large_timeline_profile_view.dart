import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/blocs/auth/auth_bloc.dart';
import 'package:proposal/blocs/bloc/contact_request_bloc.dart';
import 'package:proposal/blocs/bloc/contact_request_state.dart';
import 'package:proposal/blocs/profile/profile_bloc.dart';
import 'package:proposal/blocs/profile/profile_state.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/models/user.dart';
import 'package:proposal/screens/proposal_user_profile_screen.dart';

import 'circular_contact_button.dart';

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
  ContactRequestBloc _contactRequestBloc;

  @override
  void initState() {
    _contactRequestBloc = new ContactRequestBloc(
        widget.user, widget.currentUser, widget.dataRepository);
    super.initState();
    print("Initializing");
  }

  @override
  void dispose() {
    super.dispose();
    _contactRequestBloc.dispose();
    print("DISPOSING");
  }

  @override
  Widget build(BuildContext context) {
    ProposalUser user = _contactRequestBloc.proposalUser;
    return BlocProvider(
        bloc: _contactRequestBloc,
        child: _buildContainer(user: user, isRequesting: false));
  }

  Widget _buildContainer(
      {@required ProposalUser user, @required isRequesting}) {
    return InkWell(
      onTap: () {
        User currentUser = BlocProvider.of<AuthBloc>(context).currentUser;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      child: ProsposalUserProfileScreen(
                        userToShow: user,
                        currentUser: currentUser,
                        dataRepository: ProposalDataRepository.get(),
                      ),
                      bloc: _contactRequestBloc,
                    )));
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 200.0),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                TransitionToImage(
                  image: AdvancedNetworkImage(user.profilePic,
                      cacheRule: CacheRule(maxAge: const Duration(days: 7))),
                  placeholder: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        user.firstName + " " + user.lastName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
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
                Container(
                  child: BlocBuilder(
                    bloc: _contactRequestBloc,
                    builder: (context, ContactRequestState state) {
                      if (state is ContactRequestSentSuccessState) {
                        return CircularContactButton(
                          isLiked: state.isRequesting,
                          hasContactBeenAccepted: state.hasRequestBeenAccepted,
                          onTap: (requesting) {
                            _contactRequestBloc.sendContactRequest(requesting);
                          },
                        );
                      } else if (state is ContactRequestSendingState) {
                        return CircularContactButton(
                          child: Text(
                            "Loading.....",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.blueAccent,
                            ),
                          ),
                          onTap: (requesting) {},
                        );
                      } else if (state is ContactRequestSentErrorState) {
                        return CircularContactButton(
                          isLiked: widget.user.isContactRequested,
                          onTap: (requesting) {
                            _contactRequestBloc.sendContactRequest(requesting);
                          },
                        );
                      } else {
                        return CircularContactButton(
                          isLiked: widget.user.isContactRequested,
                          hasContactBeenAccepted:
                              widget.user.hasContactAcceptedContactRequest,
                          onTap: (requesting) {
                            _contactRequestBloc.sendContactRequest(requesting);
                          },
                        );
                      }
                    },
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
