import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipPlata extends StatefulWidget {
  const TipPlata({super.key});

  @override
  State<TipPlata> createState() => _TipPlataState();
}

class _TipPlataState extends State<TipPlata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tip Plata'),
      ),
    );
  }
}
