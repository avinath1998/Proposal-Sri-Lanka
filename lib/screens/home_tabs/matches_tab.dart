import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/blocs/auth/auth_bloc.dart';
import 'package:proposal/blocs/fetched_matched_users/fetched_matched_users_bloc.dart';
import 'package:proposal/blocs/fetched_matched_users/fetched_matched_users_state.dart';
import 'package:proposal/blocs/profile/profile.dart';
import 'package:proposal/models/user.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/widgets/large_timeline_profile_view.dart';

import '../proposal_user_profile_screen.dart';

class MatchesTab extends StatefulWidget {
  @override
  _MatchesTabState createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<FetchedMatchedUsersBloc>(context),
      builder: (context, FetchedMatchedUsersState state) {
        print(state.toString());
        if (state is FetchMatchedUsersStateSuccess) {
          List<ProposalUser> matchedUsers = state.matches;
          print('building list ${matchedUsers.length}');
          return _buildList(matchedUsers);
        } else if (state is FetchMatchUsersErrorState) {
          return (Center(
            child: Text("Error"),
          ));
        } else if (state is InitialFetchedMatchedUsersState) {
          BlocProvider.of<FetchedMatchedUsersBloc>(context).loadData();
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildList(List<ProposalUser> matchedUsers) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == matchedUsers.length - 1) {
          BlocProvider.of<FetchedMatchedUsersBloc>(context).loadData();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {
                  User currentUser =
                      BlocProvider.of<AuthBloc>(context).currentUser;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProsposalUserProfileScreen(
                                userToShow: matchedUsers[index],
                                currentUser: currentUser,
                                dataRepository: ProposalDataRepository.get(),
                              )));
                },
                child: LargeTimelineProfileView(
                    user: matchedUsers[index],
                    currentUser: BlocProvider.of<AuthBloc>(context).currentUser,
                    dataRepository: ProposalDataRepository.get()),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: LinearProgressIndicator(),
                ),
              )
            ],
          );
        } else {
          return InkWell(
            onTap: () {
              User currentUser = BlocProvider.of<AuthBloc>(context).currentUser;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProsposalUserProfileScreen(
                            userToShow: matchedUsers[index],
                            currentUser: currentUser,
                            dataRepository: ProposalDataRepository.get(),
                          )));
            },
            child: Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: LargeTimelineProfileView(
                  user: matchedUsers[index],
                  currentUser: BlocProvider.of<AuthBloc>(context).currentUser,
                  dataRepository: ProposalDataRepository.get()),
            ),
          );
        }
      },
      itemCount: matchedUsers.length,
    );
  }
}
