import 'package:bfn_network_operator_repo/bloc.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/dashboard_menu.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/grid.dart';
import 'package:bfn_network_operator_repo/ui/date_picker/date_picker_mobile.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';
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
    _getDates();
  }

  void _getDates() async {
    startDate = await Prefs.getStartDate();
    endDate = await Prefs.getEndDate();
    if (startDate == null) {
      startDate = DateTime.now().subtract(Duration(days: 90)).toIso8601String();
      endDate = DateTime.now().toIso8601String();
      Prefs.setStartDate(startDate);
      Prefs.setEndDate(endDate);
    }
    setState(() {});
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
              backgroundColor: Colors.pink[200],
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
            backgroundColor: Colors.brown[100],
            body: Scaffold(
              drawer: DashboardMenu(this),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
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
              ),
            )));
  }

  Widget _getView() {
    if (menuAction == null || menuAction == DASHBOARD) {
      return getDashboardWidget(
          startDate: startDate,
          endDate: endDate,
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2);
    }
    return getContentView(
        menuAction: menuAction, startDate: startDate, endDate: endDate);
  }

  int menuAction;

  @override
  onGridItemTapped(int index) {
    p('🌸 A MOBILE dashboard item has been tapped: 🌸 index: $index');
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
            child: DatePickerMobile(
              dateListener: this,
            )));
    print('🤟🤟🤟🤟🤟🤟🤟🤟 Date returned from date pickin ... ');
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
