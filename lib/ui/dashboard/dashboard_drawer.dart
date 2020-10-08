import 'package:bfnlibrary/util/functions.dart';
import 'package:flutter/material.dart';

class DashboardDrawer extends StatelessWidget {
  final MenuListener menuListener;

  const DashboardDrawer(this.menuListener);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 48,
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
              onTap: _handleDashboard(context),
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
              onTap: _handleCustomers(context),
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
              onTap: _handleSuppliers(context),
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
              onTap: _handleInvestors(context),
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
              onTap: _handlePurchaseOrders(context),
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
              onTap: _handleInvoices(context),
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
              onTap: _handleInvoiceOffers(context),
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
              onTap: _handleSupplierPayments(context),
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
              onTap: _handlePaymentRequests(context),
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
              onTap: _handleNodes(context),
            ),
          ],
        ),
        elevation: 4,
      ),
    );
  }

  _handleNodes(BuildContext context) {
    p('😻 Handling Nodes');

    menuListener.onMenuItem(NODES);
  }

  _handleSuppliers(BuildContext context) {
    p('😻 Handling Suppliers');

    menuListener.onMenuItem(SUPPLIERS);
  }

  _handleInvestors(BuildContext context) {
    p('😻 Handling Investors');

    menuListener.onMenuItem(INVESTORS);
  }

  _handleDashboard(BuildContext context) {
    p('😻 Handling Dashboard');

    menuListener.onMenuItem(DASHBOARD);
  }

  _handlePaymentRequests(BuildContext context) {
    p('😻 Handling Payment Requests');

    menuListener.onMenuItem(PAYMENT_REQUESTS);
  }

  _handleCustomers(BuildContext context) {
    p('🥬 Handling Customers');
    Navigator.pop(context);
    menuListener.onMenuItem(CUSTOMERS);
  }

  _handlePurchaseOrders(BuildContext context) {
    p('🍐 Handling Network PurchaseOrders');
    Navigator.pop(context);
    menuListener.onMenuItem(PURCHASE_ORDERS);
  }

  _handleInvoices(BuildContext context) {
    p('💛 Handling Network Invoices');
    Navigator.pop(context);
    menuListener.onMenuItem(INVOICES);
  }

  _handleInvoiceOffers(BuildContext context) {
    p('💙 Handling InvoiceOffers');
    Navigator.pop(context);
    menuListener.onMenuItem(INVOICE_OFFERS);
  }

  _handleSupplierPayments(BuildContext context) {
    p('💙 Handling Supplier Payments');
    Navigator.pop(context);
    menuListener.onMenuItem(SUPPLIER_PAYMENTS);
  }
}

class MenuItems extends StatefulWidget {
  final MenuListener menuListener;
  const MenuItems(this.menuListener);

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 48,
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
          onTap: _handleDashboard(context),
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
          onTap: _handleCustomers(context),
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
          onTap: _handleSuppliers(context),
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
          onTap: _handleInvestors(context),
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
          onTap: _handlePurchaseOrders(context),
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
          onTap: _handleInvoices(context),
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
          onTap: _handleInvoiceOffers(context),
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
          onTap: _handleSupplierPayments(context),
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
          onTap: _handlePaymentRequests(context),
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
          onTap: _handleNodes(context),
        ),
      ],
    );
  }

  _handleNodes(BuildContext context) {
    p('😻 Handling Nodes');

    widget.menuListener.onMenuItem(NODES);
  }

  _handleSuppliers(BuildContext context) {
    p('😻 Handling Suppliers');

    widget.menuListener.onMenuItem(SUPPLIERS);
  }

  _handleInvestors(BuildContext context) {
    p('😻 Handling Investors');

    widget.menuListener.onMenuItem(INVESTORS);
  }

  _handleDashboard(BuildContext context) {
    p('😻 Handling Dashboard');

    widget.menuListener.onMenuItem(DASHBOARD);
  }

  _handlePaymentRequests(BuildContext context) {
    p('😻 Handling Payment Requests');

    widget.menuListener.onMenuItem(PAYMENT_REQUESTS);
  }

  _handleCustomers(BuildContext context) {
    p('🥬 Handling Customers');

    widget.menuListener.onMenuItem(CUSTOMERS);
  }

  _handlePurchaseOrders(BuildContext context) {
    p('🍐 Handling Network PurchaseOrders');
    widget.menuListener.onMenuItem(PURCHASE_ORDERS);
  }

  _handleInvoices(BuildContext context) {
    p('💛 Handling Network Invoices');
    widget.menuListener.onMenuItem(INVOICES);
  }

  _handleInvoiceOffers(BuildContext context) {
    p('💙 Handling InvoiceOffers');
    widget.menuListener.onMenuItem(INVOICE_OFFERS);
  }

  _handleSupplierPayments(BuildContext context) {
    p('💙 Handling Supplier Payments');
    widget.menuListener.onMenuItem(SUPPLIER_PAYMENTS);
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
