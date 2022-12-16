// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({Key? key, required this.onPressed, required this.icon, this.padding = 6.0}) : super(key: key);

  final Function onPressed;
  final IconData icon;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).cardColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
