/* class Order {
  int? id;
  String? date;
  int? table;
  ItemModel? item;
  int? clientPhone;
  bool? isValidated;

  Order({
    this.id,
    this.date,
    this.table,
    this.item,
    this.clientPhone,
    this.isValidated,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: json['created_at'],
      table: json['table'],
      item: ItemModel.fromJson(
        json['item'],
      ),
      clientPhone: json['client_phone'],
      isValidated: json['is_validated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'table': table,
      'item': item,
      'clientPhone': clientPhone,
    };
  }
}

class Product {
  int? id;
  String? name;
  String? category;

  Product({this.name, this.category, this.id});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      id: json['product_id'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
    };
  }
}

class ItemModel {
  Product? product;
  int? quantity;

  ItemModel({this.product, this.quantity});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(product: Product.fromJson(json), quantity: json['quantity']);
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': product!.id,
      'quantity': quantity,
    };
  }
}
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  Timestamp? date;
  late bool isValidated;
  late int clientContact;
  late List<OrderItem> items;
  late int table;
  late int totalAmount;

  OrderModel({
    this.date,
    required this.isValidated,
    required this.clientContact,
    required this.items,
    required this.table,
    required this.totalAmount,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      date: json['date'] as Timestamp,
      isValidated: /* json['is_validated'] as bool */ false,
      clientContact: json['client_contact'],
      items: (json['items'] as List<dynamic>)
          .map((itemJson) =>
              OrderItem.fromJson(itemJson as Map<String, dynamic>))
          .toList(),
      table: json['table'] as int,
      totalAmount: json['total_amount'] ?? 4600,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date!.toDate(),
      'isValidated': isValidated,
      'clientContact': clientContact,
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
