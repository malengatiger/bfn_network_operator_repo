import 'package:bfnlibrary/data/profile.dart';
import 'package:flutter/material.dart';

class DataBloc extends ChangeNotifier {
  List<InvestorProfile> _investorProfiles = [];
  List<InvestorProfile> get investorProfiles => _investorProfiles;

  Future getUsers() async {
    notifyListeners();
  }
}
