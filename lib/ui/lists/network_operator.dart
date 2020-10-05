import 'package:flutter/material.dart';

class NetworkOperator extends StatefulWidget {
  @override
  _NetworkOperatorState createState() => _NetworkOperatorState();
}

class _NetworkOperatorState extends State<NetworkOperator>
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
      color: Colors.pink,
    );
  }
}
