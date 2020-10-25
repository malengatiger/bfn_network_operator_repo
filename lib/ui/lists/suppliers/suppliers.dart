import 'package:bfnlibrary/data/user.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'suppliers_desktop.dart';
import 'suppliers_mobile.dart';
import 'suppliers_tablet.dart';

class SupplierList extends StatefulWidget {
  @override
  _SupplierListState createState() => _SupplierListState();
}

class _SupplierListState extends State<SupplierList>
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
      mobile: SuppliersMobile(),
      tablet: SuppliersTablet(),
      desktop: SuppliersDesktop(),
    );
  }
}
