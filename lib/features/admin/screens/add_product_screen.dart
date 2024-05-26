import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/screens/appbar_admin.dart';
import 'package:amazon_clone/features/auth/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';

class AddProductScreen extends StatefulWidget {

  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();



  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Home',
    'Fashion'
  ];

  void sellProducts(){
    if(_addProductFormKey.currentState!.validate() && images.isNotEmpty){
        adminServices.sellProducts(
            context: context,
            name: productNameController.text,
            description: descriptionController.text,
            price: double.parse(priceController.text),
            quantity: double.parse(quantityController.text),
            category: category,
            images: images,);
    }
  }

  void selectImages() async{
    var res = await pickImages();

    setState(() {
      images = res;
    });
    print("final list $images");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMethod(),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                images.isNotEmpty ? CarouselImagePicker() : GestureDetector(
                  onTap: selectImages,
                  child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10,4],
                      strokeCap: StrokeCap.round,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.folder_open_outlined,size: 40,),
                            SizedBox(height: 15),
                            Text('Select Product Images',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade400
                            ),)

                          ],
                        ),
                      ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(controller: productNameController, hintText: 'Product Name'),
                const SizedBox(height: 10),
                CustomTextField(controller: descriptionController, hintText: 'Description',maxLines: 7,),
                const SizedBox(height: 10),
                CustomTextField(controller: priceController, hintText: 'Price'),
                const SizedBox(height: 10),
                CustomTextField(controller: quantityController, hintText: 'Quantity'),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    items:
                      productCategories.map((String item) {
                        return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                            );
                      }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        category = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Sell',
                  onTap: (){

                    sellProducts();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  CarouselSlider CarouselImagePicker() {
    return CarouselSlider(
      items: images.map((i) {
        return Builder(
            builder: (BuildContext context) => Image.file(
              i,
              fit: BoxFit.cover,
              height: 200,
            ));
      }).toList(),
      options: CarouselOptions(viewportFraction: 1, height: 200),
    );
  }

  PreferredSize appBarMethod() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: GlobalVariable.appBarGradient),
        ),
        centerTitle: true,
        title: Text(
          'Add Product',
          style: TextStyle(
            color: Colors.black
          ),
        )
        ),
      );

  }
}
