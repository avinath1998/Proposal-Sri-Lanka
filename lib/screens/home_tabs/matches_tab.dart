import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/blocs/fetched_matched_users/fetched_matched_users_bloc.dart';
import 'package:proposal/blocs/fetched_matched_users/fetched_matched_users_state.dart';
import 'package:proposal/models/user.dart';

class MatchesTab extends StatefulWidget {
  @override
  _MatchesTabState createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  @override
  void initState() {
    BlocProvider.of<FetchedMatchedUsersBloc>(context).loadData(false);
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
        } else if (state is FetchNextMatchedUsersStateSuccess) {
        } else if (state is FetchMatchUsersErrorState) {
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
        return Text(matchedUsers[index].firstName);
      },
      itemCount: matchedUsers.length,
    );
  }
}
