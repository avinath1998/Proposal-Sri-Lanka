import 'package:flutter/material.dart';

class CircularContactButton extends StatelessWidget {
  final Function onTap;
  final bool isLiked;
  final bool hasContactBeenAccepted;
  final Widget child;

  const CircularContactButton(
      {Key key,
      @required this.onTap,
      this.isLiked,
      this.child,
      this.hasContactBeenAccepted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return OutlineButton(
        padding: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        color: Colors.white,
        child: child,
        onPressed: () {},
      );
    } else if (hasContactBeenAccepted != null && hasContactBeenAccepted) {
      return Column(
        children: <Widget>[
          Text(
            "Request Accepted",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
          RaisedButton(
            padding: const EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            color: Colors.green,
            child: Row(
              children: <Widget>[
                Text(
                  "See Contact",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                )
              ],
            ),
            onPressed: () {},
          ),
        ],
      );
    } else if (isLiked) {
      return Column(
        children: <Widget>[
          Text(
            "Request Sent",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
          OutlineButton(
            padding: const EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            color: Colors.white,
            child: Text(
              "Cancel Request",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.blueAccent,
              ),
            ),
            onPressed: () {
              onTap(!isLiked);
            },
          ),
        ],
      );
    } else {
      return RaisedButton(
        padding: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        color: Colors.blueAccent,
        child: Text(
          "Request Info",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        onPressed: () {
          onTap(!isLiked);
        },
      );
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //       padding: const EdgeInsets.all(15.0),
  //       child: child == null
  //           ? isLiked
  //               ? RaisedButton(
  //                   padding: const EdgeInsets.all(10.0),
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(15.0))),
  //                   color: Colors.blueAccent,
  //                   child: Text(
  //                     "Request\nContact",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                   onPressed: () {
  //                     onTap(!isLiked);
  //                   },
  //                 )
  //               : OutlineButton(
  //                   padding: const EdgeInsets.all(10.0),
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(15.0))),
  //                   color: Colors.white,
  //                   child: Text(
  //                     "Contact\nRequested",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       color: Colors.blueAccent,
  //                     ),
  //                   ),
  //                   onPressed: () {
  //                     onTap(!isLiked);
  //                   },
  //                 )
  //           : child);
  // }
}
