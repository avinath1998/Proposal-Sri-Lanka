import 'package:flutter/material.dart';

class CircularContactButton extends StatelessWidget {
  final Function onTap;
  final bool isLiked;
  final Widget child;

  const CircularContactButton(
      {Key key, @required this.onTap, this.isLiked, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(!isLiked);
      },
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: child == null
            ? Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 30.0,
                color: Colors.white,
              )
            : child,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).accentColor),
      ),
    );
  }
}
