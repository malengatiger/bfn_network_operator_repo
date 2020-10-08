import 'package:bfn_network_operator_repo/ui/dashboard/helper.dart';
import 'package:bfn_network_operator_repo/ui/date_picker/date_picker_tablet.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../bloc.dart';
import '../date_picker/date_picker_mobile.dart';
import 'dashboard.dart';
import 'dashboard_menu.dart';
import 'grid.dart';

class DashboardTablet extends StatefulWidget {
  @override
  _DashboardTabletState createState() => _DashboardTabletState();
}

class _DashboardTabletState extends State<DashboardTablet>
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
                  height: 24,
                )
              ],
            ),
            preferredSize: Size.fromHeight(100)),
      ),
      backgroundColor: Colors.brown[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
        ),
      ),
    );
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

  int menuAction;

  @override
  onGridItemTapped(int index) {
    p('🥁 A TABLET dashboard item has been tapped: 🌸 index: $index');
  }

  @override
  onMenuItem(int action) {
    setState(() {
      menuAction = action;
    });
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
  onRangeSelected(DateTime sDate, DateTime eDate) {
    p('🍎DashboardMobile: onRangeSelected; 🍎 startDate : $startDate '
        '🍎 endDate: $endDate 🍎 calling  dataBloc.refreshDashboard');
    setState(() {
      startDate = sDate.toIso8601String();
      endDate = eDate.toIso8601String();
    });
    dataBloc.refreshDashboard(startDate: startDate, endDate: endDate);
  }
}
