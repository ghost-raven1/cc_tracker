import 'package:cc_tracker/CCList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const CCTracker());
}

class CCTracker extends StatelessWidget{
  const CCTracker({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    String? version = dotenv.env['VERSION'];
    return MaterialApp(
      title: 'Cryptocurrency tracker $version',
        debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CCList()
    );
  }
}