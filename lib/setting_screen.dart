import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:trex/license_screen.dart';
import 'package:trex/license_screen.dart';
import 'package:trex/styling.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<String> _items = ["License", "Version 1.0"];
  /// start connection for android
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Setting'),
          backgroundColor: Styling.primaryColor,
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: this._items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${this._items[index]}'),
                onTap: () => this._openSetting(index)
              );
            },
          ),
        ),
      ),
    );
  }

  _openSetting(index) {
    switch(index){
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LicenseScreen()),
        );
        break;
      default:
        break;
    }
  }
}
