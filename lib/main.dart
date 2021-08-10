import 'package:flutter_webdeneme/screens/Eczane_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webdeneme/screens/Eczane_list_forWeb.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nobetci Eczane",
      theme: ThemeData(primarySwatch: Colors.red),
      home: EczaneListesiforWeb(),
    );
  }
}
