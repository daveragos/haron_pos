import 'product.dart';
import 'customer.dart';

enum OrderType { dineIn, delivery, toGo }

class Order {
  final String id;
  final DateTime date;
  final List<Product> products;
  final double totalAmount;
  final String paymentMethod; // e.g., "Cash", "Card", "Mobile Payment"
  final bool isPaid;
  final OrderType orderType;  // Enum for order type
  final Customer? customer;   // Optional customer details

  Order({
    required this.id,
    required this.date,
    required this.products,
    required this.totalAmount,
    required this.paymentMethod,
    required this.isPaid,
    required this.orderType,
    this.customer,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: DateTime.parse(json['date']),
      products: (json['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
      totalAmount: json['totalAmount'],
      paymentMethod: json['paymentMethod'],
      isPaid: json['isPaid'],
      orderType: OrderType.values.firstWhere((e) => e.toString() == 'OrderType.${json['orderType']}'),
      customer: json['customer'] != null ? Customer.fromJson(json['customer']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'products': products.map((product) => product.toJson()).toList(),
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'isPaid': isPaid,
      'orderType': orderType.toString().split('.').last,
      'customer': customer?.toJson(),
    };
  }
}
