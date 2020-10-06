import 'dart:async';

import 'package:bfnlibrary/data/invoice.dart';
import 'package:bfnlibrary/data/invoice_offer.dart';
import 'package:bfnlibrary/data/node_info.dart';
import 'package:bfnlibrary/data/profile.dart';
import 'package:bfnlibrary/data/purchase_order.dart';
import 'package:bfnlibrary/data/supplier_payment.dart';
import 'package:bfnlibrary/net_util.dart';
import 'package:bfnlibrary/util/functions.dart';
import 'package:bfnlibrary/util/prefs.dart';
import 'package:flutter/material.dart';

final DataBloc dataBloc = DataBloc.instance;

class DataBloc extends ChangeNotifier {
  DataBloc._privateConstructor();

  static final DataBloc instance = DataBloc._privateConstructor();

  StreamController<List<InvestorProfile>> _investorProfileStream =
      StreamController.broadcast();
  Stream<List<InvestorProfile>> get investorProfileStream =>
      _investorProfileStream.stream;

  StreamController<List<SupplierProfile>> _supplierProfileStream =
      StreamController.broadcast();
  Stream<List<SupplierProfile>> get supplierProfileStream =>
      _supplierProfileStream.stream;

  StreamController<List<CustomerProfile>> _customerProfileStream =
      StreamController.broadcast();
  Stream<List<CustomerProfile>> get customerProfileStream =>
      _customerProfileStream.stream;

  StreamController<List<Invoice>> _invoiceStream = StreamController.broadcast();
  Stream<List<Invoice>> get invoiceStream => _invoiceStream.stream;

  StreamController<List<InvoiceOffer>> _invoiceOfferStream =
      StreamController.broadcast();
  Stream<List<InvoiceOffer>> get invoiceOfferStream =>
      _invoiceOfferStream.stream;

  StreamController<List<InvoiceOffer>> _acceptedOfferStream =
      StreamController.broadcast();
  Stream<List<InvoiceOffer>> get acceptedOfferStream =>
      _acceptedOfferStream.stream;

  StreamController<List<SupplierPayment>> _supplierPaymentStream =
      StreamController.broadcast();
  Stream<List<SupplierPayment>> get supplierPaymentStream =>
      _supplierPaymentStream.stream;

  StreamController<List<PurchaseOrder>> _purchaseOrderStream =
      StreamController.broadcast();
  Stream<List<PurchaseOrder>> get purchaseOrderStream =>
      _purchaseOrderStream.stream;

  StreamController<List<NodeInfo>> _nodeStream = StreamController.broadcast();
  Stream<List<NodeInfo>> get nodeStream => _nodeStream.stream;

  List<InvestorProfile> _investorProfiles = [];
  List<InvestorProfile> get investorProfiles => _investorProfiles;

  List<CustomerProfile> _customerProfiles = [];
  List<CustomerProfile> get customerProfiles => _customerProfiles;

  List<SupplierProfile> _supplierProfiles = [];
  List<SupplierProfile> get supplierProfiles => _supplierProfiles;

  List<Invoice> _invoices = [];
  List<Invoice> get invoices => _invoices;

  List<InvoiceOffer> _invoiceOffers = [];
  List<InvoiceOffer> get invoiceOffers => _invoiceOffers;

  List<InvoiceOffer> _acceptedOffers = [];
  List<InvoiceOffer> get acceptedOffers => _acceptedOffers;

  List<SupplierPayment> _supplierPayments = [];
  List<SupplierPayment> get supplierPayments => _supplierPayments;

  List<PurchaseOrder> _purchaseOrders = [];
  List<PurchaseOrder> get purchaseOrders => _purchaseOrders;

  List<NodeInfo> _nodes = [];
  List<NodeInfo> get nodes => _nodes;

