import 'package:meta/meta.dart';

@immutable
abstract class AppbarState {}

class InitialAppbarState extends AppbarState {}

class DefaultViewTitleState extends AppbarState {
  final String title;

  DefaultViewTitleState(this.title);
}
