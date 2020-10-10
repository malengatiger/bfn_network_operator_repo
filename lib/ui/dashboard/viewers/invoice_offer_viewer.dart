import 'package:bfn_network_operator_repo/bloc.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/helper.dart';
import 'package:bfnlibrary/data/invoice_offer.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../grid.dart';
import 'customer_viewer.dart';

class InvoiceOfferViewer extends StatefulWidget {
  final double cardWidth;
  final TextStyle titleStyle, numberStyle;
  final String startDate, endDate;
  final String widgetType;
  final ViewerListener viewerListener;

  const InvoiceOfferViewer(
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
  _InvoiceOfferViewerState createState() => _InvoiceOfferViewerState();
}

class _InvoiceOfferViewerState extends State<InvoiceOfferViewer>
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
    list =
        await dataBloc.getInvoiceOffers(startDate: startDate, endDate: endDate);
    if (widget.viewerListener != null) {
      widget.viewerListener.onDataReady(list.length);
    }
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

  var dashTitle = 'InvoiceOffers';
  Widget _getMobileDashWidget() {
    return getDashboardSummaryWidget(
        imageColor: Colors.amber[700], title: dashTitle, number: list.length);
  }

  Widget _getTabletDashWidget() {
    return getDashboardSummaryWidget(title: dashTitle, number: list.length);
  }

  Widget _getDesktopDashWidget() {
    return _getTabletDashWidget();
  }

  // 🥏 🥏 🥏 Responsive List widgets
  Widget _getListWidget() {
    p(' 🌰  🌰  🌰 are we mobile or desktop/tablet?????  return dataTable or ListView 🌰');
    var mLayout = ScreenTypeLayout(
      mobile: _getMobileListWidget(),
      tablet: Container(),
      desktop: Container(),
    );
    p('_getListWidget ending ...................... 🎁🎁🎁🎁🎁 '
        'returning ScreenTypeLayout ${mLayout.toString()}');
    return mLayout;
  }

  Widget _getMobileListWidget() {
    p('_getMobileListWidget starting ...................... 🥬🥬🥬🥬🥬🥬');

    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          var item = list.elementAt(index);
          var offerAmount, originalAmount;
          if (item.offerAmount != null) {
            offerAmount = getCurrency(item.offerAmount);
          }
          if (item.originalAmount != null) {
            originalAmount = getCurrency(item.originalAmount);
          }

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
                          'Customer',
                          style: Styles.greyLabelSmall,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('${item.investor.name}'),
                    ],
                  ),
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
                      Text('${item.supplier.name}'),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  originalAmount == null
                      ? Container()
                      : Row(
                          children: [
                            Text(
                              'Original Amount',
                              style: Styles.greyLabelSmall,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '$originalAmount',
                              style: Styles.blackBoldSmall,
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          'Investor',
                          style: Styles.greyLabelSmall,
                        ),
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
                    height: 20,
                  ),
                  offerAmount == null
                      ? Container()
                      : Row(
                          children: [
                            Text(
                              'Offer Amount',
                              style: Styles.greyLabelSmall,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('$offerAmount'),
                          ],
                        ),
                ],
              ),
            ),
          );
        });
  }

  // Widget _getTabletListWidget() {
  //   p('_getTabletListWidget starting ...................... 🔵🔵🔵🔵🔵🔵 '
  //       'why is this method called? 🔵 who calls it? 🔵');
  //   List<DataColumn> cols = [];
  //   List<DataRow> rows = [];
  //   DataTable table = DataTable(columns: cols, rows: rows);
  //   cols.add(DataColumn(
  //       label: Text(
  //     'Customer',
  //     style: Styles.greyLabelSmall,
  //   )));
  //   cols.add(DataColumn(
  //       label: Text(
  //     'Supplier',
  //     style: Styles.greyLabelSmall,
  //   )));
  //   cols.add(DataColumn(
  //       label: Text(
  //     'Investor',
  //     style: Styles.greyLabelSmall,
  //   )));
  //   cols.add(DataColumn(
  //       label: Text(
  //     'Original',
  //     style: Styles.greyLabelSmall,
  //   )));
  //   cols.add(DataColumn(
  //       label: Text(
  //     'Offer Amount',
  //     style: Styles.blackBoldSmall,
  //   )));
  //   list.forEach((item) {
  //     rows.add(DataRow(cells: [
  //       DataCell(Text(item.customer.name)),
  //       DataCell(Text(item.supplier.name)),
  //       DataCell(Text(item.investor.name)),
  //       DataCell(Text(item.originalAmount.toStringAsFixed(2))),
  //       DataCell(Text(item.offerAmount.toStringAsFixed(2))),
  //     ]));
  //   });
  //
  //   return Column(
  //     children: [
  //       Text(
  //         dashTitle,
  //         style: Styles.blackBoldMedium,
  //       ),
  //       SizedBox(
  //         height: 20,
  //       ),
  //       table,
  //     ],
  //   );
  // }
  //
  // Widget _getDesktopListWidget() {
  //   p('_getDesktopListWidget starting ...................... 🍊🍊🍊🍊🍊');
  //   return _getTabletListWidget();
  // }
}
