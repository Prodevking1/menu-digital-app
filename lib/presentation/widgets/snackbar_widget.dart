import 'package:flutter/material.dart';
import 'package:get/get.dart';

snackbarWidget({required order, required message, required color}) {
  return Get.snackbar("", "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color ?? Colors.green,
      colorText: Colors.white,
      titleText: Text(
        "TABLE ${order.table}",
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      messageText: Text(message ?? "",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
      duration: Duration(seconds: 10));
}
