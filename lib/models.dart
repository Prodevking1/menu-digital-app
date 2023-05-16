class Order {
  int? id;
  String? date;
  int? table;
  int? items;
  int? clientPhone;

  Order({
    this.id,
    this.date,
    this.table,
    this.items,
    this.clientPhone,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: json['created_at'],
      table: json['table'],
      items: json['item'],
      clientPhone: json['client_phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'table': table,
      'items': items,
      'clientPhone': clientPhone,
    };
  }
}
