import 'package:finops/models/staticVar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatefulWidget {
  @override
  _NotificationIconState createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  OverlayEntry? _overlayEntry;
  bool isMenuVisible = false;

  // Dummy notifications list for demonstration
  List<String> notifications = [
    'New message from John',
    'Your report is ready',
    'System update available',
    'System update available',

  ];

  @override
  void dispose() {
    _removeMenu();
    super.dispose();
  }

  // Function to create the overlay for the dropdown menu
  OverlayEntry _createMenuOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => Positioned(

        right: staticVar.fullWidth(context) *.05,
        top: offset.dy ,   // Offset the menu below the icon
        width: 300, // Adjust menu width
        child: Material(
          color: Colors.transparent,
          child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              // Smooth opening animation
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150, // Adjust as needed for the list height
                      child: ListView.builder(
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(notifications[index],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14)),
                            onTap: () {
                              // Handle notification click
                              print('Tapped on: ${notifications[index]}');
                            },
                          );
                        },
                      ),
                    ),
                    // Adding the minus button at the bottom
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            _removeMenu();
                          },
                          icon: Icon(Icons.close, color: Colors.red),
                        ),
                      ],
                    ),
                  ])),
        ),
      ),
    );
  }

  void _toggleMenu() {
    if (isMenuVisible) {
      _removeMenu();
    } else {
      _showMenu();
    }
  }

  void _showMenu() {
    _overlayEntry = _createMenuOverlay();
    Overlay.of(context)?.insert(_overlayEntry!);
    setState(() {
      isMenuVisible = true;
    });
  }

  void _removeMenu() {
    _overlayEntry?.remove();
    setState(() {
      isMenuVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleMenu,
      child: Stack(
        children: [
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          if (isMenuVisible)
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Text(
                  '-', // Minus when the menu is opened
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Text(
                  '3', // Number of notifications when closed
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
