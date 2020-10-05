import 'package:bfn_network_operator_repo/ui/dashboard/dashboard.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

import 'dashboard_menu.dart';
import 'grid.dart';
import 'helper.dart';

class DashboardDesktop extends StatefulWidget {
  @override
  _DashboardDesktopState createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop>
    with SingleTickerProviderStateMixin
    implements GridListener, MenuListener {
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
        appBar: AppBar(
          title: Text('BFN Network Boss'),
          backgroundColor: Colors.teal.shade200,
          elevation: 0,
          bottom: PreferredSize(
              child: Column(
                children: [
                  NameView(imageSize: 100.0),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
              preferredSize: Size.fromHeight(100)),
        ),
        backgroundColor: Colors.brown[50],
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Expanded(
                    child: Row(
                  children: [
                    Container(
                      width: 220,
                      child: MenuItems(this),
                    ),
                    Expanded(
                      child: _getView(),
                    )
                  ],
                )),
              ],
            )
          ],
        ));
  }

  Widget _getView() {
    if (menuAction == null) {
      return getDashboard(gridItems, this, 3);
    } else {
      if (menuAction == DASHBOARD) {
        return getDashboard(gridItems, this, 3);
      }
      return getContentView(menuAction);
    }
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
    p('🍯 A DESKTOP dashboard item has been tapped: 🌸 ${item.title} ${item.number}');
  }

  int menuAction;
  @override
  onMenuItem(int action) {
    setState(() {
      menuAction = action;
    });

    switch (action) {
      case DASHBOARD:
        p('🥁 A DESKTOP/WEB: 😻 Dashboard menu item has been tapped: 🌸 ');
        break;
      case PURCHASE_ORDERS:
        p('🥁 A DESKTOP/WEB: 🍐 PurchaseOrder menu item has been tapped: 🌸 ');
        break;
      case INVOICES:
        p('🥁 A DESKTOP/WEB: 🍐 Invoices menu item has been tapped: 🌸 ');
        break;
      case INVOICE_OFFERS:
        p('🥁 A DESKTOP/WEB: 🥬 InvoiceOffers menu item has been tapped: 🌸 ');
        break;
      case ACCEPTED_OFFERS:
        p('🥁 A DESKTOP/WEB: 🥬 Accepted Offers menu item has been tapped: 🌸 ');
        break;
      case INVESTORS:
        p('🥁 A DESKTOP/WEB: 💛 Investors menu item has been tapped: 🌸 ');
        break;
      case SUPPLIERS:
        p('🥁 A DESKTOP/WEB: 💛 Suppliers menu item has been tapped: 🌸 ');
        break;
      case CUSTOMERS:
        p('🥁 A DESKTOP/WEB: 💙 Customers menu item has been tapped: 🌸 ');
        break;
      case NODES:
        p('🥁 A DESKTOP/WEB: 💙 Nodes menu item has been tapped: 🌸 ');
        break;
    }
  }
}
