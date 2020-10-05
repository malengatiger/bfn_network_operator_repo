import 'package:flutter/material.dart';

class SuppliersDesktop extends StatefulWidget {
  @override
  _SuppliersDesktopState createState() => _SuppliersDesktopState();
}

class _SuppliersDesktopState extends State<SuppliersDesktop>
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
    return Container();
  }
}
