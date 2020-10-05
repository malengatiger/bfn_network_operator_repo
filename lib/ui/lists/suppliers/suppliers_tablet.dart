import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class SuppliersTablet extends StatefulWidget {
  @override
  _SuppliersTabletState createState() => _SuppliersTabletState();
}

class _SuppliersTabletState extends State<SuppliersTablet>
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
      color: Colors.lime[300],
      child: Center(
        child: Text(
          "Suppliers TABLET",
          style: Styles.blackBoldLarge,
        ),
      ),
    );
  }
}
