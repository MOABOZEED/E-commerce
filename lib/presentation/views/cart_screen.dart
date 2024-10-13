import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/providerProduct.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
   late ProductProvider provider;
  @override
  void initState() {
    provider = Provider.of<ProductProvider>(context,listen: false);

    provider.getCartUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product")),
      body: Consumer<ProductProvider>(


        builder:(context, provider, child) {
          return provider.isLoading?const Center(child: CircularProgressIndicator(),): ListView.builder(
            itemCount: provider.cartProduct.length,
            itemBuilder: (context, index) {
              return Center(
                  child: provider.cartProduct.isNotEmpty?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Image.network(provider.cartProduct[index].image,)),
                SizedBox(width: 10,),
                          Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text(provider.cartProduct[index].title),
                      Text("${provider.cartProduct[index].price}"),
                      Text("${provider.cartProduct[index].rating.rate}"),
                    ],
                  ),),
                        ],
                      ),
                      SizedBox(height: 30,),

                    ],
                  ):Center(child: const Text("No Data",style: TextStyle(color: Colors.black,fontSize: 50),)));
            },
          );
        },
      ),
    );
  }
}
