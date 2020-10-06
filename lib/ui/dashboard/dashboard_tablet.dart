import 'package:bfn_network_operator_repo/ui/dashboard/helper.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'dashboard_menu.dart';
import 'grid.dart';

class DashboardTablet extends StatefulWidget {
  @override
  _DashboardTabletState createState() => _DashboardTabletState();
}

class _DashboardTabletState extends State<DashboardTablet>
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
      // drawer: DashboardMenu(this),
      appBar: AppBar(
        title: Text(
          'BFN Network Operator',
          style: Styles.whiteSmall,
        ),
        backgroundColor: Colors.pink.shade200,
        elevation: 0,
        bottom: PreferredSize(
            child: Column(
              children: [
                NameView(
                  paddingLeft: 100,
                  imageSize: 48.0,
                  titleStyle: Styles.whiteBoldMedium,
                ),
                SizedBox(
                  height: 24,
                )
              ],
            ),
            preferredSize: Size.fromHeight(100)),
      ),
      backgroundColor: Colors.brown[50],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
        ),
      ),
    );
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

  int menuAction;
  List<Item> gridItems = [];
  void getItems() {
    gridItems.add(Item(title: "Purchase Orders", number: "4,690"));
    gridItems.add(Item(title: "Customers", number: "300"));
    gridItems.add(Item(title: "Suppliers", number: "300"));
    gridItems.add(Item(title: "Investors", number: "300"));
    gridItems.add(Item(title: "Invoices", number: "13,688"));
    gridItems.add(Item(title: "InvoiceOffers", number: "3,566"));
    gridItems.add(Item(title: "Accepted Offers", number: "1,800"));
    gridItems.add(Item(title: "Payments", number: "14,950"));
    gridItems.add(Item(title: "Live Nodes", number: "3"));
    setState(() {});
  }

  @override
  onGridItemTapped(Item item) {
    p('🥁 A TABLET dashboard item has been tapped: 🌸 ${item.title} ${item.number}');
  }

  @override
  onMenuItem(int action) {
    setState(() {
      menuAction = action;
    });
  }
}
