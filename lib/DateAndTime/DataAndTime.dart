import 'package:flutter/material.dart';

class Dataandtime extends StatefulWidget {
  const Dataandtime({super.key});

  @override
  State<Dataandtime> createState() => _DataandtimeState();
}

class _DataandtimeState extends State<Dataandtime> {
  DateTime todayformat = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("${DateTime.now()}"),
              Text("${DateTime.now()}"),
            ],
          ),
        ),
      ),
    );
  }
}
