import 'package:e_commerce/presentation/model/product_model.dart';
import 'package:flutter/material.dart';


class ListViewProduct extends StatelessWidget {
  const ListViewProduct({
    super.key,
    required this.productList,
  });

  final List<ProductModel> productList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) => Card(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      price: productList[index].price,

                      image: productList[index].image,
                          title: '${productList[index].category}',
                          productModel: productList[index].description,
                        )));
          },
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network("${productList[index].image}"),
            ),
            trailing: Column(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Text(
                  "${productList[index].rating.rate}",
                ),
              ],
            ),
            title: Text("${productList[index].title}"),
            subtitle: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "${productList[index].price}",
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage(
      {super.key, required this.title, required this.productModel, required this.image, required this.price});

  final String title;
  final String productModel;
  final String image;
  final dynamic price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title) ,),
      body:
            Column(
              children: [
                Image.network(image),
                Center(
                    child: Text("${productModel}")),
                Text("${price}"),
              ],

            ),


      floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(width: 10,),
          IconButton(icon:Icon(Icons.add) ,
            onPressed: (){


            },),
          SizedBox(width: 20,),
          IconButton(icon:
          Icon(Icons.remove) ,onPressed: (){},),
          SizedBox(height: 30,),
        ],
      ),

    );
  }
}
