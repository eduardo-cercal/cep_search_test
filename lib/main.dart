import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Home/home_screen.dart';

void main()=>runApp(const CEPSearch());

class CEPSearch extends StatelessWidget {
  const CEPSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}