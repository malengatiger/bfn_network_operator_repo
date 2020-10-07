import 'package:bfn_network_operator_repo/ui/dashboard/dashboard.dart';
import 'package:bfn_network_operator_repo/ui/date_picker/date_picker_mobile.dart';
import 'package:bfn_network_operator_repo/ui/date_picker/date_picker_tablet.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../bloc.dart';
import 'dashboard_menu.dart';
import 'grid.dart';
import 'helper.dart';

class DashboardDesktop extends StatefulWidget {
  @override
  _DashboardDesktopState createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop>
    with SingleTickerProviderStateMixin
    implements GridListener, MenuListener, DateListener {
  AnimationController _controller;
  String startDate, endDate;
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
  onRangeSelected(DateTime sDate, DateTime eDate) {
    p('🍎DashboardMobile: onRangeSelected; 🍎 startDate : $startDate '
        '🍎 endDate: $endDate 🍎 calling  dataBloc.refreshDashboard');
    setState(() {
      startDate = sDate.toIso8601String();
      endDate = eDate.toIso8601String();
    });
    dataBloc.refreshDashboard(startDate: startDate, endDate: endDate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToDateRange() async {
    await Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.topLeft,
            duration: Duration(seconds: 1),
            child: DatePickerTablet(
              dateListener: this,
            )));

    print('🤟🤟🤟🤟🤟🤟🤟🤟 Date returned from date pickin ... ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BFN Network Boss'),
          backgroundColor: Colors.teal.shade200,
          elevation: 0,
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
    if (menuAction == null || menuAction == DASHBOARD) {
      return getDashboardWidget(
          startDate: startDate,
          endDate: endDate,
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2);
    }
    return getContentView(
        menuAction: menuAction, startDate: startDate, endDate: endDate);
  }

  @override
  onGridItemTapped(int index) {
    p('🍯 A DESKTOP dashboard item has been tapped: 🌸 index: $index');
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
