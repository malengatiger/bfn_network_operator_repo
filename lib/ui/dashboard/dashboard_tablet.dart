import 'package:bfn_network_operator_repo/ui/dashboard/helper.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/viewers/customer_viewer.dart';
import 'package:bfn_network_operator_repo/ui/date_picker/date_picker_tablet.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../bloc.dart';
import '../date_picker/date_picker_mobile.dart';
import 'dashboard.dart';
import 'dashboard_drawer.dart';
import 'grid.dart';

class DashboardTablet extends StatefulWidget {
  @override
  _DashboardTabletState createState() => _DashboardTabletState();
}

class _DashboardTabletState extends State<DashboardTablet>
    with SingleTickerProviderStateMixin
    implements GridListener, DateListener, ViewerListener {
  AnimationController _controller;
  String startDate, endDate, mStartDate, mEndDate, mTitle, count = '0';
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
    mStartDate = getFormattedDateShortest(startDate, context);
    mEndDate = getFormattedDateShortest(endDate, context);
    setState(() {});
  }

  @override
  onDataReady(int count) {
    setState(() {
      this.count = '$count';
    });
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
                  height: 8,
                ),
                mTitle == null
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            mTitle,
                            style: Styles.whiteMedium,
                          ),
                          SizedBox(
                            width: 36,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '$count',
                                style: Styles.blackBoldMedium,
                              ),
                              SizedBox(
                                width: 32,
                              ),
                            ],
                          )
                        ],
                      ),
                SizedBox(height: 16),
                getDateRangeRow(mStartDate, mEndDate),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            preferredSize: Size.fromHeight(140)),
      ),
      backgroundColor: Colors.brown[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 220,
              child: _getMenuItems(),
            ),
            Expanded(
              child: _getView(),
            )
          ],
        ),
      ),
    );
  }

  Widget _getMenuItems() {
    return ListView(
      children: [
        SizedBox(
          height: 48,
        ),
        ListTile(
          title: Text(
            'DashBoard',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.network_check,
            color: Colors.black,
          ),
          onTap: _handleDashboard,
        ),
        ListTile(
          leading: Icon(
            Icons.people,
            color: Colors.blue,
          ),
          title: Text(
            'Customers',
            style: Styles.blackSmall,
          ),
          onTap: _handleCustomers,
        ),
        ListTile(
          title: Text(
            'Suppliers',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.people_outline,
            color: Colors.indigo,
          ),
          onTap: _handleSuppliers,
        ),
        ListTile(
          title: Text(
            'Investors',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.people_outline,
            color: Colors.indigo,
          ),
          onTap: _handleInvestors,
        ),
        ListTile(
          title: Text(
            'Purchase Orders',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.all_inbox_rounded,
            color: Colors.pink,
          ),
          onTap: _handlePurchaseOrders,
        ),
        ListTile(
          title: Text(
            'Invoices',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.article_sharp,
            color: Colors.teal,
          ),
          onTap: _handleInvoices,
        ),
        ListTile(
          title: Text(
            'Invoice Offers',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.auto_awesome_motion,
            color: Colors.deepPurple,
          ),
          onTap: _handleInvoiceOffers,
        ),
        ListTile(
          title: Text(
            'Supplier Payments',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.monetization_on,
            color: Colors.black,
          ),
          onTap: _handleSupplierPayments,
        ),
        // ListTile(
        //   title: Text(
        //     'Payment Requests',
        //     style: Styles.blackSmall,
        //   ),
        //   leading: Icon(
        //     Icons.monetization_on,
        //     color: Colors.grey,
        //   ),
        //   onTap: _handlePaymentRequests,
        // ),
        ListTile(
          title: Text(
            'Network Nodes',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.network_wifi,
            color: Colors.amber[900],
          ),
          onTap: _handleNodes,
        ),
      ],
    );
  }

  Widget _getView() {
    if (menuAction == null || menuAction == DASHBOARD) {
      return getDashboardGrid(
          startDate: startDate,
          endDate: endDate,
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2);
    }
    return getContentView(
        menuAction: menuAction,
        startDate: startDate,
        endDate: endDate,
        listener: this);
  }

  int menuAction;

  @override
  onGridItemTapped(int index) {
    p('🥁 A TABLET dashboard item has been tapped: 🌸 index: $index');
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
  onRangeSelected(DateTime sDate, DateTime eDate) async {
    p('🍎DashboardMobile: onRangeSelected; 🍎 startDate : $startDate '
        '🍎 endDate: $endDate 🍎 calling  dataBloc.refreshDashboard');
    setState(() {
      mStartDate = getFormattedDateShortest(sDate.toIso8601String(), context);
      mEndDate = getFormattedDateShortest(eDate.toIso8601String(), context);
    });
    switch (menuAction) {
      case DASHBOARD:
        dataBloc.refreshDashboard(
            startDate: sDate.toIso8601String(),
            endDate: eDate.toIso8601String());
        break;
      case PURCHASE_ORDERS:
        var list = await dataBloc.getPurchaseOrders(
            startDate: sDate.toIso8601String(),
            endDate: eDate.toIso8601String());
        onDataReady(list.length);
        break;
      case INVOICES:
        var list = await dataBloc.getInvoices(
            startDate: sDate.toIso8601String(),
            endDate: eDate.toIso8601String());
        onDataReady(list.length);
        break;
      case INVOICE_OFFERS:
        var list = await dataBloc.getInvoiceOffers(
            startDate: sDate.toIso8601String(),
            endDate: eDate.toIso8601String());
        onDataReady(list.length);
        break;
      case SUPPLIER_PAYMENTS:
        var list = await dataBloc.getSupplierPayments(
            startDate: sDate.toIso8601String(),
            endDate: eDate.toIso8601String());
        onDataReady(list.length);
        break;
      case PAYMENT_REQUESTS:
        // var list = await dataBloc.getPaurchaseOrders(
        //     startDate: startDate.toIso8601String(),
        //     endDate: endDate.toIso8601String());
        // onDataReady(list.length);
        break;
    }
  }

  _handleNodes() {
    p('😻 Handling Nodes');
    setState(() {
      menuAction = NODES;
      mTitle = 'Network Nodes';
    });
  }

  _handleSuppliers() {
    p('😻 Handling Suppliers');
    setState(() {
      menuAction = SUPPLIERS;
      mTitle = 'Suppliers';
    });
  }

  _handleInvestors() {
    p('😻 Handling Investors');
    setState(() {
      menuAction = INVESTORS;
      mTitle = 'Investors';
    });
  }

  _handleDashboard() {
    p('😻 Handling Dashboard');
    setState(() {
      menuAction = DASHBOARD;
      mTitle = 'Dashboard';
    });
  }

  _handleCustomers() {
    p('🥬 Handling Customers .............');
    setState(() {
      menuAction = CUSTOMERS;
      mTitle = 'Customers';
    });
  }

  _handlePurchaseOrders() {
    p('🍐 Handling Network PurchaseOrders');
    setState(() {
      menuAction = PURCHASE_ORDERS;
      mTitle = 'Purchase Orders';
    });
  }

  _handleInvoices() {
    p('💛 Handling Network Invoices');
    setState(() {
      menuAction = INVOICES;
      mTitle = 'Invoices';
    });
  }

  _handleInvoiceOffers() {
    p('💙 Handling InvoiceOffers');
    setState(() {
      menuAction = INVOICE_OFFERS;
      mTitle = 'Invoice Offers';
    });
  }

  _handleSupplierPayments() {
    p('💙 Handling Supplier Payments');
    setState(() {
      menuAction = SUPPLIER_PAYMENTS;
      mTitle = 'Supplier Payments';
    });
  }
}
