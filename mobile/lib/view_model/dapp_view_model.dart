import 'package:flutter/material.dart';
import 'package:flutter_dapp/utils/contract_utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DappViewModel extends ChangeNotifier {
  DappViewModel() {
    _contractUtils = ContractUtils();
    _contractUtils.initialSetup();
  }
  final myAddress = dotenv.env['METAMASK_RINKEBY_WALLET_ADDRESS'];

  late ContractUtils _contractUtils;
  late String _balance = "100";
  get balance => _balance;

  get contractUtils => _contractUtils;

  double _value = 0.0;
  get value => _value;
  set setValue(val) {
    _value = val;
    notifyListeners();
  }

  getBalance() async {
    _balance = await _contractUtils.getBalance();
    notifyListeners();
  }
}
