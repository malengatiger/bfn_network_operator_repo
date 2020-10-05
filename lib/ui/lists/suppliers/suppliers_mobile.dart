import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class SuppliersMobile extends StatefulWidget {
  @override
  _SuppliersMobileState createState() => _SuppliersMobileState();
}

class _SuppliersMobileState extends State<SuppliersMobile>
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
      color: Colors.amber[300],
      child: Center(
        child: Text(
          "Suppliers Mobile ",
          style: Styles.blackBoldLarge,
        ),
      ),
    );
  }
}
