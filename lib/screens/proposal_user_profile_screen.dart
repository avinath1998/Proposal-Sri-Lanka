import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/blocs/bloc/contact_request_bloc.dart';
import 'package:proposal/blocs/bloc/contact_request_state.dart';
import 'package:proposal/blocs/profile/profile_bloc.dart';
import 'package:proposal/blocs/profile/profile_state.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/models/user.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:proposal/widgets/circular_contact_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flushbar/flushbar.dart';

class ProsposalUserProfileScreen extends StatefulWidget {
  final ProposalUser userToShow;
  final CurrentUser currentUser;
  final ProposalDataRepository dataRepository;

  ProsposalUserProfileScreen(
      {Key key,
      @required this.userToShow,
      @required this.currentUser,
      @required this.dataRepository})
      : super(key: key);

  @override
  _ProsposalUserProfileScreenState createState() =>
      _ProsposalUserProfileScreenState();
}

class _ProsposalUserProfileScreenState
    extends State<ProsposalUserProfileScreen> {
  ValueNotifier<int> pageIndexNotifier;
  int _currentImagePageIndex = 0;
  ProfileBloc _profileBloc;
  ContactRequestBloc _contactRequestBloc;

  @override
  void initState() {
    super.initState();
    pageIndexNotifier = new ValueNotifier(0);
    _profileBloc = new ProfileBloc(
        widget.userToShow, widget.currentUser, widget.dataRepository);
    _profileBloc.requestProposalUserFullDetails();
    _contactRequestBloc = new ContactRequestBloc(
        widget.userToShow, widget.currentUser, widget.dataRepository);
  }

  @override
  void dispose() {
    super.dispose();
    pageIndexNotifier.dispose();
    _profileBloc.dispose();
    _contactRequestBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      bloc: _profileBloc,
      child: Scaffold(
          appBar: AppBar(
              title: Text(widget.userToShow.firstName +
                  " " +
                  widget.userToShow.lastName)),
          body: SlidingUpPanel(
            maxHeight: 400.0,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
                color: Colors.black,
              ),
            ],
            backdropTapClosesPanel: true,
            panel: Container(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
              child: BlocBuilder(
                bloc: _profileBloc,
                builder: (context, ProfileState state) {
                  if (state is SuccessFetchingFullDetailsState) {
                    return _buildProfileDetails();
                  } else if (state is SuccessFetchingFullDetailsState) {
                    return Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  } else if (state is ErrorFetchingFullDetailsState) {
                    return Center(
                      child: Text("An error has occured, try again later :("),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                },
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
            ),
            body: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 0.0),
                  child: PageViewIndicator(
                    highlightedBuilder: (animationController, index) =>
                        ScaleTransition(
                          scale: CurvedAnimation(
                            parent: animationController,
                            curve: Curves.ease,
                          ),
                          child: Circle(
                            size: 12.0,
                            color: Colors.black45,
                          ),
                        ),
                    pageIndexNotifier: pageIndexNotifier,
                    length: widget.userToShow.images.length + 1,
                    normalBuilder: (animationController, index) => Circle(
                          size: 8.0,
                          color: Colors.black87,
                        ),
                  ),
                ),
                Container(
                  height: screenSize.height / 1.5,
                  child: PageView.builder(
                    itemCount: widget.userToShow.images.length + 1,
                    onPageChanged: (int val) {
                      pageIndexNotifier.value = val;
                    },
                    itemBuilder: (context, index) {
                      return TransitionToImage(
                        alignment: Alignment.center,
                        image: AdvancedNetworkImage(
                            index == 0
                                ? widget.userToShow.profilePic
                                : widget.userToShow.images[index - 1],
                            cacheRule:
                                CacheRule(maxAge: const Duration(days: 7))),
                        placeholder: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void showMessage(String title, String message, Icon icon) async {
    Flushbar(
      title: title,
      message: message,
      icon: icon,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  Widget _buildProfileDetails() {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            width: 30.0,
            child: Container(
              height: 5.0,
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: screenSize.width / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Hi, I'm",
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    widget.userToShow.firstName +
                        " " +
                        widget.userToShow.lastName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
            BlocBuilder(
              bloc: _contactRequestBloc,
              builder: (context, ContactRequestState state) {
                if (state is ContactRequestSentSuccessState) {
                  return CircularContactButton(
                    isLiked: state.isRequesting,
                    onTap: (requesting) {
                      print("Success");
                      _contactRequestBloc.sendContactRequest(requesting);
                    },
                  );
                } else if (state is ContactRequestSendingState) {
                  return CircularContactButton(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                    onTap: (requesting) {
                      print("Sending");
                    },
                  );
                } else if (state is ContactRequestSentErrorState) {
                  return CircularContactButton(
                    isLiked: widget.userToShow.isContactRequested,
                    onTap: (requesting) {
                      print("Error");
                      _contactRequestBloc.sendContactRequest(requesting);
                    },
                  );
                } else {
                  return CircularContactButton(
                    isLiked: widget.userToShow.isContactRequested,
                    onTap: (requesting) {
                      print("default");
                      _contactRequestBloc.sendContactRequest(requesting);
                    },
                  );
                }
              },
            )
          ],
        ),
        Expanded(
          child: Container(
            width: screenSize.width * 0.9,
            margin: const EdgeInsets.only(top: 10.0),
            alignment: Alignment.centerLeft,
            child: _buildUserDetails(),
          ),
        )
      ],
    );
  }

  Widget _buildUserDetails() {
    ProposalUser user = widget.userToShow;
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          _getUserDetail(Icons.location_city, user.city),
          _getUserDetail(Icons.cake, "${user.getUserAge()}"),
          user.regilion != null
              ? _getUserDetail(Icons.account_circle, user.regilion)
              : Container(),
          user.job != null ? _getUserDetail(Icons.work, user.job) : Container(),
          user.school != null
              ? _getUserDetail(Icons.school, user.school)
              : Container(),
          user.degree != null
              ? _getUserDetail(Icons.school, user.degree)
              : Container(),
          user.maritalStatus != null
              ? _getUserDetail(Icons.account_circle, user.maritalStatus)
              : Container(),
          user.nativeLanguage != null
              ? _getUserDetail(Icons.account_circle, user.nativeLanguage)
              : Container(),
          user.interestIn != null
              ? _getUserDetail(Icons.favorite, user.interestIn)
              : Container(),
          user.desc != null
              ? _getUserDetail(Icons.account_circle, user.desc)
              : Container(),
        ],
      ),
    );
  }

  Widget _getUserDetail(IconData icon, String detail) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.black,
            size: 25,
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              detail,
              style: TextStyle(fontSize: 17.0),
            ),
          ),
        ],
      ),
    );
  }
}
