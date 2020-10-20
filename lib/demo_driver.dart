import 'package:bfn_network_operator_repo/ui/dashboard/dashboard.dart';
import 'package:bfnlibrary/api/net_util.dart';
import 'package:bfnlibrary/util/fb_util.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DemoDriver extends StatefulWidget {
  DemoDriver({Key key}) : super(key: key);

  @override
  _DemoDriverState createState() => _DemoDriverState();
}

class _DemoDriverState extends State<DemoDriver> {
  @override
  void initState() {
    super.initState();
  }

  var isBusy = false;
  var isDone = false;
  _startBFNDemoData() async {
    await FireBaseUtil.initialize();
    setState(() {
      isBusy = true;
    });
    p('🔵 🔵 🔵 🔵 🔵 🔵 Starting the BFN Demo Data Driver ......... 🔶🔶🔶');
    var result = await Net.startDemoDriver();
    p("result: 🔶🔶🔶 $result 🔶🔶🔶");
    setState(() {
      isBusy = false;
    });
  }

  var seed = "SBQNKB2JQEEL2BDWZKEKYTSOZLG66FZ5EFAZN7LK22EH5BNA6LCJ7JQR";
  _startAnchorDemoData() async {
    await FireBaseUtil.initialize();
    setState(() {
      isBusy = true;
    });
    p('🔵 🔵 🔵 🔵 🔵 🔵 Starting the Anchor Demo Data Driver ......... 🔶🔶🔶');
    var result = await Net.startDemoDriver(seed: seed);
    p("result: 🔶🔶🔶 $result 🔶🔶🔶");
    setState(() {
      isBusy = false;
      isDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'BFN Test Framework',
          style: Styles.whiteSmall,
        ),
        backgroundColor: Colors.pink[400],
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Demo Data Driver',
                    style: Styles.whiteBoldMedium,
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
            preferredSize: Size.fromHeight(160)),
      ),
      backgroundColor: Colors.brown[100],
      body: isBusy
          ? Center(
              child: Container(
              width: 100,
              height: 100,
              color: Colors.teal[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  strokeWidth: 48,
                  backgroundColor: Colors.teal,
                ),
              ),
            ))
          : Stack(
              children: [
                !isDone
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Card(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Container(
                                  width: double.infinity,
                                  child: RaisedButton(
                                    onPressed: _startAnchorDemoData,
                                    elevation: 8,
                                    color: Colors.indigo,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Anchor Demo Data',
                                          style: Styles.whiteMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Container(
                                  width: double.infinity,
                                  child: RaisedButton(
                                    onPressed: _startBFNDemoData,
                                    elevation: 8,
                                    color: Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'BFN Demo Data',
                                          style: Styles.whiteMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Text(
                                'Work is Done',
                                style: Styles.blackBoldMedium,
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              RaisedButton(
                                  color: Colors.teal,
                                  elevation: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      'Go to Dashboard',
                                      style: Styles.whiteSmall,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.scale,
                                            alignment: Alignment.topLeft,
                                            duration: Duration(seconds: 1),
                                            child: Dashboard()));
                                  })
                            ],
                          ),
                        ),
                      )
              ],
            ),
    ));
  }
}
