import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class DashboardMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: MenuItems());
  }
}

class MenuItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('Network Operator'),
          onTap: _handleNetworkOperator,
        ),
        ListTile(
          title: Text('Customers'),
          onTap: _handleCustomers,
        ),
        ListTile(
          title: Text('Network Members'),
          onTap: _handleNetworkMembers,
        ),
        ListTile(
          title: Text('Purchase Orders'),
          onTap: _handlePurchaseOrders,
        ),
        ListTile(
          title: Text('Invoices'),
          onTap: _handleInvoices,
        ),
        ListTile(
          title: Text('Invoice Offers'),
          onTap: _handleInvoiceOffers,
        ),
      ],
    );
  }

  void _handleNetworkOperator() {
    p('😻 Handling Network Operator');
  }

  void _handleCustomers() {
    p('🥬 Handling Customers');
  }

  void _handleNetworkMembers() {
    p('🍎 Handling Network Members (Users/Accounts)');
  }

  void _handlePurchaseOrders() {
    p('🍐 Handling Network PurchaseOrders');
  }

  void _handleInvoices() {
    p('💛 Handling Network Invoices');
  }

  void _handleInvoiceOffers() {
    p('💙 Handling InvoiceOffers');
  }
}
