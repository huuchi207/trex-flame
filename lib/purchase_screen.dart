import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:trex/styling.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  final List<String> _productLists = Platform.isAndroid
      ? [
          'product_id_1',
          'product_id_2',
          'product_id_3',
          'product_id_4',
          'product_id_5',
          'product_id_6',
          'product_id_7',
          'product_id_8',
          'product_id_9',
          'product_id_10',
          'product_id_11',
          'product_id_12',
          'product_id_13',
          'product_id_14',
          'product_id_15',
          'product_id_16',
          'product_id_17',
          'product_id_18',
          'product_id_19',
        ]
      : ['com.cooni.point1000', 'com.cooni.point5000'];
  String _platformVersion = 'Unknown';
  List<IAPItem> _items = [];

  /// start connection for android
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterInappPurchase.platformVersion;
      // ignore: non_type_in_catch_clause
    } on Exception {
      platformVersion = 'Failed to get platform version.';
    }

    // initConnection
    var result = await FlutterInappPurchase.initConnection;
//    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    // refresh items for android
    String msg = await FlutterInappPurchase.consumeAllItems;
//    print('consumeAllItems: $msg');

    this._getProduct();
  }

  /// start connection for android
  @override
  void dispose() async {
    super.dispose();
    await FlutterInappPurchase.endConnection;
  }

  Future<Null> _buyProduct(IAPItem item, BuildContext context) async {
    try {
      PurchasedItem purchased =
          await FlutterInappPurchase.buyProduct(item.productId);
      showToast("Purchase Successfully", context);

      String msg = await FlutterInappPurchase.consumeAllItems;
      showToast("Consume Successfully", context);
    } catch (error) {
      showToast('$error', context);
    }
  }

  void showToast(String text, BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  Future<Null> _getProduct() async {
    List<IAPItem> items = await FlutterInappPurchase.getProducts(_productLists);
    for (var item in items) {
//      print('${item.toString()}');
      this._items.add(item);
    }

    setState(() {
      this._items = items;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Purchase'),
          backgroundColor: Styling.primaryColor,
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: this._items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${this._items[index].title}'),
                subtitle: Text('${this._items[index].localizedPrice}'),
                onTap: () => this._buyProduct(this._items[index], context),
              );
            },
          ),
        ),
      ),
    );
  }
}
