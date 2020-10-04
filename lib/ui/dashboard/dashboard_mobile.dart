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
      appBar: AppBar(
        title: Text('BFN Network Operator'),
        bottom: PreferredSize(
            child: Column(
              children: [
                Text(
                  ' 🥬 Dashboard 🥬 for Tiger aka Black Cat!!',
                  style: Styles.whiteSmall,
                ),
                SizedBox(
                  height: 24,
                )
              ],
            ),
            preferredSize: Size.fromHeight(120)),
      ),
      drawer: DashboardMenu(),
      body: Stack(
        children: [
          Column(
            children: [
              Card(
                elevation: 2.0,
                color: Colors.teal.shade100,
              )
            ],
          )
        ],
      ),
    ));
  }
}
