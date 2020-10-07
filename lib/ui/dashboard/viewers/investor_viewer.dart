import 'package:bfn_network_operator_repo/bloc.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/helper.dart';
import 'package:bfnlibrary/data/profile.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            SizedBox(height: 20),
            Text(
              '${list.length}',
              style: widget.numberStyle == null
                  ? Styles.blackBoldLarge
                  : widget.numberStyle,
            ),
            SizedBox(height: 20),
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

  Widget _getTabletDashWidget() {
    return Container(
      width: widget.cardWidth == null ? 200.0 : widget.cardWidth,
      child: Card(
        child: Column(
          children: [
            SizedBox(height: 16),
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
    return ListView.builder(itemBuilder: (context, index) {
      var item = list.elementAt(index);
      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  '${item.account.name}',
                  style: Styles.greyLabelSmall,
                ),
                subtitle: Text('${item.stellarAccountId}'),
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
        label: Text(
      'Discount',
      style: Styles.greyLabelSmall,
    )));

    list.forEach((item) {
      rows.add(DataRow(cells: [
        DataCell(Text(
          item.account.name,
          style: Styles.blackBoldSmall,
        )),
        DataCell(Text(item.maximumInvoiceAmount)),
        DataCell(Text(item.minimumInvoiceAmount)),
        DataCell(Text(item.defaultDiscount)),
      ]));
    });
    DataTable table = DataTable(columns: cols, rows: rows);
    return Column(
      children: [
        Text(
          dashTitle,
          style: Styles.blackBoldMedium,
        ),
        SizedBox(
          height: 20,
        ),
        table,
      ],
    );
  }

  Widget _getDesktopListWidget() {
    return _getTabletListWidget();
  }
}
