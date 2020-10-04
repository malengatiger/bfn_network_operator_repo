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
      print("🥦 Firebase.initializeApp() 🥦🥦🥦🥦 completed");
      _pingStellar();
      setState(() {});
    });
  }

  void _pingStellar() async {
    await StellarUtility.ping();
    var isLoggedin = await FireBaseUtil.isUserLoggedIn();
    p('🥝 🥝 Checking Firebase: 🍔 Are we logged in? $isLoggedin');
    if (!isLoggedin) {
      var user = await FireBaseUtil.signIn();
      p('🍎 🍎 🍎 user has been signed in: ${user.hashCode}');
    }
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

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: DashboardMobile(),
      tablet: DashboardTablet(),
      desktop: DashboardDesktop(),
    );
  }
}
