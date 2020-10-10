import 'package:bfn_network_operator_repo/bloc.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/grid.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/helper.dart';
import 'package:bfnlibrary/data/profile.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

abstract class ViewerListener {
  onDataReady(int count);
}

class CustomerProfileViewer extends StatefulWidget {
  final double cardWidth;
  final TextStyle titleStyle, numberStyle;
  final String widgetType;
  final ViewerListener viewerListener;

  const CustomerProfileViewer(
      {Key key,
      this.cardWidth,
      this.titleStyle,
      this.numberStyle,
      @required this.viewerListener,
      @required this.widgetType})
      : super(key: key);
  @override
  _CustomerProfileViewerState createState() => _CustomerProfileViewerState();
}

class _CustomerProfileViewerState extends State<CustomerProfileViewer>
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
    list = await dataBloc.getCustomerProfiles();
    if (widget.viewerListener != null) {
      widget.viewerListener.onDataReady(list.length);
    }
  }

  List<CustomerProfile> list = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CustomerProfile>>(
        stream: dataBloc.customerProfileStream,
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

  var dashTitle = 'Customer Profiles';
  Widget _getMobileDashWidget() {
    return getDashboardSummaryWidget(
        imageColor: Colors.indigo, title: dashTitle, number: list.length);
  }

  Widget _getTabletDashWidget() {
    return getDashboardSummaryWidget(title: dashTitle, number: list.length);
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
                    leading: Icon(Icons.people),
                    title: Text(
                      '${item.account.name}',
                      style: Styles.greyLabelSmall,
                    ),
                    subtitle: Text(
                      '$formattedMin - $formattedMax',
                      style: Styles.blackTinyBold,
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

    cols.add(DataColumn(
        label: Text(
      'Customer Name',
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
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      cols.add(DataColumn(
          label: Text(
        'Cellphone',
        style: Styles.greyLabelSmall,
      )));
    }

    if (orientation == Orientation.landscape) {
      list.forEach((item) {
        var max = double.parse(item.maximumInvoiceAmount);
        var min = double.parse(item.minimumInvoiceAmount);
        var curr = NumberFormat.currency(symbol: 'R', decimalDigits: 2);
        var formattedMax = curr.format(max);
        var formattedMin = curr.format(min);
        rows.add(DataRow(cells: [
          DataCell(Text(
            item.account.name,
            style: Styles.blackBoldSmall,
          )),
          DataCell(Text(formattedMax)),
          DataCell(Text(formattedMin)),
          DataCell(Text(item.cellphone)),
        ]));
      });
    } else {
      list.forEach((item) {
        var max = double.parse(item.maximumInvoiceAmount);
        var min = double.parse(item.minimumInvoiceAmount);
        var curr = NumberFormat.currency(symbol: 'R', decimalDigits: 2);
        var formattedMax = curr.format(max);
        var formattedMin = curr.format(min);
        rows.add(DataRow(cells: [
          DataCell(Text(
            item.account.name,
            style: Styles.blackBoldSmall,
          )),
          DataCell(Text(formattedMax)),
          DataCell(Text(formattedMin)),
        ]));
      });
    }
    DataTable table = DataTable(
      columns: cols,
      rows: rows,
      columnSpacing: orientation == Orientation.landscape ? 48 : 24,
    );
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Text(
          dashTitle,
          style: Styles.blackBoldMedium,
        ),
        SizedBox(
          height: 40,
        ),
        table,
      ],
    );
  }

  Widget _getDesktopListWidget() {
    return _getTabletListWidget();
  }
}
