import 'package:flutter/material.dart';
import 'package:flutter_dapp/view_model/dapp_view_model.dart';
import 'package:flutter_dapp/widgets/button.dart';
import 'package:provider/provider.dart';

class DappPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/bg.jpg"),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _balanceArea(context),
                    /*InkWell(
                      onTap: () {
                        ethUtils.getBalance().then((data) => _balance = data);
                        setState(() {});
                      },
                      child: Container(
                        child: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        color: Colors.red,
                      ),
                    ),*/
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      _setValue(),
                      SizedBox(
                        height: 30,
                      ),
                      _actionArea()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _actionArea() {
    return Consumer<DappViewModel>(
      builder: ((context, viewModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              title: "DEPOSIT",
              color: Colors.lightBlueAccent,
              onTapped: () async {
                var _depositReceipt =
                    await viewModel.contractUtils.depositCoin(viewModel.value);
                if (viewModel.value == 0) {
                  insertValidValue(context);
                  return;
                } else {
                  modal(context, "deposit", _depositReceipt);
                }
              },
            ),
            SizedBox(
              width: 10,
            ),
            CustomButton(
              title: "WITHDRAW",
              color: Colors.pinkAccent,
              onTapped: () async {
                var _widthrawReceipt =
                    await viewModel.contractUtils.withdrawCoin(viewModel.value);
                if (viewModel.value == 0) {
                  insertValidValue(context);
                  return;
                } else {
                  modal(context, "withdraw", _widthrawReceipt);
                }
              },
            ),
          ],
        );
      }),
    );
  }

  Consumer<DappViewModel> _setValue() {
    return Consumer<DappViewModel>(
      builder: ((context, viewModel, child) {
        return Container(
          child: Center(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "You value here...",
                border: InputBorder.none,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.only(left: 12),
              ),
              onChanged: (val) {
                viewModel.setValue = val;
              },
            ),
          ),
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        );
      }),
    );
  }

  Center _balanceArea(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.3,
        child: Card(
          elevation: 20.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "BALANCE",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Consumer<DappViewModel>(builder: (context, viewModel, child) {
                return viewModel.balance == null
                    ? CircularProgressIndicator()
                    : Text(
                        viewModel.balance,
                        style: TextStyle(
                            fontSize: 25.0, color: Colors.blue.shade600),
                        textAlign: TextAlign.center,
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

insertValidValue(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.8),
          title: Text(
            'Permission problem',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 1.0,
            ),
          ),
          content: const Text('Upps, you try 0 ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
              )),
          actions: [
            ElevatedButton(
              child: Text('OKAY'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

modal(BuildContext context, String text, String receipt) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.8),
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Thanks, $text",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Use the transaction hash bellow to check if it was successful",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueGrey.shade600),
                ),
                Text(receipt,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87)),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('OKAY'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
