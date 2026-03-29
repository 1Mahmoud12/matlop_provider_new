import 'package:flutter/material.dart';

class CustomOffOnSwitcher extends StatefulWidget {
  const CustomOffOnSwitcher({super.key});

  @override
  _CustomOffOnSwitcherState createState() => _CustomOffOnSwitcherState();
}

class _CustomOffOnSwitcherState extends State<CustomOffOnSwitcher> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Switch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
        },
        activeTrackColor: Colors.teal.withOpacity(0.7), // Track color when active
        activeColor: Colors.white, // Knob color when active
        inactiveThumbColor: Colors.white, 
        inactiveTrackColor: Colors.grey.withOpacity(0.2), 
      ),
    );
  }
}
