import 'dart:async';

import 'package:get/get.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:pos_app/models/product_model.dart';
import 'package:pos_app/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
final channel = supabase.channel('orders_channel');

class HomeController {
  RxList<OrderModel> orders = RxList<OrderModel>([]);
  StreamController<OrderModel> streamController = StreamController();
  SupabaseService supabaseService = SupabaseService();

  /* Future<Product> addProductNameInItem(ItemModel item) async {
    final result = await supabase
        .from('product')
        .select('name, price')
        .eq('id', item.product!.id)
        .single();
    final Product product = Product.fromJson(result);
    item.product!.name = product.name;
    return product;
  } */

  Stream<OrderModel> listForNewOrder() {
    //listenToDatabaseChanges();
    supabase
        .from('OrderModel')
        .stream(primaryKey: ['id']).listen((event) async {
      print(event.last);
      /* convertToOrders([event]);
      final lastOrder = orders.last;
      await addProductNameInItem(lastOrder.item!);
      //print(orders.last.item!.product!.toJson());
      streamController.add(orders.last); */
    });
    return streamController.stream;
  }

  /* Stream<OrderModel> listForNewOrder() {
    //listenToDatabaseChanges();
    supabase.from('item').stream(primaryKey: ['id']).listen((event) async {
      print(event.last);
      /* convertToOrders([event]);
      final lastOrder = orders.last;
      await addProductNameInItem(lastOrder.item!);
      //print(orders.last.item!.product!.toJson());
      streamController.add(orders.last); */
    });
    return streamController.stream;
  }
 */
  void convertToOrders(List<dynamic> event) {
    for (var eventData in event) {
      eventData.forEach((ordersData) {
        orders.add(OrderModel.fromJson(ordersData));
      });
    }
  }

  /* void listenToDatabaseChanges() async {
    supabase.channel('orders_channel').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: '*', schema: '*'),
      (payload, [ref]) {
        print('done');
        print(payload);
      },
    ).on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: '*', schema: '*'),
      (payload, [ref]) {
        print('done');
        print(payload);
      },
    ).subscribe();
  } */

  /* void listenToDatabaseChanges() async {
    supabase.channel('orders_channel').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: 'INSERT', schema: 'public', table: 'OrderModel'),
      (payload, [ref]) async {
        final orderId = payload['new']['id'];
        final orderData = payload['new'];
        final itemData = await supabase
            .from('item')
            .select('*')
            .eq('order_id', orderId)
            .single();

        final OrderModel = OrderModel.fromJson(orderData);
        final item = ItemModel.fromJson(itemData);
        OrderModel.item = item;
        print('done');
        print('New OrderModel received: ${OrderModel.toString()}');
      },
    ).subscribe();
  } */

  
}
