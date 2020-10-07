import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class DashboardMenu extends StatelessWidget {
  final MenuListener menuListener;

  const DashboardMenu(this.menuListener);
  @override
  Widget build(BuildContext context) {
    return Drawer(child: MenuItems(menuListener));
  }
}

class MenuItems extends StatelessWidget {
  final MenuListener menuListener;

  const MenuItems(this.menuListener);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 2,
        ),
        Image.asset(
          'assets/logo.png',
          color: Colors.indigo[600],
          width: 36,
          height: 36,
        ),
        ListTile(
          title: Text(
            'DashBoard',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.network_check,
            color: Colors.black,
          ),
          onTap: _handleDashboard,
        ),
        ListTile(
          leading: Icon(
            Icons.people,
            color: Colors.blue,
          ),
          title: Text(
            'Customers',
            style: Styles.blackSmall,
          ),
          onTap: _handleCustomers,
        ),
        ListTile(
          title: Text(
            'Suppliers',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.people_outline,
            color: Colors.indigo,
          ),
          onTap: _handleSuppliers,
        ),
        ListTile(
          title: Text(
            'Investors',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.people_outline,
            color: Colors.indigo,
          ),
          onTap: _handleInvestors,
        ),
        ListTile(
          title: Text(
            'Purchase Orders',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.all_inbox_rounded,
            color: Colors.pink,
          ),
          onTap: _handlePurchaseOrders,
        ),
        ListTile(
          title: Text(
            'Invoices',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.article_sharp,
            color: Colors.teal,
          ),
          onTap: _handleInvoices,
        ),
        ListTile(
          title: Text(
            'Invoice Offers',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.auto_awesome_motion,
            color: Colors.deepPurple,
          ),
          onTap: _handleInvoiceOffers,
        ),
        ListTile(
          title: Text(
            'Supplier Payments',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.monetization_on,
            color: Colors.black,
          ),
          onTap: _handleSupplierPayments,
        ),
        ListTile(
          title: Text(
            'Payment Requests',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.monetization_on,
            color: Colors.grey,
          ),
          onTap: _handlePaymentRequests,
        ),
        ListTile(
          title: Text(
            'Network Nodes',
            style: Styles.blackSmall,
          ),
          leading: Icon(
            Icons.network_wifi,
            color: Colors.amber[900],
          ),
          onTap: _handleNodes,
        ),
      ],
    );
  }

  void _handleNodes() {
    p('😻 Handling Nodes');
    menuListener.onMenuItem(NODES);
  }

  void _handleSuppliers() {
    p('😻 Handling Suppliers');
    menuListener.onMenuItem(SUPPLIERS);
  }

  void _handleInvestors() {
    p('😻 Handling Investors');
    menuListener.onMenuItem(INVESTORS);
  }

  void _handleDashboard() {
    p('😻 Handling Dashboard');
    menuListener.onMenuItem(DASHBOARD);
  }

  void _handlePaymentRequests() {
    p('😻 Handling Payment Requests');
    menuListener.onMenuItem(PAYMENT_REQUESTS);
  }

  void _handleCustomers() {
    p('🥬 Handling Customers');
    menuListener.onMenuItem(CUSTOMERS);
  }

  void _handlePurchaseOrders() {
    p('🍐 Handling Network PurchaseOrders');
    menuListener.onMenuItem(PURCHASE_ORDERS);
  }

  void _handleInvoices() {
    p('💛 Handling Network Invoices');
    menuListener.onMenuItem(INVOICES);
  }

  void _handleInvoiceOffers() {
    p('💙 Handling InvoiceOffers');
    menuListener.onMenuItem(INVOICE_OFFERS);
  }

  void _handleSupplierPayments() {
    p('💙 Handling Supplier Payments');
    menuListener.onMenuItem(SUPPLIER_PAYMENTS);
  }
}

abstract class MenuListener {
  onMenuItem(int action);
}

const DASHBOARD = 1;
const PURCHASE_ORDERS = 2;
const INVOICES = 3;
const INVOICE_OFFERS = 4;
const ACCEPTED_OFFERS = 5;
const CUSTOMERS = 6;
const INVESTORS = 7;
const SUPPLIERS = 8;
const PAYMENT_REQUESTS = 9;
const SUPPLIER_PAYMENTS = 10;
const NODES = 11;
