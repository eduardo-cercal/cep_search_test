import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      child: IconButton(
        iconSize: 35,
        alignment: Alignment.center,
        onPressed: () {},
        icon: const FaIcon(FontAwesomeIcons.mapLocationDot),
        color: Colors.white,
      ),
    );
  }
}
