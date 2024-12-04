import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocatieConsum extends StatefulWidget {
  const LocatieConsum({super.key});

  @override
  State<LocatieConsum> createState() => _LocatieConsumState();
}

class _LocatieConsumState extends State<LocatieConsum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Locatie Consum'),
      ),
    );
  }
}
