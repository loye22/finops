import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MetodaPlata extends StatefulWidget {
  const MetodaPlata({super.key});

  @override
  State<MetodaPlata> createState() => _MetodaPlataState();
}

class _MetodaPlataState extends State<MetodaPlata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Metoda de Plata'),
      ),
    );
  }
}
