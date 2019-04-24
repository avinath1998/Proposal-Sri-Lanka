import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proposal/blocs/appbar/appbar_bloc.dart';
import 'package:proposal/blocs/appbar/appbar_state.dart';
import 'package:proposal/screens/home_tabs/explore_tab.dart';
import 'package:proposal/screens/home_tabs/matches_tab.dart';
import 'package:proposal/screens/home_tabs/me_tab.dart';
import 'package:proposal/screens/home_tabs/requests_tab.dart';
import 'package:proposal/widgets/proposal_appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabCurrentIndex;

  @override
  void initState() {
    super.initState();
    _tabCurrentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: _buildCustomAppBar(screenSize),
        body: _buildHomeTab(_tabCurrentIndex),
        bottomNavigationBar: _buildBottomNavigationBar());
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

  Widget _buildHomeTab(int index) {
    switch (index) {
      case 0:
        BlocProvider.of<AppbarBloc>(context).changeAppBarTitlt("Matches");
        return MatchesTab();
        break;
      case 1:
        BlocProvider.of<AppbarBloc>(context).changeAppBarTitlt("Explore");
        return ExploreTab();
        break;
      case 2:
        BlocProvider.of<AppbarBloc>(context).changeAppBarTitlt("Requests");
        return RequestsTab();
        break;
      case 3:
        BlocProvider.of<AppbarBloc>(context).changeAppBarTitlt("Me");
        return MeTab();
        break;
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (val) {
        setState(() {
          _tabCurrentIndex = val;
        });
      },
      currentIndex: _tabCurrentIndex,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(
            Icons.home,
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            'Explore',
            style: TextStyle(color: Colors.white),
          ),
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Requests',
              style: TextStyle(color: Colors.white),
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              'Me',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
