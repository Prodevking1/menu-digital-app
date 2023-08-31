import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/product_controller.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/presentation/widgets/button_widget.dart';
import 'package:pos_app/presentation/widgets/custom_dropdown.dart';
import 'package:pos_app/presentation/widgets/input_widget.dart';

class AddProductsToCategoryPage extends StatelessWidget {
  AddProductsToCategoryPage({super.key});

  ProductController productController = Get.put(ProductController());

  TextEditingController productNameController = TextEditingController();
  TextEditingController price1Controller = TextEditingController();
  TextEditingController price2Controller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text('Add Products to ${widget.categoryName}'),
      ), */
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      return productController.categories.isNotEmpty
                          ? CustomDropdown(
                              hintText: 'Selectionnez une catégorie',
                              items: productController.categories.toList(),
                              onChanged: (value) {
                                productController.categoryName.value = value;
                              },
                            )
                          : const Center(
                              child: Text('Chargement des catégories...'),
                            );
                    })),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomInput(
                    hintText: 'Nom',
                    controller: productNameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomInput(
                          type: TextInputType.number,
                          hintText: 'Premier prix',
                          controller: price1Controller,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInput(
                          type: TextInputType.number,
                          hintText: 'Deuxième prix',
                          controller: price2Controller,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomInput(
                    hintText: 'Description',
                    controller: descriptionController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    text: 'Ajouter',
                    onPressed: insertProduct,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void insertProduct() async {
    Product product = Product(
      name: productNameController.text,
      price1: int.tryParse(price1Controller.text) ?? 0,
      category: productController.categoryName.value,
      description: descriptionController.text,
      //image: imageUrl,
    );

    await productController.insertProduct(product);
  }
}
