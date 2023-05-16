import 'dart:async';

import 'package:get/get.dart';
import 'package:pos_app/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderController {
  RxList<Order> orders = RxList([]);
  StreamController streamController = StreamController();

  Stream listForNewOrder() {
    final supabase = Supabase.instance.client;

    supabase.from('order').stream(primaryKey: ['id']).listen((event) async {
      convertJsonToOrders([event]);
      streamController.add(orders.last);
    });
    return streamController.stream;
  }

  Future convertJsonToOrders(List<dynamic> event) async {
    event.forEach((eventData) {
      eventData.forEach((ordersData) {
        print(ordersData);
        orders.add(Order.fromJson(ordersData));
      });
    });
  }

  sortOrdersByDate(orders) {
    return orders;
  }
}
