import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/oders_controller.dart';
import 'package:pos_app/services/db.dart';
import 'package:pos_app/models/order_model.dart';
import 'package:vibration/vibration.dart';

class OrderService {
  OrdersController ordersController = Get.find();
  DBHelper dbHelper = DBHelper();

  Stream<OrderModel> listenToNewOrders() {
    StreamController<OrderModel> streamController =
        StreamController<OrderModel>.broadcast();

    CollectionReference ordersCollection =
        FirebaseFirestore.instance.collection('orders');

    Timestamp initialTimestamp = Timestamp.now();
    print(initialTimestamp);

    ordersCollection
        .where('date', isGreaterThan: initialTimestamp)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      querySnapshot.docChanges.forEach((DocumentChange documentChange) {
        if (documentChange.type == DocumentChangeType.added) {
          DocumentSnapshot<Object?> documentSnapshot = documentChange.doc;

          OrderModel order = OrderModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>);
          ordersController.pendingOrders.add(order);
          streamController.add(order);
          Vibration.vibrate(duration: 1000, amplitude: 255);
        }
      });
    });

    return streamController.stream;
  }

  deleteAll() async {
    final collectionRef = FirebaseFirestore.instance.collection('orders');
    final QuerySnapshot snapshot = await collectionRef.get();

    snapshot.docs.forEach((element) async {
      await element.reference.delete();
    });
  }

  void confirmAndSaveOrder(OrderModel order) {
    try {
      order.isValidated = true;
      dbHelper.insertOrder(order);
    } catch (e) {
      print(e);
    }
  }

  void cancelAndSaveOrder(OrderModel order) async {
    try {
      order.isValidated = true;
      await dbHelper.getAllOrders();
    } catch (e) {
      print(e);
    }
  }
}
