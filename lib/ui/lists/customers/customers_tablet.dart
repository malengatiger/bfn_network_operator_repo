import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class CustomersTablet extends StatefulWidget {
  @override
  _CustomersTabletState createState() => _CustomersTabletState();
}

class _CustomersTabletState extends State<CustomersTablet>
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
      color: Colors.blue[200],
      child: Center(
        child: Text(
          "Customers TABLET",
          style: Styles.blackBoldLarge,
        ),
      ),
    );
  }
}
