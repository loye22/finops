import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusPlata extends StatefulWidget {
  const StatusPlata({super.key});

  @override
  State<StatusPlata> createState() => _StatusPlataState();
}

class _StatusPlataState extends State<StatusPlata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Status Plata'),
      ),
    );
  }
}
