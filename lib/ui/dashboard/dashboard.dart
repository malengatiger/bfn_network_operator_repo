import 'package:bfn_network_operator_repo/bloc.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/dashboard_desktop.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/dashboard_mobile.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/dashboard_tablet.dart';
import 'package:bfnlibrary/util/fb_util.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/stellar_lib.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("🥦🥦🥦🥦🥦 Firebase.initializeApp() 🥦🥦🥦🥦 completed");
      _checkUser();
      _pingStellar();
    });
  }

  void _pingStellar() async {
    await StellarUtility.ping();

    var resp = await StellarUtility.getAccountResponse(
        'GAVR7MVYQ4DQXK6TUXMAWH7VSC3BQVROXOG6IQ7EHU65F2ANJ65O2YUM');
    p(' 🥦 🥦 _DashboardState: Stellar has responded with an account response: '
        ' 🍊 balance :${resp.balances[0].balance} XLM  🍊');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkUser() async {
    var isLoggedin = await FireBaseUtil.isUserLoggedIn();
    p('🥝 🥝 ......... Checking authenticated User ....: '
        '🍔 Are we logged in? $isLoggedin');
    if (!isLoggedin) {
      var user = await FireBaseUtil.signInAdminUser();
      p('🍎 🍎 🍎 user has been signed in: '
          '${user.displayName} ${user.email}');
    }
    _getData();
    var testUser = const String.fromEnvironment("user");
    var son = const String.fromEnvironment("son");
    p('Property user from environment: 🔵  🔵  🔵 $testUser son: $son');
    var isLoggedIn = await FireBaseUtil.isUserLoggedIn();
    p("🍊 🍊 🍊 The user is loggedIn:  🥦 $isLoggedIn  🥦");
    await dataBloc.getNetworkNodes();
  }

  void _getData() {
    var now = DateTime.now();
    var then = now.subtract(Duration(days: 35));
    dataBloc.refreshDashboard(
        startDate: then.toIso8601String(), endDate: now.toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: DashboardMobile(),
      tablet: DashboardTablet(),
      desktop: DashboardDesktop(),
    );
  }
}

class NameView extends StatelessWidget {
  final String imageName, title;
  final double imageSize;
  final TextStyle titleStyle;
  final double paddingLeft;

  const NameView(
      {Key key,
      this.imageName,
      this.title,
      @required this.imageSize,
      this.titleStyle,
      this.paddingLeft})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: paddingLeft == null ? 60 : paddingLeft,
        ),
        Image.asset(
          imageName == null ? 'assets/logo.png' : imageName,
          width: imageSize,
          height: imageSize,
          color: Colors.white,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          title == null ? 'Business Finance Network Ltd' : title,
          style: titleStyle == null ? Styles.whiteBoldSmall : titleStyle,
        )
      ],
    );
  }
}

class DateRange extends StatefulWidget {
  @override
  _DateRangeState createState() => _DateRangeState();
}

class _DateRangeState extends State<DateRange> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          InkWell(
            child: Text('Start Date'),
            onTap: _openStartCalendar,
          ),
          SizedBox(
            width: 80,
          ),
          InkWell(
            child: Text('End Date'),
            onTap: _openEndCalendar,
          ),
          SizedBox(
            width: 80,
          ),
          FlatButton(
            child: Text('Refresh'),
            onPressed: _refreshData,
          ),
        ],
      ),
    );
  }

  void _openStartCalendar() {
    showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: null,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    );
  }

  void _openEndCalendar() {}

  void _refreshData() {}
}
