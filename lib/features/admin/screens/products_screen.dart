import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/services/admin_services.dart';
import 'package:flutter/material.dart ';

import '../../../models/product.dart';
import '../../account/widgets/single_product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchAllProducts();
    });  }



  fetchAllProducts() async {
    products = await adminServices.fetchAllTheProducts(context);
    setState(() {});
    print(products);
  }



  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void deleteProduct(Product product, int index){
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: (){
          products!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
                itemCount: products!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context,index){
                  final productData = products![index];
                  return Column(
                    children: [
                      SizedBox(height: 140,
                      child: SingleProduct(
                        productUrl: productData.images[0],
                      ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child:
                                Container(
                                  child: Text(
                                    productData.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                  ),
                                ),
                            ),
                            Container(
                              child: GestureDetector(
                                onTap: (){
                                  deleteProduct(productData, index);
                                  print('Deleted is clicked!');
                                },
                                child: Icon(
                                    Icons.delete_outlined
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );

                }),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: navigateToAddProduct,
              tooltip: 'Add a Product',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
