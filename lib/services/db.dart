import 'package:get_storage/get_storage.dart';
import 'package:pos_app/models/order_model.dart';

class DBHelper {
  static final String tableName = 'orders';

  static Future<void> initializeDatabase() async {
    await GetStorage.init('orders');
  }

  Future<int> insertOrder(OrderModel order) async {
    await initializeDatabase();
    final box = GetStorage();
    final List<dynamic>? orders = box.read<List<dynamic>>(tableName) ?? [];
    orders!.add(order.toJson());
    box.write(tableName, orders);
    return 1;
  }

  Future<List<OrderModel>> getAllOrders() async {
    await initializeDatabase();
    final box = GetStorage();
    final List<dynamic>? orders = box.read<List<dynamic>>(tableName);
    if (orders != null) {
      return orders.map((data) => OrderModel.fromJson(data)).toList();
    }
    print(orders!.length);
    return [];
  }
}
