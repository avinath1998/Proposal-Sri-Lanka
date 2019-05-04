import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/blocs/auth/auth_bloc.dart';
import 'package:proposal/blocs/fetched_matched_users/fetched_matched_users_bloc.dart';
import 'package:proposal/blocs/fetched_matched_users/fetched_matched_users_state.dart';
import 'package:proposal/blocs/profile/profile.dart';
import 'package:proposal/models/user.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/widgets/large_timeline_profile_view.dart';

class MatchesTab extends StatefulWidget {
  @override
  _MatchesTabState createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  @override
  void initState() {
    BlocProvider.of<FetchedMatchedUsersBloc>(context).loadData();
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
          return _buildList(matchedUsers);
        } else if (state is FetchMatchUsersErrorState) {
          return (Center(
            child: Text("Error"),
          ));
        } else if (state is InitialFetchedMatchedUsersState) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink,
            ),
          );
        }
      },
    );
  }

  Widget _buildList(List<ProposalUser> matchedUsers) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == matchedUsers.length - 1)
          BlocProvider.of<FetchedMatchedUsersBloc>(context).loadData();
        var context2 = context;
        return BlocProvider(
            bloc: ProfileBloc(
                matchedUsers[index],
                BlocProvider.of<AuthBloc>(context2).currentUser,
                ProposalDataRepository.get()),
            child: LargeTimelineProfileView());
      },
      itemCount: matchedUsers.length,
    );
  }
}
