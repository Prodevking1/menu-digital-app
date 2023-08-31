import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  RxSet<String> categories = RxSet<String>();

  insertProduct(Product product) async {
    try {
      final result = await supabase.from('products').insert(product.toJson());
      print(result);
      return result;
    } on PostgrestException catch (e) {
      if (e.code == "23505") {
        Get.snackbar('Ceci existe déjà', '',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 1),
            colorText: Colors.red,
            backgroundColor: Colors.transparent,
            snackStyle: SnackStyle.GROUNDED);
      } else {
        Get.snackbar('Erreur lors de l\'ajout', '',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 1),
            colorText: Colors.red,
            snackStyle: SnackStyle.GROUNDED);
      }
    }
  }

  getCategories() async {
    final result = await supabase.from('categories').select('name');
    return result;
  }
}
