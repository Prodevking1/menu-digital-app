import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/services/supabase_service.dart';

SupabaseService supabaseService = SupabaseService();

class ProductController extends GetxController {
  RxSet<String> categories = RxSet<String>();
  RxString categoryName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future insertProduct(Product product) async {
    final result = await supabaseService.insertProduct(product);
    if (result == null) {
      Get.snackbar('Ajoouté avec succès', '',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 1),
          colorText: Colors.green,
          backgroundColor: Colors.transparent,
          snackStyle: SnackStyle.FLOATING);
    }
    return result;
  }

  Future<void> getCategories() async {
    final List result = await supabaseService.getCategories();
    categories.addAll(result.map((e) => e['name']));
  }
}
