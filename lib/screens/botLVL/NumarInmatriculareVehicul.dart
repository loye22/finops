import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumarInmatriculareVehicul extends StatefulWidget {
  const NumarInmatriculareVehicul({super.key});

  @override
  State<NumarInmatriculareVehicul> createState() => _NumarInmatriculareVehiculState();
}

class _NumarInmatriculareVehiculState extends State<NumarInmatriculareVehicul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Numar Inmatriculare Vehicul'),
      ),
    );
  }
}
