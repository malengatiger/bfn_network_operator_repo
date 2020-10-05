import 'package:bfn_network_operator_repo/ui/dashboard/dashboard_menu.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/grid.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'helper.dart';

class DashboardMobile extends StatefulWidget {
  @override
  _DashboardMobileState createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile>
    with SingleTickerProviderStateMixin
    implements GridListener, MenuListener {
  AnimationController _controller;
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();

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
              title: Text(
                'BFN Network Operator',
                style: Styles.whiteSmall,
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.refresh_sharp,
                      color: Colors.white,
                    ),
                    onPressed: null)
              ],
              backgroundColor: Colors.pink[300],
              bottom: PreferredSize(
                  child: Column(
                    children: [
                      NameView(imageSize: 60.0),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  preferredSize: Size.fromHeight(80)),
            ),
            backgroundColor: Colors.brown[50],
            body: Scaffold(
              drawer: DashboardMenu(this),
              body: Stack(
                children: [
                  _getView(),
                ],
              ),
            )));
  }

  Widget _getView() {
    if (menuAction == null) {
      return getDashboard(gridItems, this, 2);
    } else {
      if (menuAction == DASHBOARD) {
        return getDashboard(gridItems, this, 2);
      }
      return getContentView(menuAction);
    }
  }

  int menuAction;
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

  @override
  onMenuItem(int action) {
    setState(() {
      menuAction = action;
    });
    switch (action) {
      case DASHBOARD:
        p('🥁 A MOBILE: 😻 Dashboard menu item has been tapped: 🌸 ');
        break;
      case PURCHASE_ORDERS:
        p('🥁 A MOBILE: 🍐 PurchaseOrder menu item has been tapped: 🌸 ');
        break;
      case INVOICES:
        p('🥁 A MOBILE: 🍐 Invoices menu item has been tapped: 🌸 ');
        break;
      case INVOICE_OFFERS:
        p('🥁 A MOBILE: 🥬 InvoiceOffers menu item has been tapped: 🌸 ');
        break;
      case ACCEPTED_OFFERS:
        p('🥁 A MOBILE: 🥬 Accepted Offers menu item has been tapped: 🌸 ');
        break;
      case INVESTORS:
        p('🥁 A MOBILE: 💛 Investors menu item has been tapped: 🌸 ');
        break;
      case SUPPLIERS:
        p('🥁 A MOBILE: 💛 Suppliers menu item has been tapped: 🌸 ');
        break;
      case CUSTOMERS:
        p('🥁 A MOBILE: 💙 Customers menu item has been tapped: 🌸 ');
        break;
      case NODES:
        p('🥁 A MOBILE: 💙 Nodes menu item has been tapped: 🌸 ');
        break;
    }
  }
}
