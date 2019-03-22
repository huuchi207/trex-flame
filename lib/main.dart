import 'dart:ui' as ui;

import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trex/game/game.dart';
import 'package:trex/purchase_screen.dart';
import 'package:trex/setting_screen.dart';
import 'package:trex/styling.dart';

void main() async {
  Flame.audio.disableLog();
  List<ui.Image> image = await Flame.images.loadAll(["sprite.png"]);
  TRexGame tRexGame = TRexGame(spriteImage: image[0]);
  runApp(new MaterialApp(
      title: 'TRex Game',
      home: GameWrapper(tRexGame)));

  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) => tRexGame.onTap());

//  SystemChrome.setEnabledSystemUIOverlays([]);
}

class GameWrapper extends StatelessWidget {
  final TRexGame tRexGame;
  GameWrapper(this.tRexGame);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("TRex Game"),
          elevation: 0.0,
          backgroundColor: Styling.primaryColor,
          actions: <Widget>[
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
              splashColor: Colors.white,
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PurchaseScreen()),
                );
              },
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.settings_applications,
                  color: Colors.white,
                ),
              ),
              splashColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingScreen()),
                );
              },
            ),

          ],
        ),
        body: tRexGame.widget);
  }
}
