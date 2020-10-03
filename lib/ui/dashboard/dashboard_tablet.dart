import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class DashboardTablet extends StatefulWidget {
  @override
  _DashboardTabletState createState() => _DashboardTabletState();
}

class _DashboardTabletState extends State<DashboardTablet>
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
      color: Colors.indigo,
      child: Center(
        child: Text(
          'I am a Tablet',
          style: Styles.whiteBoldLarge,
        ),
      ),
    );
  }
}
