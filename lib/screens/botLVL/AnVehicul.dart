import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnVehicul extends StatefulWidget {
  const AnVehicul({super.key});

  @override
  State<AnVehicul> createState() => _AnVehiculState();
}

class _AnVehiculState extends State<AnVehicul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('An Vehicul'),
      ),
    );
  }
}
