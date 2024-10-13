import 'package:e_commerce/presentation/views/home_screen.dart';
import 'package:e_commerce/provider/providerProduct.dart';
import 'package:e_commerce/provider/providercategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()..getAllProduct()),
        ChangeNotifierProvider(create: (_) => TapNameProvider()),
    ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
