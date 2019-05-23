import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/blocs/profile/profile_bloc.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/models/user.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

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

  @override
  void initState() {
    super.initState();
    pageIndexNotifier = new ValueNotifier(0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageIndexNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: ProfileBloc(
          widget.userToShow, widget.currentUser, widget.dataRepository),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.userToShow.firstName),
        ),
        body: Container(
          child: Center(
            child: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                PageViewIndicator(
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
                  length: widget.userToShow.images.length,
                  normalBuilder: (animationController, index) => Circle(
                        size: 8.0,
                        color: Colors.black87,
                      ),
                ),
                PageView.builder(
                  itemCount: widget.userToShow.images.length,
                  onPageChanged: (int val) {
                    pageIndexNotifier.value = val;
                  },
                  itemBuilder: (context, index) {
                    return TransitionToImage(
                      image: AdvancedNetworkImage(
                          widget.userToShow.images[index],
                          cacheRule:
                              CacheRule(maxAge: const Duration(days: 7))),
                      placeholder: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
