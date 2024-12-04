import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelVehicul extends StatefulWidget {
  const ModelVehicul({super.key});

  @override
  State<ModelVehicul> createState() => _ModelVehiculState();
}

class _ModelVehiculState extends State<ModelVehicul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Model Vehicul'),
      ),
    );
  }
}
