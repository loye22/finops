import 'package:flutter/material.dart';

class AlertsWidget extends StatefulWidget {
  final String alertText;
   AlertType alertType;

   AlertsWidget({
    super.key,
    required this.alertText,
     this.alertType =  AlertType.noAlert,
  });

  @override
  State<AlertsWidget> createState() => _AlertsWidgetState();
}

class _AlertsWidgetState extends State<AlertsWidget> {
  @override
  Widget build(BuildContext context) {
    // If there's no alert, return an empty SizedBox to take up no space
    if (widget.alertType == AlertType.noAlert) {
      return Positioned(bottom: 0, left: 0, right: 0, child: Container(
        height: MediaQuery.of(context).size.height * 0,
        color: Colors.white,
      ));
    }

    // Determine background color and icon based on alert type
    Color backgroundColor;
    Icon alertIcon;

    switch (widget.alertType) {
      case AlertType.warning:
        backgroundColor = Colors.orangeAccent;
        alertIcon = Icon(Icons.warning, color: Colors.black , );
        break;
      case AlertType.urgent:
        backgroundColor = Colors.redAccent;
        alertIcon = Icon(Icons.error,color: Colors.black );
        break;
      case AlertType.reminder:
        backgroundColor = Colors.blueAccent;
        alertIcon = Icon(Icons.info, color: Colors.white );
        break;
      default:
        backgroundColor = Colors.black;
        alertIcon = Icon(Icons.info, color: Colors.transparent);
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: backgroundColor,
        height: MediaQuery.of(context).size.height * .055,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0 , left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              alertIcon,
              const SizedBox(width: 10),
              Text(
                widget.alertText,
                style:  TextStyle(color: widget.alertType == AlertType.reminder ? Colors.white  : Colors.black , fontWeight:  FontWeight.bold , fontSize: 18),
              ),
              const SizedBox(width: 10),
              Tooltip(
                message: 'Ignoră?', // Tooltip in Romanian
                child: IconButton(
                  icon: Icon(Icons.close, color: widget.alertType == AlertType.reminder ? Colors.white  : Colors.black ),
                  onPressed: () {
                    this.widget.alertType = AlertType.noAlert ;
                    setState(() {});
                    // Action to dismiss alert (e.g., reset to no alert)
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define alert types for easy selection
enum AlertType { noAlert, warning, urgent, reminder }
