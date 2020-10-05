import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class InvestorsMobile extends StatefulWidget {
  @override
  _InvestorsMobileState createState() => _InvestorsMobileState();
}

class _InvestorsMobileState extends State<InvestorsMobile>
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
      color: Colors.teal[300],
      child: Center(
        child: Text(
          "Investors Mobile ",
          style: Styles.blackBoldSmall,
        ),
      ),
    );
  }
}
