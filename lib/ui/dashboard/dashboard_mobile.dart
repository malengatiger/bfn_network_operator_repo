import 'package:bfn_network_operator_repo/bloc.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/dashboard_menu.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/grid.dart';
import 'package:bfn_network_operator_repo/ui/my_date_picker.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'dashboard.dart';
import 'helper.dart';

class DashboardMobile extends StatefulWidget {
  @override
  _DashboardMobileState createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile>
    with SingleTickerProviderStateMixin
    implements GridListener, MenuListener, DateListener {
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

  String startDate, endDate;
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
                    onPressed: () {
                      dataBloc.refreshDashboard(
                          startDate: startDate, endDate: endDate);
                    }),
                IconButton(
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                    ),
                    onPressed: _navigateToDateRange),
              ],
              backgroundColor: Colors.pink[300],
              bottom: PreferredSize(
                  child: Column(
                    children: [
                      NameView(
                        paddingLeft: 20,
                        imageSize: 32.0,
                        titleStyle: Styles.whiteSmall,
                      ),
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
                  // Positioned(
                  //   bottom: 50,
                  //   right: 50,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Card(
                  //         color: Colors.teal[200],
                  //         child: SfDateRangePicker(
                  //           minDate:
                  //               DateTime.now().subtract(Duration(days: 90)),
                  //           maxDate: DateTime.now(),
                  //         )),
                  //   ),
                  // )
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
    gridItems = getDashboardGridItems(
        titleStyle: Styles.blackSmall, numberStyle: Styles.blueBoldLarge);
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

  void _navigateToDateRange() async {
    await Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.topLeft,
            duration: Duration(seconds: 1),
            child: MyDatePicker(
              dateListener: this,
            )));
    print('🤟🤟🤟🤟🤟🤟🤟🤟 User returned from date pickin ... ');
  }

  @override
  onRangeSelected(DateTime startDate, DateTime endDate) {
    p('🍎DashboardMobile: onRangeSelected; 🍎 startDate : $startDate '
        '🍎 endDate: $endDate 🍎 calling  dataBloc.refreshDashboard');
    dataBloc.refreshDashboard(
        startDate: startDate.toIso8601String(),
        endDate: endDate.toIso8601String());
  }
}
