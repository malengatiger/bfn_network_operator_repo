import 'package:bfn_network_operator_repo/ui/dashboard/dashboard_menu.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/grid.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class DashboardMobile extends StatefulWidget {
  @override
  _DashboardMobileState createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile>
    with SingleTickerProviderStateMixin
    implements GridListener {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    getItems();
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
        children: [DashboardGrid(items: gridItems, gridListener: this)],
      ),
    ));
  }

  List<Item> gridItems = [];
  void getItems() {
    gridItems.add(Item(title: "Purchase Orders", number: "4,690"));
    gridItems.add(Item(title: "Members", number: "300"));
    gridItems.add(Item(title: "Invoices", number: "13,688"));
    gridItems.add(Item(title: "InvoiceOffers", number: "3,566"));
    gridItems.add(Item(title: "Accepted Offers", number: "1,800"));
    gridItems.add(Item(title: "Payments", number: "14,950"));
    setState(() {});
  }

  @override
  onGridItemTapped(Item item) {
    p('🌸 A MOBILE dashboard item has been tapped: 🌸 ${item.title} ${item.number}');
  }
}
