import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xff213A50), const Color(0xff071930)],
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(
            vertical: Platform.isIOS ? 60 : 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment:
                  kIsWeb ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "AppGuy",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Text(
                  "Recipes",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "What will you cook today?",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Just enter Incredeints you have and we will show you the best recipes",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: "Enter Incredients",
                        hintStyle: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () {
                      if (textEditingController.text.isNotEmpty) {
                        print("Just do it");
                      } else {
                        print("Just don't do it");
                      }
                    },
                    child: Container(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ]));
  }
}
