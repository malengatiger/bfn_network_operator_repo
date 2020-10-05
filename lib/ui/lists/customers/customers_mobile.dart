import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class CustomersMobile extends StatefulWidget {
  @override
  _CustomersMobileState createState() => _CustomersMobileState();
}

class _CustomersMobileState extends State<CustomersMobile>
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
      color: Colors.indigo[300],
      child: Center(
        child: Text(
          "Customers Mobile ",
          style: Styles.blackBoldSmall,
        ),
      ),
    );
  }
}
