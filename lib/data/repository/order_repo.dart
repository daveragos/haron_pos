import 'package:haron_pos/data/model/order.dart';
import 'package:hive/hive.dart';

Future<void> storeOrder(Order order) async {
  final box = await Hive.openBox<Order>('orders'); // Open a Hive box

  // Check if the order already exists
  final existingOrder = box.get(order.id);

  if (existingOrder == null) {
    // If the order doesn't exist, add it to the box
    await box.put(order.id, order);
  } else {
    // If the order already exists, update it
    await box.put(order.id, order);
  }
}

Future<List<Order>> getAllOrders() async {
  final box = await Hive.openBox<Order>('orders');
  return box.values.toList(); // Return all orders stored in Hive
}