  Future refreshDashboard({String startDate, String endDate}) async {
    var start = DateTime.now().millisecondsSinceEpoch;
    await getCustomerProfiles();
    await getSupplierProfiles();
    await getInvestorProfiles();
    await getPurchaseOrders(startDate: startDate, endDate: endDate);
    await getInvoices(startDate: startDate, endDate: endDate);
    await getInvoiceOffers(startDate: startDate, endDate: endDate);
    await getAcceptedInvoiceOffers(startDate: startDate, endDate: endDate);
    await getSupplierPayments(startDate: startDate, endDate: endDate);
    var end = DateTime.now().millisecondsSinceEpoch;
    p('🔵  🔵  🔵 refreshDashboard completed: ${(end - start) / 1000} seconds elapsed 🌸');
  }

  Future<List<SupplierProfile>> getSupplierProfiles() async {
    _supplierProfiles = await Net.getSupplierProfiles();
    _supplierProfileStream.sink.add(_supplierProfiles);
    notifyListeners();
    return _supplierProfiles;
  }

  Future<List<PurchaseOrder>> getPurchaseOrders(
      {String startDate, String endDate}) async {
    _purchaseOrders =
        await Net.getPurchaseOrders(startDate: startDate, endDate: endDate);
    _purchaseOrderStream.sink.add(_purchaseOrders);
    notifyListeners();
    return _purchaseOrders;
  }

  Future<List<InvoiceOffer>> getAcceptedInvoiceOffers(
      {String startDate, String endDate}) async {
    _acceptedOffers = await Net.getAcceptedInvoiceOffers(
        startDate: startDate, endDate: endDate);
    _acceptedOfferStream.sink.add(_acceptedOffers);
    notifyListeners();
    return _acceptedOffers;
  }

  Future<List<InvoiceOffer>> getInvoiceOffers(
      {String startDate, String endDate}) async {
    _invoiceOffers =
        await Net.getInvoiceOffers(startDate: startDate, endDate: endDate);
    _invoiceOfferStream.sink.add(_invoiceOffers);
    notifyListeners();
    return _invoiceOffers;
  }

  Future<List<SupplierPayment>> getSupplierPayments(
      {String startDate, String endDate}) async {
    _supplierPayments =
        await Net.getSupplierPayments(startDate: startDate, endDate: endDate);
    _supplierPaymentStream.sink.add(_supplierPayments);
    notifyListeners();
    return _supplierPayments;
  }

  Future<List<Invoice>> getInvoices({String startDate, String endDate}) async {
    _invoices = await Net.getInvoices(startDate: startDate, endDate: endDate);
    _invoiceStream.sink.add(_invoices);
    notifyListeners();
    return _invoices;
  }

  Future<List<NodeInfo>> getNetworkNodes() async {
    _nodes = await Net.getNetworkNodes();
    _nodeStream.sink.add(_nodes);
    notifyListeners();
    p('Saving nodes if found ...........');
    if (nodes.isNotEmpty) {
      await Prefs.saveNodes(nodes);
      nodes.forEach((element) async {
        p("🍎🍎🍎 Node found on Firestore: 🍎🍎🍎 "
            "${prettyPrint(element.toJson(), 'Node JSON')}");
        if (element.addresses.elementAt(0).contains("NetworkAnchorNode")) {
          await Prefs.saveNode(element);
        }
      });
    }
    return _nodes;
  }

  Future<List<CustomerProfile>> getCustomerProfiles() async {
    _customerProfiles = await Net.getCustomerProfiles();
    _customerProfileStream.sink.add(_customerProfiles);
    notifyListeners();
    return _customerProfiles;
  }

  Future<List<InvestorProfile>> getInvestorProfiles() async {
    _investorProfiles = await Net.getInvestorProfiles();
    _investorProfileStream.sink.add(_investorProfiles);
    notifyListeners();
    return _investorProfiles;
  }

  closeStreams() {
    _investorProfileStream.close();
    _supplierProfileStream.close();
    _customerProfileStream.close();
    _invoiceStream.close();
    _invoiceOfferStream.close();
    _supplierPaymentStream.close();
    _nodeStream.close();
    _purchaseOrderStream.close();
    _acceptedOfferStream.close();
  }
}
