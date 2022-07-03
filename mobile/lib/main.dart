import 'package:flutter/material.dart';
import 'package:flutter_dapp/view/dapp.dart';
import 'package:flutter_dapp/view_model/dapp_view_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

main() async {
  await dotenv.load(fileName: ".env");
  runApp(Dapp());
}

class Dapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: ((context) => DappViewModel()),
        child: DappPage(),
      ),
    );
  }
}
