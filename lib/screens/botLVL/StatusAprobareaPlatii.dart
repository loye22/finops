import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusAprobareaPlatii extends StatefulWidget {
  const StatusAprobareaPlatii({super.key});

  @override
  State<StatusAprobareaPlatii> createState() => _StatusAprobareaPlatiiState();
}

class _StatusAprobareaPlatiiState extends State<StatusAprobareaPlatii> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Status Aprobarea Platii'),
      ),
    );
  }
}
