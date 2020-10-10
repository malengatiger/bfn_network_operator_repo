import 'dart:ui';

import 'package:bfn_network_operator_repo/bloc.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/helper.dart';
import 'package:bfnlibrary/data/purchase_order.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../grid.dart';
import 'customer_viewer.dart';

class PurchaseOrderViewer extends StatefulWidget {
  final double cardWidth;
  final TextStyle titleStyle, numberStyle;
  final String startDate, endDate;
  final String widgetType;
  final ViewerListener viewerListener;

  const PurchaseOrderViewer(
      {Key key,
      this.cardWidth,
      this.titleStyle,
      this.numberStyle,
      @required this.viewerListener,
      @required this.startDate,
      @required this.endDate,
      @required this.widgetType})
      : super(key: key);
  @override
  _PurchaseOrderViewerState createState() => _PurchaseOrderViewerState();
}

class _PurchaseOrderViewerState extends State<PurchaseOrderViewer>
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
    var startDate =
        DateTime.now().subtract(Duration(days: 90)).toIso8601String();
    var endDate = DateTime.now().toIso8601String();
    if (widget.startDate != null) {
      startDate = widget.startDate;
    }
    if (widget.endDate != null) {
      endDate = widget.endDate;
    }
    list = await dataBloc.getPurchaseOrders(
        startDate: startDate, endDate: endDate);
    if (widget.viewerListener != null) {
      widget.viewerListener.onDataReady(list.length);
    }
  }

  List<PurchaseOrder> list = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PurchaseOrder>>(
        stream: dataBloc.purchaseOrderStream,
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

  var dashTitle = 'Purchase Orders';
  Widget _getMobileDashWidget() {
    return getDashboardSummaryWidget(
        imageColor: Colors.teal, title: dashTitle, number: list.length);
    return Container(
      child: Card(
        child: Column(
          children: [
            SizedBox(height: 16),
            Image.asset(
              'assets/logo.png',
              color: Colors.orange[600],
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
    return getDashboardSummaryWidget(title: dashTitle, number: list.length);
  }

  Widget _getDesktopDashWidget() {
    return getDashboardSummaryWidget(title: dashTitle, number: list.length);
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
          var max = double.parse(item.amount);
          var curr = NumberFormat.currency(symbol: 'R', decimalDigits: 2);
          var formattedMax = curr.format(max);
          var date = DateTime.parse(item.dateRegistered);
          Locale myLocale = Localizations.localeOf(context);
          var formattedDate =
              new DateFormat('EEEE, dd MMMM yyyy', myLocale.toString())
                  .format(date);
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            'Customer',
                            style: Styles.greyTiny,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            '${item.customer.name}',
                            style: Styles.blackTinyBold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            'Supplier',
                            style: Styles.greyTiny,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${item.supplier.name}',
                          style: Styles.blackTiny,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            'Amount',
                            style: Styles.greyTiny,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '$formattedMax',
                          style: Styles.blackBoldSmall,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            'P.O. Number',
                            style: Styles.greyTiny,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${item.purchaseOrderNumber}',
                          style: Styles.blackTiny,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          '$formattedDate',
                          style: Styles.greyTiny,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _getTabletListWidget() {
    List<DataColumn> cols = [];
    List<DataRow> rows = [];
    var orientation = MediaQuery.of(context).orientation;
    _getPeople(cols);
    if (orientation == Orientation.landscape) {
      _getAmount(cols);
      cols.add(DataColumn(
          label: Text(
        'Date',
        style: Styles.greyLabelSmall,
      )));
      list.forEach((item) {
        prettyPrint(item.toJson(), "🔷 🔷 Purchase Order Landscape 🔷 🔷 🔷");
        var date = DateTime.parse(item.dateRegistered);
        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
        String formattedAmount = _getFormattedAmount(item);
        rows.add(DataRow(cells: [
          DataCell(Text(
            item.customer.name,
            style: Styles.blackBoldSmall,
          )),
          DataCell(Text(
            item.supplier.name,
            style: Styles.purpleSmall,
          )),
          // DataCell(Text(item.purchaseOrderNumber)),
          DataCell(Text(
            formattedAmount,
            textScaleFactor: 1.2,
            style: Styles.blackBoldSmall,
          )),
          DataCell(Text(formattedDate)),
        ]));
      });
    } else {
      _getAmount(cols);
      list.forEach((item) {
        //prettyPrint(item.toJson(), "🔷 🔷 Purchase Order : Portrait 🔷 🔷 🔷");
        String formattedAmount = _getFormattedAmount(item);
        rows.add(DataRow(cells: [
          DataCell(
            Text(
              item.customer.name,
              style: Styles.blackBoldSmall,
            ),
          ),
          // DataCell(),
          DataCell(Expanded(
              child: Text(
            item.supplier.name,
            style: Styles.purpleSmall,
          ))),
          // DataCell(Text(formattedDate)),
          DataCell(Text(
            formattedAmount,
            textScaleFactor: 1.2,
            style: Styles.blackBoldSmall,
          )),
        ]));
      });
    }

    DataTable table = DataTable(
      columns: cols,
      rows: rows,
      columnSpacing: 12,
    );
    return ListView(
      children: [
        Column(
          children: [
            Text(
              'Purchase Orders',
              style: Styles.blackBoldMedium,
            ),
            SizedBox(
              height: 20,
            ),
            table,
          ],
        ),
      ],
    );
  }

  String _getFormattedAmount(PurchaseOrder item) {
    double amt = double.parse(item.amount);
    var formattedAmount =
        NumberFormat.currency(symbol: 'R', decimalDigits: 2).format(amt);
    return formattedAmount;
  }

  void _getAmount(List<DataColumn> cols) {
    cols.add(DataColumn(
        label: Text(
      'Amount',
      style: Styles.greyLabelSmall,
    )));
  }

  void _getPeople(List<DataColumn> cols) {
    cols.add(DataColumn(
        label: Text(
      'Customer',
      style: Styles.greyLabelSmall,
    )));
    cols.add(DataColumn(
        label: Text(
      'Supplier',
      style: Styles.greyLabelSmall,
    )));
  }

  Widget _getDesktopListWidget() {
    return _getTabletListWidget();
  }
}
