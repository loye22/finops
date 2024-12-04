import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class tipOperatiune extends StatefulWidget {
  const tipOperatiune({super.key});

  @override
  State<tipOperatiune> createState() => _tipOperatiuneState();
}

class _tipOperatiuneState extends State<tipOperatiune> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('tipOperatiune'),
      ),
    );
  }
}
