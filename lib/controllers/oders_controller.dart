import 'package:get/get.dart';
import 'package:pos_app/models/order_model.dart';

class OrdersController extends GetxController {
  RxList<OrderModel> orders = RxList<OrderModel>();
  RxList<OrderModel> confirmedOrders = RxList<OrderModel>();
  RxList<OrderModel> pendingOrders = RxList<OrderModel>();

  @override
  void onInit() {
    super.onInit();
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
    pendingOrders.remove(order);
    confirmedOrders.add(order);
  }
}
