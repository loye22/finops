import 'package:flutter/material.dart';

class EntityInfoCard extends StatelessWidget {
  final String entityName;
  final String cui;
  final String regCom;
  final String adresa;
  final int alertCount;

  EntityInfoCard({
    required this.entityName,
    required this.cui,
    required this.regCom,
    required this.adresa,
    required this.alertCount,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entityName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CUI',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(cui),
                      SizedBox(height: 8),
                      Text(
                        'Reg Com',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(regCom),
                      SizedBox(height: 8),
                      Text(
                        'Adresa',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(adresa),
                    ],
                  ),
                  Spacer(),
                  AlertBox(alertCount: alertCount),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlertBox extends StatelessWidget {
  final int alertCount;

  AlertBox({required this.alertCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF9EAD2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ai $alertCount alerte pe aceasta entitate',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          TextButton(
            onPressed: () {
              // Handle "Vezi alertele" action here
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(30, 20),
              alignment: Alignment.centerLeft,
            ),
            child: Text(
              'Vezi alertele',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
