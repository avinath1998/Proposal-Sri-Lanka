import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/blocs/appbar/appbar_bloc.dart';
import 'package:proposal/blocs/appbar/appbar_state.dart';
import 'package:proposal/blocs/auth/auth_bloc.dart';
import 'package:proposal/blocs/fetched_matched_users/fetched_matched_users_bloc.dart';
import 'package:proposal/data/network/db.dart';
import 'package:proposal/data/repository/proposal_data_repository.dart';
import 'package:proposal/screens/home_tabs/explore_tab.dart';
import 'package:proposal/screens/home_tabs/matches_tab.dart';
import 'package:proposal/screens/home_tabs/me_tab.dart';
import 'package:proposal/screens/home_tabs/requests_tab.dart';
import 'package:proposal/widgets/proposal_appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _tabCurrentIndex;

  FetchedMatchedUsersBloc fetchedMatchedUsersBloc;

  TabController _tabController;
  PageController _pageController;

  MatchesTab _matchesTab;
  ExploreTab _exploreTab;
  RequestsTab _requestsTab;
  MeTab _meTab;

  @override
  void initState() {
    super.initState();
    _tabCurrentIndex = 0;
    fetchedMatchedUsersBloc = new FetchedMatchedUsersBloc(
        ProposalDataRepository.get(),
        BlocProvider.of<AuthBloc>(context).currentUser);
    _tabController = new TabController(length: 4, initialIndex: 0, vsync: this);
    _tabController.addListener(setHomePage);

    _pageController = new PageController(keepPage: true);

    _matchesTab = new MatchesTab();
    _exploreTab = new ExploreTab();
    _requestsTab = new RequestsTab();
    _meTab = new MeTab();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _pageController.dispose();
    BlocProvider.of<AppbarBloc>(context).dispose();
    fetchedMatchedUsersBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: _buildCustomAppBar(screenSize),
        body: BlocProviderTree(
          blocProviders: [
            BlocProvider<FetchedMatchedUsersBloc>(
              bloc: fetchedMatchedUsersBloc,
            )
          ],
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int index) {
              _setAppBarTitle(index);
            },
            children: <Widget>[_matchesTab, _exploreTab, _requestsTab, _meTab],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar());
  }

  void setHomePage() {
    _pageController.jumpToPage(_tabController.index);
  }

  Widget _buildCustomAppBar(Size screenSize) {
    return PreferredSize(
        preferredSize: Size(screenSize.width, 60),
        child: BlocBuilder(
          bloc: BlocProvider.of<AppbarBloc>(context),
          builder: (BuildContext context, AppbarState state) {
            if (state is DefaultViewTitleState) {
              return AppBar(
                title: Text((state as DefaultViewTitleState).title),
              );
            } else if (state is InitialAppbarState) {
              return AppBar(
                title: Text("Proposal"),
              );
            }
          },
        ));
  }

  void _setAppBarTitle(int index) {
    switch (index) {
      case 0:
        BlocProvider.of<AppbarBloc>(context).changeAppBarTitlt("Matches");
        break;
      case 1:
        BlocProvider.of<AppbarBloc>(context).changeAppBarTitlt("Explore");
        break;
      case 2:
        BlocProvider.of<AppbarBloc>(context).changeAppBarTitlt("Requests");
        break;
      case 3:
        BlocProvider.of<AppbarBloc>(context).changeAppBarTitlt("Me");
        break;
    }
  }

  Widget _buildBottomNavigationBar() {
    return Material(
        color: Colors.white,
        elevation: 2.0,
        child: TabBar(
          onTap: (val) {},
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.pink,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.search),
            ),
            Tab(
              icon: Icon(Icons.favorite),
            ),
            Tab(
              icon: Icon(Icons.account_circle),
            )
          ],
        ));
  }
}
