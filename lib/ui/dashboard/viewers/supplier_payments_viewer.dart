import 'package:bfn_network_operator_repo/bloc.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/helper.dart';
import 'package:bfnlibrary/data/supplier_payment.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../grid.dart';
import 'customer_viewer.dart';

class SupplierPaymentViewer extends StatefulWidget {
  final double cardWidth;
  final TextStyle titleStyle, numberStyle;
  final String startDate, endDate;
  final String widgetType;
  final ViewerListener viewerListener;

  const SupplierPaymentViewer(
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
  _SupplierPaymentViewerState createState() => _SupplierPaymentViewerState();
}

class _SupplierPaymentViewerState extends State<SupplierPaymentViewer>
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
    list = await dataBloc.getSupplierPayments(
        startDate: startDate, endDate: endDate);
    if (widget.viewerListener != null) {
      widget.viewerListener.onDataReady(list.length);
    }
  }

  List<SupplierPayment> list = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SupplierPayment>>(
        stream: dataBloc.supplierPaymentStream,
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

  var dashTitle = 'SupplierPayments';
  Widget _getMobileDashWidget() {
    return getDashboardSummaryWidget(title: dashTitle, number: list.length);
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
    return getDashboardSummaryWidget(title: dashTitle, number: list.length);
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
    return ListView.builder(itemBuilder: (context, index) {
      var item = list.elementAt(index);
      var offerAmount, originalAmount;
      if (item.acceptedOffer.offerAmount != null) {
        offerAmount = getCurrency(item.acceptedOffer.offerAmount);
      }
      if (item.acceptedOffer.originalAmount != null) {
        originalAmount = getCurrency(item.acceptedOffer.originalAmount);
      }
      return Card(
        elevation: 2,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Supplier',
                  style: Styles.greyLabelSmall,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('${item.acceptedOffer.supplier.name}'),
              ],
            ),
            Row(
              children: [
                Text(
                  'Investor',
                  style: Styles.greyLabelSmall,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('${item.acceptedOffer.investor.name}'),
              ],
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
                  '$offerAmount}',
                  style: Styles.blackBoldSmall,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('${item.dateRegistered}')
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _getTabletListWidget() {
    List<DataColumn> cols = [];
    List<DataRow> rows = [];
    DataTable table = DataTable(columns: cols, rows: rows);
    cols.add(DataColumn(
        label: Text(
      'Investor',
      style: Styles.greyLabelSmall,
    )));
    // cols.add(DataColumn(
    //     label: Text(
    //   'Customer',
    //   style: Styles.greyLabelSmall,
    // )));
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
      var offerAmount, originalAmount;
      if (item.acceptedOffer.offerAmount != null) {
        offerAmount = getCurrency(item.acceptedOffer.offerAmount);
      }
      if (item.acceptedOffer.originalAmount != null) {
        originalAmount = getCurrency(item.acceptedOffer.originalAmount);
      }
      rows.add(DataRow(cells: [
        DataCell(Text(item.acceptedOffer.investor.name)),
        // DataCell(Text(item.acceptedOffer.customer.name)),
        DataCell(Text(item.acceptedOffer.supplier.name)),
        DataCell(Text(item.acceptedOffer.invoiceId)),
        DataCell(Text(item.acceptedOffer.offerDate)),
        DataCell(Text(offerAmount)),
      ]));
    });

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
