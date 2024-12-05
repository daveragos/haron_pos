import 'package:haron_pos/data/model/product.dart';

class Transaction {
  final String id;
  final DateTime date;
  final List<Product> items;
  final double totalAmount;

  Transaction({
    required this.id,
    required this.date,
    required this.items,
    required this.totalAmount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: DateTime.parse(json['date']),
      items: (json['items'] as List)
          .map((item) => Product.fromJson(item))
          .toList(),
      totalAmount: json['totalAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
    };
  }
}
