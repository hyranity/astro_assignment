// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({Key? key, this.fullscreen = false}) : super(key: key);

  final bool fullscreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullscreen ? MediaQuery.of(context).size.width : null,
      height: fullscreen ? MediaQuery.of(context).size.height : null,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffA73E37)),
        ),
      ),
    );
  }
}
