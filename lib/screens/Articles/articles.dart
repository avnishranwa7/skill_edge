import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:skill_edge/components/navigation_menu.dart';
import 'package:skill_edge/models/article_model.dart';
import 'package:skill_edge/screens/Articles/components/article_tile.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  List<ArticleModel> articleData = [];
  //List mapData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // await Future.delayed(const Duration(seconds: 2));
    var articleJSON = await rootBundle.loadString("sample_data/articles.json");
    var decodedData = jsonDecode(articleJSON);
    // print(decodedData);
    articleData = List.from(decodedData["articles"])
        .map<ArticleModel>((article) => ArticleModel.fromMap(article))
        .toList();
    //mapData = decodedData["articles"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text("SKILL EDGE"),
          ),
          // centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const NavigationMenu(ind: 2),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: articleData.length,
                    itemBuilder: (context, index) =>
                        ArticleTile(article: articleData[index])),
              ),
              // Expanded(
              //   child: ListView.builder(
              //       itemCount: articleData.length,
              //       itemBuilder: (context, index) =>
              //           Text(mapData[index]["title"])),
              // ),
            ],
          ),
        ));
  }
}
