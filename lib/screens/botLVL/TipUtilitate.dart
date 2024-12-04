import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TipUtilitate extends StatefulWidget {
  const TipUtilitate({super.key});

  @override
  State<TipUtilitate> createState() => _TipUtilitateState();
}

class _TipUtilitateState extends State<TipUtilitate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Tip Utilitate'),
      ),
    );
  }
}
