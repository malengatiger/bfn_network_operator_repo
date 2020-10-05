import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class CustomersDesktop extends StatefulWidget {
  @override
  _CustomersDesktopState createState() => _CustomersDesktopState();
}

class _CustomersDesktopState extends State<CustomersDesktop>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal[200],
      child: Center(
        child: Text(
          "Customers DESKTOP",
          style: Styles.blackBoldLarge,
        ),
      ),
    );
  }
}
