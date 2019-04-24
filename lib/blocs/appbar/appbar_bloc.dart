import 'dart:async';
import 'package:bloc/bloc.dart';
import './appbar.dart';

class AppbarBloc extends Bloc<AppbarEvent, AppbarState> {
  String _currentTitle;
  String _TAG = "AppbarBloc: ";

  @override
  AppbarState get initialState => InitialAppbarState();

  void changeAppBarTitlt(String title) {
    print("$_TAG Changing Appbar title");
    if (title != null) {
      _currentTitle = title;
      dispatch(TabChangeEvent());
    } else {
      print("_TAG Title is null, could not be changed");
    }
  }

  @override
  Stream<AppbarState> mapEventToState(
    AppbarEvent event,
  ) async* {
    if (event is TabChangeEvent) {
      yield (DefaultViewTitleState(_currentTitle));
    }
  }
}
