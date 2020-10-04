import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

import 'dashboard_menu.dart';
import 'grid.dart';

class DashboardTablet extends StatefulWidget {
  @override
  _DashboardTabletState createState() => _DashboardTabletState();
}

class _DashboardTabletState extends State<DashboardTablet>
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
    return Scaffold(
      drawer: DashboardMenu(),
      appBar: AppBar(
        title: Text('BFN Network Operator'),
        backgroundColor: Colors.pink.shade400,
        bottom: PreferredSize(
            child: Column(
              children: [
                Text(
                  'This is the 😻 Tablet Dash for the Boss!',
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
                  child: DashboardGrid(
                items: gridItems,
                gridListener: this,
              ))
            ],
          )),
        ],
      ),
    );
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
    p('🥁 A TABLET dashboard item has been tapped: 🌸 ${item.title} ${item.number}');
  }
}
