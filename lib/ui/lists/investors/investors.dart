import 'package:bfnlibrary/data/user.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'investors_desktop.dart';
import 'investors_mobile.dart';
import 'investors_tablet.dart';

class InvestorList extends StatefulWidget {
  @override
  _InvestorListState createState() => _InvestorListState();
}

class _InvestorListState extends State<InvestorList>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<BFNUser> users = [];

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getData() async {}

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: InvestorsMobile(),
      tablet: InvestorsTablet(),
      desktop: InvestorsDesktop(),
    );
  }
}
