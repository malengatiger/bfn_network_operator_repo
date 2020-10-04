import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

import 'dashboard_menu.dart';

class DashboardDesktop extends StatefulWidget {
  @override
  _DashboardDesktopState createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop>
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
    return Scaffold(
      appBar: AppBar(
        title: Text('BFN Network Operator'),
        backgroundColor: Colors.teal.shade400,
        elevation: 0,
        bottom: PreferredSize(
            child: Column(
              children: [
                Text(
                  'This is the  🍊 Desktop Dash for the Boss!',
                  style: Styles.whiteSmall,
                ),
                SizedBox(
                  height: 24,
                )
              ],
            ),
            preferredSize: Size.fromHeight(100)),
      ),
      body: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              Container(
                width: 220,
                child: MenuItems(),
              ),
              Expanded(
                  child: Container(
                color: Colors.red.shade100,
              ))
            ],
          )),
        ],
      ),
    );
  }
}
