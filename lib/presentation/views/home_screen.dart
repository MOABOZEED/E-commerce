import 'package:e_commerce/presentation/views/cart_screen.dart';
import 'package:e_commerce/presentation/views/widget/animation_icon.dart';
import 'package:e_commerce/presentation/views/widget/grad_view_product.dart';
import 'package:e_commerce/presentation/views/widget/list_view_product.dart';
import 'package:e_commerce/presentation/views/widget/shimmer_loading_effect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/providerProduct.dart';
import '../../provider/providercategory.dart';
import '../model/cart_user_model.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  TapNameProvider? categoryProvider;
  CartUserModel? cartUserModel;
  @override
  void initState() {
    super.initState();




    WidgetsBinding.instance.addPostFrameCallback((_) {

      categoryProvider= Provider.of<TapNameProvider>(context,listen: false);
      categoryProvider?.getCategoryMainProductName();
      Provider.of<ProductProvider>(context, listen: false).getAllProduct();
      _tabController = TabController(
        initialIndex: 0,
        length: 5,
        vsync: this,
      );

    });
  }


  @override
  Widget build(BuildContext context) {
    return  Consumer<TapNameProvider>(
      builder: (context, categoryProvider, child) {
        if (categoryProvider.isLoaing == true) {
          return const CardListItem(
            isLoading: true,
          );
        } else {
          if (_tabController == null) {
            return const Center(
                child: CardListItem(
                  isLoading: true,
                ));
          }

          return Consumer<ProductProvider>(
            builder: (context, provider,child) {
              return DefaultTabController(
                  length: categoryProvider.categoriesNameTab.length,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: const AnimatedIconExample(),
                      centerTitle: true,
                      actions: [IconButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>const CartScreen())), icon: const Icon(Icons.shopping_cart))],
                      title: const Text("Category"),
                      bottom: TabBar(
                        controller: _tabController,
                        onTap: (int index) {

                          // provider.filterByCategory(
                          //   categoryProvider.categoriesNameTab[index],
                          // );
                          provider.filterProductWithForIn(categoryProvider.categoriesNameTab[index]);
                        },
                        tabs: List<Widget>.generate(
                            categoryProvider.categoriesNameTab.length,
                                (int index) {
                              // print("${provider.productList[0].category}.<<<provider.productList category");




                              return
                                Tab(
                                  child: Text(maxLines: 1,style: TextStyle(fontSize: 10), categoryProvider.categoriesNameTab[index]),
                                );
                            }),
                      ),
                    ),
                    body: TabBarViewGenerate(tabController: _tabController,),
                  ));
            },
          );
        }
      },
    );
  }
}

class TabBarViewGenerate extends StatelessWidget {
  TabBarViewGenerate({
    super.key,
    required TabController? tabController,
  }) : _tabController = tabController;

  final TabController? _tabController;
   ProductProvider ? productProvider;

  @override
  Widget build(BuildContext context) {

    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List<Widget>.generate(

                  Provider.of<TapNameProvider>(context)
                      .categoriesNameTab
                      .length,
                  (int index) {
                    return provider.isGridView
                        ? GradViewProduct(
                            productList: provider.filterCategories,
                          )
                        : ListViewProduct(
                            productList: provider.filterCategories,
                          );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

