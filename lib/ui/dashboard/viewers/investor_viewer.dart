import 'package:bfn_network_operator_repo/bloc.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/helper.dart';
import 'package:bfnlibrary/data/profile.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class InvestorProfileViewer extends StatefulWidget {
  final double cardWidth;
  final TextStyle titleStyle, numberStyle;
  final String widgetType;

  const InvestorProfileViewer(
      {Key key,
      this.cardWidth,
      this.titleStyle,
      this.numberStyle,
      @required this.widgetType})
      : super(key: key);
  @override
  _InvestorProfileViewerState createState() => _InvestorProfileViewerState();
}

class _InvestorProfileViewerState extends State<InvestorProfileViewer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String mWidgetType;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    mWidgetType = widget.widgetType;
    _refresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _refresh() async {
    dataBloc.getInvestorProfiles();
  }

  List<InvestorProfile> list = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<InvestorProfile>>(
        stream: dataBloc.investorProfileStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            p('🔵 🔵 🔵 stream delivering data to widget: '
                '${snapshot.data.length} items 🔵');
            list = snapshot.data;
          }
          if (mWidgetType == DASHBOARD_WIDGET) {
            return _getDashWidget();
          } else {
            return _getListWidget();
          }
        });
  }

  // 🥏 🥏 🥏 Responsive Dashboard widgets
  Widget _getDashWidget() {
    return ScreenTypeLayout(
      mobile: _getMobileDashWidget(),
      tablet: _getTabletDashWidget(),
      desktop: _getDesktopDashWidget(),
    );
  }

  var dashTitle = 'Investor Profiles';
  Widget _getMobileDashWidget() {
    return Container(
      width: widget.cardWidth == null ? 220.0 : widget.cardWidth,
      child: Card(
        child: Column(
          children: [
            SizedBox(height: 16),
            Image.asset(
              'assets/logo.png',
              color: Colors.indigo[600],
              width: 36,
              height: 36,
            ),
            Text(
              '${list.length}',
              style: widget.numberStyle == null
                  ? Styles.blackBoldMedium
                  : widget.numberStyle,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(dashTitle,
                  style: widget.titleStyle == null
                      ? Styles.blackTiny
                      : widget.titleStyle),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTabletDashWidget() {
    return Container(
      width: widget.cardWidth == null ? 200.0 : widget.cardWidth,
      child: Card(
        child: Column(
          children: [
            SizedBox(height: 48),
            Image.asset(
              'assets/logo.png',
              color: Colors.indigo[600],
              width: 48,
              height: 48,
            ),
            Text(
              '${list.length}',
              style: widget.numberStyle == null
                  ? Styles.blackBoldLarge
                  : widget.numberStyle,
            ),
            SizedBox(height: 16),
            Center(
              child: Text(dashTitle,
                  style: widget.titleStyle == null
                      ? Styles.blackSmall
                      : widget.titleStyle),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getDesktopDashWidget() {
    return _getTabletDashWidget();
  }

  // 🥏 🥏 🥏 Responsive List widgets
  Widget _getListWidget() {
    //todo -  🌰  🌰  🌰 are we mobile or desktop/tablet?????  return dataTable or ListView 🌰
    return ScreenTypeLayout(
      mobile: _getMobileListWidget(),
      tablet: _getTabletListWidget(),
      desktop: _getDesktopListWidget(),
    );
  }

  Widget _getMobileListWidget() {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          var item = list.elementAt(index);
          var max = double.parse(item.maximumInvoiceAmount);
          var min = double.parse(item.minimumInvoiceAmount);
          var curr = NumberFormat.currency(symbol: 'R', decimalDigits: 2);
          var formattedMax = curr.format(max);
          var formattedMin = curr.format(min);
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.stream),
                    title: Text(
                      '${item.account.name}',
                      style: Styles.greyLabelSmall,
                    ),
                    subtitle: Column(
                      children: [
                        Text(
                          '$formattedMin - $formattedMax',
                          style: Styles.blackTinyBold,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Default Discount:',
                              style: Styles.greyTiny,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '${item.defaultDiscount} %',
                              style: Styles.pinkBoldSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _getTabletListWidget() {
    List<DataColumn> cols = [];
    List<DataRow> rows = [];
    var orientation = MediaQuery.of(context).orientation;

    cols.add(DataColumn(
        label: Text(
      'Name',
      style: Styles.greyLabelSmall,
    )));

    cols.add(DataColumn(
        label: Text(
      'Maximum',
      style: Styles.greyLabelSmall,
    )));
    cols.add(DataColumn(
        label: Text(
      'Minimum',
      style: Styles.greyLabelSmall,
    )));
    cols.add(DataColumn(
        label: Expanded(
      child: Text(
        'Default\nDiscount',
        style: Styles.greyLabelSmall,
      ),
    )));
    if (orientation == Orientation.landscape) {
      cols.add(DataColumn(
          label: Expanded(
        child: Text(
          'Trade\nMatrix',
          style: Styles.greyLabelSmall,
        ),
      )));
    }

    list.forEach((item) {
      var max = double.parse(item.maximumInvoiceAmount);
      var min = double.parse(item.minimumInvoiceAmount);
      var curr = NumberFormat.currency(symbol: 'R', decimalDigits: 2);
      var formattedMax = curr.format(max);
      var formattedMin = curr.format(min);
      var landscapeRow = DataRow(cells: [
        DataCell(Text(
          item.account.name,
          style: Styles.blackBoldSmall,
        )),
        DataCell(Text(formattedMax)),
        DataCell(Text(formattedMin)),
        DataCell(Text(
          '${item.defaultDiscount} %',
          style: Styles.purpleSmall,
        )),
        DataCell(Text(
          '${item.tradeMatrixItems.length}',
          style: Styles.blackSmall,
        )),
      ]);
      var portraitRow = DataRow(cells: [
        DataCell(Text(
          item.account.name,
          style: Styles.blackBoldSmall,
        )),
        DataCell(Text(formattedMax)),
        DataCell(Text(formattedMin)),
        DataCell(Text(
          '${item.defaultDiscount} %',
          style: Styles.purpleSmall,
        )),
      ]);
      if (orientation == Orientation.landscape) {
        rows.add(landscapeRow);
      } else {
        rows.add(portraitRow);
      }
    });
    DataTable table = DataTable(
      columns: cols,
      rows: rows,
      columnSpacing: orientation == Orientation.landscape ? 60 : 8,
    );
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Text(
              dashTitle,
              style: Styles.blackBoldMedium,
            ),
            SizedBox(
              height: 24,
            ),
            table,
          ],
        ),
      ],
    );
  }

  Widget _getDesktopListWidget() {
    return _getTabletListWidget();
  }

  void _selectedChange(bool value) {}
}
