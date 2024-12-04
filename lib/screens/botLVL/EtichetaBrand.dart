import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EtichetaBrand extends StatefulWidget {
  const EtichetaBrand({super.key});

  @override
  State<EtichetaBrand> createState() => _EtichetaBrandState();
}

class _EtichetaBrandState extends State<EtichetaBrand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Eticheta Brand'),
      ),
    );
  }
}
