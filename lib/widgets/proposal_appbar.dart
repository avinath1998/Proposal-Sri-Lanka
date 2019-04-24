import 'package:flutter/material.dart';

class ProposalAppbar extends StatefulWidget {
  final String title;

  const ProposalAppbar({Key key, @required this.title}) : super(key: key);

  @override
  _ProposalAppbarState createState() => _ProposalAppbarState();
}

class _ProposalAppbarState extends State<ProposalAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(widget.title));
  }
}
