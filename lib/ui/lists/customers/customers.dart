import 'package:bfn_network_operator_repo/ui/lists/customers/customers_desktop.dart';
import 'package:bfn_network_operator_repo/ui/lists/customers/customers_mobile.dart';
import 'package:bfn_network_operator_repo/ui/lists/customers/customers_tablet.dart';
import 'package:bfnlibrary/data/user.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomerList extends StatefulWidget {
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<UserDTO> users = [];

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
      mobile: CustomersMobile(),
      tablet: CustomersTablet(),
      desktop: CustomersDesktop(),
    );
  }
}
