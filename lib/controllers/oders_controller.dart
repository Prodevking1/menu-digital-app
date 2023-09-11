import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:pos_app/presentation/widgets/snackbar_widget.dart';

class OrdersController extends GetxController {
  RxList<OrderModel> orders = RxList<OrderModel>();
  RxList<OrderModel> confirmedOrders = RxList<OrderModel>();
  RxList<OrderModel> pendingOrders = RxList<OrderModel>();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future confirmOrder(OrderModel order) async {
    isLoading.toggle();
    try {
      await order.docRef!.update({'is_validated': true});
      snackbarWidget(
          order: order,
          message: 'Commande confirmée avec succès ',
          color: Colors.green);
      pendingOrders.clear();
      return true;
    } catch (e) {
      print(e);
    } finally {
      isLoading.toggle();
    }
  }

  void addOrder(OrderModel order) {
    order.isValidated ? confirmedOrders.add(order) : pendingOrders.add(order);
    print(pendingOrders.length);
  }

  void cancelOrder(OrderModel order) {
    print(pendingOrders.length);

    pendingOrders.remove(order);
    print(pendingOrders.length);
  }

  void confirmedOrder(OrderModel order) {
    confirmedOrders.add(order);
  }
}
