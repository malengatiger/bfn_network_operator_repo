import 'package:bfn_network_operator_repo/bloc.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/helper.dart';
import 'package:bfnlibrary/data/invoice_offer.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AcceptedOfferViewer extends StatefulWidget {
  final double cardWidth;
  final TextStyle titleStyle, numberStyle;
  final String startDate, endDate;
  final String widgetType;

  const AcceptedOfferViewer(
      {Key key,
      this.cardWidth,
      this.titleStyle,
      this.numberStyle,
      @required this.startDate,
      @required this.endDate,
      @required this.widgetType})
      : super(key: key);
  @override
  _AcceptedOfferViewerState createState() => _AcceptedOfferViewerState();
}

class _AcceptedOfferViewerState extends State<AcceptedOfferViewer>
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
    dataBloc.getAcceptedInvoiceOffers(startDate: startDate, endDate: endDate);
  }

  List<InvoiceOffer> list = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<InvoiceOffer>>(
        stream: dataBloc.invoiceOfferStream,
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

  var dashTitle = 'Accepted Offers';
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
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Customer',
                  style: Styles.greyLabelSmall,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('${item.customer.name}'),
              ],
            ),
            Row(
              children: [
                Text(
                  'Supplier',
                  style: Styles.greyLabelSmall,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('${item.supplier.name}'),
              ],
            ),
            Row(
              children: [
                Text(
                  'Original Amount',
                  style: Styles.greyLabelSmall,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '${item.originalAmount}',
                  style: Styles.blackBoldSmall,
                ),
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
                Text(
                  '${item.investor.name}',
                  style: Styles.blackBoldSmall,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  'Offer Amount',
                  style: Styles.greyLabelSmall,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('${item.offerAmount.toStringAsFixed(2)}'),
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
      'Investor',
      style: Styles.greyLabelSmall,
    )));
    cols.add(DataColumn(
        label: Text(
      'Original',
      style: Styles.greyLabelSmall,
    )));
    cols.add(DataColumn(
        label: Text(
      'Offer Amount',
      style: Styles.blackBoldSmall,
    )));
    list.forEach((item) {
      rows.add(DataRow(cells: [
        DataCell(Text(item.customer.name)),
        DataCell(Text(item.supplier.name)),
        DataCell(Text(item.investor.name)),
        DataCell(Text(item.originalAmount.toStringAsFixed(2))),
        DataCell(Text(item.offerAmount.toStringAsFixed(2))),
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
