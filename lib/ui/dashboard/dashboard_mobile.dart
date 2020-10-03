import 'package:bfn_network_operator_repo/ui/dashboard/dashboard_menu.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class DashboardMobile extends StatefulWidget {
  @override
  _DashboardMobileState createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile>
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
    return SafeArea(
        child: Scaffold(
      drawer: DashboardMenu(),
      appBar: AppBar(
        title: Text('BFN Network Operator'),
        bottom: PreferredSize(
            child: Column(
              children: [
                Text(
                  'This is the 🥬 Mobile Dash for the Boss!',
                  style: Styles.whiteSmall,
                ),
                SizedBox(
                  height: 24,
                )
              ],
            ),
            preferredSize: Size.fromHeight(100)),
      ),
    ));
  }
}
