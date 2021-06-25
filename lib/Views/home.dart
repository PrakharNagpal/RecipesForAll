import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipes/Views/recipe_view.dart';
import 'package:recipes/models/recipe_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController textEditingController = new TextEditingController();
  List<RecipeModel> recipes = <RecipeModel>[];
  String applicationId = "935814b7";
  String applicationKey = "1704f011c11acc7ba5bbb846c38c4e27";
  getRecipes(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=935814b7&app_key=1704f011c11acc7ba5bbb846c38c4e27";
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["hits"].forEach((element) {
      //print(element.toString());

      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipes.add(recipeModel);
    });

    print("${recipes.toString()}");
  }

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
      SingleChildScrollView(
        child: Container(
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
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        if (textEditingController.text.isNotEmpty) {
                          getRecipes(textEditingController.text);
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
              ),
              Container(
                child: GridView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 10.0,
                  ),
                  children: List.generate(recipes.length, (index) {
                    return RecipieTile(
                      title: recipes[index].label,
                      desc: recipes[index].source,
                      imgUrl: recipes[index].image,
                      url: recipes[index].url,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}

class RecipieTile extends StatefulWidget {
  final String title, desc, imgUrl, url;

  RecipieTile(
      {this.title = "title",
      this.desc = "desc",
      this.imgUrl = "imgUrl",
      this.url = "url"});

  @override
  _RecipieTileState createState() => _RecipieTileState();
}

class _RecipieTileState extends State<RecipieTile> {
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (kIsWeb) {
              _launchURL(widget.url);
            } else {
              print(widget.url + " this is what we are going to see");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeView(
                            postUrl: widget.url,
                          )));
            }
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                              fontFamily: 'Overpass'),
                        ),
                        Text(
                          widget.desc,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              fontFamily: 'OverpassRegular'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
