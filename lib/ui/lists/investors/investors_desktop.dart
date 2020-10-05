import 'package:flutter/material.dart';

class InvestorsDesktop extends StatefulWidget {
  @override
  _InvestorsDesktopState createState() => _InvestorsDesktopState();
}

class _InvestorsDesktopState extends State<InvestorsDesktop>
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
