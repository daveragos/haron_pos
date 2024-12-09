import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haron_pos/config/theme.dart';
import 'package:haron_pos/presentation/blocs/product/product_bloc.dart';
import 'package:haron_pos/presentation/blocs/product/product_event.dart';
import 'package:haron_pos/presentation/blocs/product/product_state.dart';

class RightPane extends StatelessWidget {
  const RightPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.accentColor.withOpacity(0.2),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              const Spacer(),
              const Text(
                'Cart',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.watch<ProductBloc>().add(ClearCart());
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          // Table Header
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Item'),
                Text('Quantity'),
                Text('Price'),
              ],
            ),
          ),
          // Cart Items
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  final cartProducts = context.watch<ProductBloc>().cartProducts;

                  if (cartProducts.isEmpty) {
                    return const Center(child: Text("Cart is empty"));
                  }

                  return ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      final product = cartProducts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product.name),
                            Text(product.quantity.toString()),
                            Text('\$${(product.price * product.quantity).toStringAsFixed(2)}'),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text("Cart is empty"));
              },
            ),
          ),
          // Total Amount
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  final total = context
                      .watch<ProductBloc>()
                      .cartProducts
                      .fold(0.0, (sum, product) => sum + product.price * product.quantity);
                  return Text('Total: \$${total.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold));
                }
                return const SizedBox();
              },
            ),
          ),
          // Checkout Button
          ElevatedButton(
            onPressed: () {
              context.watch<ProductBloc>().add(Checkout());
            },
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
