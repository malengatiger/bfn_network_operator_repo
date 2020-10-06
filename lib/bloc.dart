import 'package:bfnlibrary/data/node_info.dart';
import 'package:bfnlibrary/data/profile.dart';
import 'package:bfnlibrary/net_util.dart';
import 'package:flutter/material.dart';

final DataBloc dataBloc = DataBloc.instance;

class DataBloc extends ChangeNotifier {
  DataBloc._privateConstructor();

  static final DataBloc instance = DataBloc._privateConstructor();

  List<InvestorProfile> _investorProfiles = [];
  List<InvestorProfile> get investorProfiles => _investorProfiles;

  List<CustomerProfile> _customerProfiles = [];
  List<CustomerProfile> get customerProfiles => _customerProfiles;

  List<SupplierProfile> _supplierProfiles = [];
  List<SupplierProfile> get supplierProfiles => _supplierProfiles;

  List<NodeInfo> _nodes = [];
  List<NodeInfo> get nodes => _nodes;

  Future<List<SupplierProfile>> getSupplierProfiles() async {
    _supplierProfiles = await Net.getSupplierProfiles();
    notifyListeners();
    return _supplierProfiles;
  }

  Future<List<NodeInfo>> getNetworkNodes() async {
    _nodes = await Net.getNetworkNodes();
    notifyListeners();
    return _nodes;
  }

  Future<List<CustomerProfile>> getCustomerProfiles() async {
    _customerProfiles = await Net.getCustomerProfiles();
    notifyListeners();
    return _customerProfiles;
  }

  Future<List<InvestorProfile>> getInvestorProfiles() async {
    _investorProfiles = await Net.getInvestorProfiles();
    notifyListeners();
    return _investorProfiles;
  }
}
