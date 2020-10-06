import 'package:bfn_network_operator_repo/ui/lists/customers/customers.dart';
import 'package:bfn_network_operator_repo/ui/lists/investors/investors.dart';
import 'package:bfn_network_operator_repo/ui/lists/suppliers/suppliers.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

import 'dashboard_menu.dart';
import 'grid.dart';

List<Item> gridItems = [];
List<Item> getDashboardGridItems(
    {TextStyle titleStyle, TextStyle numberStyle}) {
  gridItems.clear();
  gridItems.add(Item(
      title: "Purchase Orders",
      number: "4,690",
      titleStyle: titleStyle,
      numberStyle: numberStyle));
  gridItems.add(Item(
      title: "Invoices",
      number: "13,688",
      titleStyle: titleStyle,
      numberStyle: numberStyle));
  gridItems.add(Item(
      title: "InvoiceOffers",
      number: "3,566",
      titleStyle: titleStyle,
      numberStyle: numberStyle));
  gridItems.add(Item(
      title: "Accepted Offers",
      number: "1,800",
      titleStyle: titleStyle,
      numberStyle: numberStyle));
  gridItems.add(Item(
      title: "Payments",
      number: "14,950",
      titleStyle: titleStyle,
      numberStyle: numberStyle));
  gridItems.add(Item(
      title: "Investors",
      number: "300",
      titleStyle: titleStyle,
      numberStyle: numberStyle));
  gridItems.add(Item(
      title: "Suppliers",
      number: "34,808",
      titleStyle: titleStyle,
      numberStyle: numberStyle));
  gridItems.add(Item(
      title: "Customers",
      number: "27",
      titleStyle: titleStyle,
      numberStyle: numberStyle));
  gridItems.add(Item(
      title: "Network Nodes",
      number: "3",
      titleStyle: titleStyle,
      numberStyle: numberStyle));
  return gridItems;
}

Widget getContentView(int menuAction) {
  switch (menuAction) {
    case CUSTOMERS:
      return CustomerList();
    case INVESTORS:
      return InvestorList();
    case SUPPLIERS:
      return SupplierList();
    case PURCHASE_ORDERS:
      return _getContainer('PURCHASE_ORDERS');
    case INVOICES:
      return _getContainer('INVOICES');
    case INVOICE_OFFERS:
      return _getContainer('INVOICE_OFFERS');
    case SUPPLIER_PAYMENTS:
      return _getContainer('SUPPLIER_PAYMENTS');
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

DashboardGrid getDashboard(
    List<Item> gridItems, GridListener gridListener, int crossAxisCount) {
  return DashboardGrid(
    items: gridItems,
    gridListener: gridListener,
    crossAxisCount: crossAxisCount,
  );
}
