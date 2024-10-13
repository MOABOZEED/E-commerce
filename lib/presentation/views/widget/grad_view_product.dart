import 'package:e_commerce/provider/providercategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../provider/providerProduct.dart';
import '../../model/product_model.dart';

class GradViewProduct extends StatelessWidget {
  const GradViewProduct({
    super.key,
    required this.productList,
  });

  final List<ProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productList.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, i) => Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(productList[i].image),
            )),
            Align(
              alignment: Alignment.center,
              child: Text("${productList[i].title}"),
            ),
            Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: "${productList[i].price}",
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                const TextSpan(
                  text: "\$",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
