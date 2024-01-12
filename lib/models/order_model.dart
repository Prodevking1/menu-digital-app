import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  DocumentReference? docRef;
  Timestamp? date;
  late bool isValidated;
  // late int clientContact;
  late List<OrderItem> items;
  late int table;
  late int totalAmount;

  OrderModel({
    this.date,
    required this.isValidated,
    // required this.clientContact,
    required this.items,
    required this.table,
    required this.totalAmount,
    this.docRef,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      docRef: json['docRef'] as DocumentReference?,
      date: json['date'] as Timestamp,
      isValidated: /* json['is_validated'] as bool */ false,
      // clientContact: json['client_contact'],
      items: (json['items'] as List<dynamic>)
          .map((itemJson) =>
              OrderItem.fromJson(itemJson as Map<String, dynamic>))
          .toList(),
      table: json['table'],
      totalAmount: json['total_amount'] ?? 4600,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date!.toDate(),
      'isValidated': isValidated,
      // 'clientContact': clientContact,
      'items': items.map((item) => item.toJson()).toList(),
      'table': table,
      'totalAmount': totalAmount,
    };
  }
}

class OrderItem {
  late int quantity;
  late String productName;

  OrderItem({
    required this.quantity,
    required this.productName,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      quantity: json['quantity'] as int,
      productName: json['product_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'product_name': productName,
    };
  }
}
