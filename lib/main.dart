import 'package:flutter/material.dart';
import 'package:devoxx/data.dart';

// import 'package:devoxx/_main.dart' as prep;

void main() => runApp(DevoxxApp());

class DevoxxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Hello Devoxx!')),
      ),
    );
  }
}
