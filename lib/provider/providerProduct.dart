import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../presentation/model/cart_user_model.dart';
import '../presentation/model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];
  List<ProductModel> filterCategories = [];
  // List<CartUserModel> cart=[];
  final dio = Dio();

  bool isLoading = false;
  bool isGridView = false;
  bool isPlaying = true;

  void toggleAnimation(AnimationController controller) {
    isPlaying = !isPlaying;
    isGridView = !isGridView;
    isPlaying ? controller.forward() : controller.reverse();
    notifyListeners();
  }



  filterProductWithForIn(String category) {
    filterCategories.clear();
    for (var product in productList) {
      if (category == 'All' || product.category == category) {
        filterCategories.add(product);
      }
    }

    notifyListeners();
    return filterCategories;
  }

// create filterProductWithForEach
  filterProductWithForEach(String category) {
    filterCategories.clear();

    if (category == 'All') {
      productList.forEach((product) {
        filterCategories.add(product);
      });
    } else {
      productList.forEach((product) {
        if (product.category == category) {
          filterCategories.add(product);
        }
      });
    }

    notifyListeners();
    return filterCategories;
  }

  // create filterBywhere
  filterByCategory(String category) {
    if (category == 'All') {
     // return productList;
      notifyListeners();
     var res= filterCategories.addAll(productList) ;
      return res;

     //  filterCategories =
     //      productList.where((product) => product.category == category).toList();
    }  else {
      filterCategories =
          productList.where((product) => product.category == category).toList();
    }
    notifyListeners();
    return filterCategories;
  }
  Future<List<ProductModel>> getAllProduct() async {
    isLoading = true;
    notifyListeners();


    String BaseUrl ="https://fakestoreapi.com/products";
    try {
      var response = await dio.get(
          "${BaseUrl}");

      if (response.statusCode == 200) {
        productList = List<ProductModel>.from(
            response.data.map((x) => ProductModel.fromJson(x)));
        // for(var item in response.data){
        //   productList.add(ProductModel.fromJson(item));
        // }

        filterByCategory('electronics');
        filterProductWithForEach('electronics');
        notifyListeners();
        // print(productList);
        // log(" load products: ${response.data}");
        // log(">>>productList>>>${jsonEncode(productList.map((product) => product.toJson()).toList())}}");
        return productList;


      } else {
        print("Failed to load products: ${response.data}");
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
    return productList;
  }





  List<CartUserModel> products=[];
  Future  getCartUser() async {

    try {
      isLoading=true;
      notifyListeners();
      final response = await dio.get("https://fakestoreapi.com/carts/user/1");
     if (response.statusCode == 200) {
       products=[];
       cartProduct=[];
        final result  = List<CartUserModel>.from(
            response.data[0]["products"].map((x) => CartUserModel.fromJson(x)));
        products.addAll(result);
       for (CartUserModel cartModel in products) {
       await  getProductById(cartModel.productId);
       }
       isLoading=false;
       notifyListeners();
      } else {
        print("Failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }

  }


  List<ProductModel> cartProduct=[];
  Future getProductById(dynamic id)async {

   final baseUrl = "https://fakestoreapi.com/products/$id";
   print("baseUrl $baseUrl");
      try{
     final response =await dio.get(baseUrl);
     if(response.statusCode==200){
       final result = ProductModel.fromJson(response.data);
       cartProduct.add(result);
       print("Products => ${cartProduct}");
       notifyListeners();
     }

   }catch(e){
     return e.toString();
   }
  }
}
