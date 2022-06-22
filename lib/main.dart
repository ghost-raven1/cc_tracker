import 'package:cc_tracker/CCList.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CCTracker());

class CCTracker extends StatelessWidget{
  const CCTracker({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'CC Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const CCList()
    );
  }
}