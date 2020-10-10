import 'package:bfn_network_operator_repo/ui/dashboard/viewers/accepted_offer_viewer.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/viewers/customer_viewer.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/viewers/investor_viewer.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/viewers/invoice_offer_viewer.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/viewers/invoice_viewer.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/viewers/purchase_order_viewer.dart';
import 'package:bfn_network_operator_repo/ui/dashboard/viewers/supplier_payments_viewer.dart';
import 'package:bfn_network_operator_repo/ui/lists/suppliers/suppliers.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

import 'dashboard_drawer.dart';
import 'grid.dart';

const String DASHBOARD_WIDGET = 'dashboardWidget', LIST_WIDGET = 'listWidget';

Widget getDashboardGrid(
    {@required int crossAxisCount,
    @required double crossAxisSpacing,
    @required double mainAxisSpacing,
    String startDate,
    String endDate,
    GridListener gridListener,
    ViewerListener viewerListener}) {
  var list = List<Widget>();
  list.add(CustomerProfileViewer(
    widgetType: DASHBOARD_WIDGET,
    viewerListener: viewerListener,
  ));
  list.add(InvestorProfileViewer(
    widgetType: DASHBOARD_WIDGET,
    viewerListener: viewerListener,
  ));
  list.add(PurchaseOrderViewer(
    startDate: startDate,
    endDate: endDate,
    widgetType: DASHBOARD_WIDGET,
    viewerListener: viewerListener,
  ));
  list.add(InvoiceViewer(
    startDate: startDate,
    endDate: endDate,
    widgetType: DASHBOARD_WIDGET,
    viewerListener: viewerListener,
  ));
  list.add(InvoiceOfferViewer(
    startDate: startDate,
    endDate: endDate,
    widgetType: DASHBOARD_WIDGET,
    viewerListener: viewerListener,
  ));
  list.add(AcceptedOfferViewer(
    startDate: startDate,
    endDate: endDate,
    widgetType: DASHBOARD_WIDGET,
    viewerListener: viewerListener,
  ));
  list.add(SupplierPaymentViewer(
    startDate: startDate,
    endDate: endDate,
    widgetType: DASHBOARD_WIDGET,
    viewerListener: viewerListener,
  ));

  return DashboardGrid(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      widgets: list,
      gridListener: gridListener);
}

Widget getContentView(
    {@required int menuAction,
    @required String startDate,
    @required String endDate,
    @required ViewerListener listener}) {
  switch (menuAction) {
    case CUSTOMERS:
      return CustomerProfileViewer(
        widgetType: LIST_WIDGET,
        viewerListener: listener,
      );
    case INVESTORS:
      return InvestorProfileViewer(
        widgetType: LIST_WIDGET,
        viewerListener: listener,
      );
    case SUPPLIERS:
      return SupplierList();
    case PURCHASE_ORDERS:
      return PurchaseOrderViewer(
        startDate: startDate,
        endDate: endDate,
        widgetType: LIST_WIDGET,
        viewerListener: listener,
      );
    case INVOICES:
      return InvoiceViewer(
        startDate: startDate,
        endDate: endDate,
        widgetType: LIST_WIDGET,
        viewerListener: listener,
      );
    case INVOICE_OFFERS:
      return InvoiceOfferViewer(
        startDate: startDate,
        endDate: endDate,
        widgetType: LIST_WIDGET,
        viewerListener: listener,
      );
    case SUPPLIER_PAYMENTS:
      return SupplierPaymentViewer(
        startDate: startDate,
        endDate: endDate,
        widgetType: LIST_WIDGET,
        viewerListener: listener,
      );
    case PAYMENT_REQUESTS:
      return _getContainer('Missing PAYMENT_REQUESTS');
    case NODES:
      return _getContainer('Missing NODES');
  }

  return _getContainer("Unknown Shit");
}

Widget _getContainer(String text) {
  return Container(
      child: Center(
        child: Text(
          text,
          style: Styles.pinkBoldLarge,
        ),
      ),
      color: Colors.amber[200]);
}
