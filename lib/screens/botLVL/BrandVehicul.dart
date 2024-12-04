import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrandVehicul extends StatefulWidget {
  const BrandVehicul({super.key});

  @override
  State<BrandVehicul> createState() => _BrandVehiculState();
}

class _BrandVehiculState extends State<BrandVehicul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Brand Vehicul'),
      ),
    );
  }
}
