import 'package:bfn_network_operator_repo/bloc.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/helper.dart';
import 'package:bfnlibrary/data/invoice.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../grid.dart';
import 'customer_viewer.dart';

class InvoiceViewer extends StatefulWidget {
  final double cardWidth;
  final TextStyle titleStyle, numberStyle;
  final String startDate, endDate;
  final String widgetType;
  final ViewerListener viewerListener;

  const InvoiceViewer(
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
  _InvoiceViewerState createState() => _InvoiceViewerState();
}

class _InvoiceViewerState extends State<InvoiceViewer>
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
    list = await dataBloc.getInvoices(startDate: startDate, endDate: endDate);
    if (widget.viewerListener != null) {
      widget.viewerListener.onDataReady(list.length);
    }
  }

  List<Invoice> list = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Invoice>>(
        stream: dataBloc.invoiceStream,
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

  var dashTitle = 'Invoices';
  Widget _getMobileDashWidget() {
    return getDashboardSummaryWidget(title: dashTitle, number: list.length);
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
          Locale myLocale = Localizations.localeOf(context);
          var date = DateTime.parse(item.dateRegistered);
          var formattedDate =
              new DateFormat('EEEE, dd MMMM yyyy', myLocale.toString())
                  .format(date);
          var amt = double.parse(item.amount);
          var tax = double.parse(item.valueAddedTax);
          var curr = NumberFormat.currency(symbol: 'R', decimalDigits: 2);
          var formattedAmt = curr.format(amt);
          var formattedTax = curr.format(tax);
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          'Supplier',
                          style: Styles.greyLabelSmall,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${item.supplier.name}',
                        style: Styles.blackBoldSmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          'Customer',
                          style: Styles.greyLabelSmall,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('${item.customer.name}'),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Amount',
                        style: Styles.greyLabelSmall,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '$formattedAmt',
                        style: Styles.blackBoldSmall,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Value Added Tax',
                        style: Styles.greyLabelSmall,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '$tax %',
                        style: Styles.blackBoldSmall,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        '$formattedDate',
                        style: Styles.blackTiny,
                      )
                    ],
                  )
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
      'Customer',
      style: Styles.greyLabelSmall,
    )));
    cols.add(DataColumn(
        label: Text(
      'Supplier',
      style: Styles.greyLabelSmall,
    )));
    cols.add(DataColumn(
        label: Text(
      'Invoice Number',
      style: Styles.greyLabelSmall,
    )));
    cols.add(DataColumn(
        label: Text(
      'Date',
      style: Styles.greyLabelSmall,
    )));
    cols.add(DataColumn(
        label: Text(
      'Amount',
      style: Styles.blackBoldSmall,
    )));
    list.forEach((item) {
      rows.add(DataRow(cells: [
        DataCell(Text(item.customer.name)),
        DataCell(Text(item.supplier.name)),
        DataCell(Text(item.invoiceNumber)),
        DataCell(Text(item.dateRegistered)),
        DataCell(Text(item.amount)),
      ]));
    });
    DataTable table = DataTable(
      columns: cols,
      rows: rows,
      columnSpacing: 1,
    );
    return ListView(
      children: [
        Column(
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
        ),
      ],
    );
  }

  Widget _getDesktopListWidget() {
    return _getTabletListWidget();
  }
}
