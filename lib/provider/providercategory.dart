import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class TapNameProvider extends ChangeNotifier {
  final String? listName;
  List<dynamic> categoriesNameTab = [];




  bool isLoaing = false;

  var headers = {'Content-Type': 'application/json'};
  var data = json.encode({"ClientId": "e090748f-f84b-473d-85d3-59c9cec152ec"});

  TapNameProvider({this.listName});

  Future getCategoryMainProductName() async {

    isLoaing = true;
    Dio dio = Dio();
    var res = await dio.get("https://fakestoreapi.com/products/categories");
    if (res.statusCode == 200) {
      categoriesNameTab = res.data;
      categoriesNameTab.add("All") ;

      print("+++++++categoriesNameTab===>>${categoriesNameTab}++++++++++");


      isLoaing = false;
    } else {}

    notifyListeners();
  }

  getNameCategory({required String name}) {

  }
}
