import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class InvestorsTablet extends StatefulWidget {
  @override
  _InvestorsTabletState createState() => _InvestorsTabletState();
}

class _InvestorsTabletState extends State<InvestorsTablet>
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
      color: Colors.yellow[200],
      child: Center(
        child: Text(
          "Investors TABLET",
          style: Styles.blackBoldLarge,
        ),
      ),
    );
  }
}
