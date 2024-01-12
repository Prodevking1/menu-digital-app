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
  final collectionRef = FirebaseFirestore.instance.collection('orders');
  Timestamp? lastProcessedTimestamp;

  Stream<OrderModel> listenToNewOrders() {
    StreamController<OrderModel> streamController =
        StreamController<OrderModel>.broadcast();

    if (lastProcessedTimestamp == null) {
      lastProcessedTimestamp = Timestamp.now();
    }

    CollectionReference ordersCollection =
        FirebaseFirestore.instance.collection('orders');

    ordersCollection
        .where('date', isGreaterThan: lastProcessedTimestamp)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      querySnapshot.docChanges.forEach((DocumentChange documentChange) {
        if (documentChange.type == DocumentChangeType.added) {
          DocumentSnapshot<Object?> documentSnapshot = documentChange.doc;

          print(documentSnapshot.data());

          OrderModel order = OrderModel.fromJson(
              documentSnapshot.data() as Map<String, dynamic>);
          order.docRef = documentSnapshot.reference;
          ordersController.pendingOrders.add(order);
          streamController.add(order);
          Vibration.vibrate(duration: 1000, amplitude: 255);
          lastProcessedTimestamp = order.date;
        }
      });
    });

    return streamController.stream;
  }

  deleteAll() async {
    final QuerySnapshot snapshot = await collectionRef.get();

    snapshot.docs.forEach((element) async {
      await element.reference.delete();
    });
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
