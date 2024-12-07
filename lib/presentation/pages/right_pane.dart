import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haron_pos/config/theme.dart';
import 'package:haron_pos/presentation/blocs/product/product_bloc.dart';
import 'package:haron_pos/presentation/blocs/product/product_state.dart';

class RightPane extends StatefulWidget {
  const RightPane({super.key});

  @override
  State<RightPane> createState() => _RightPaneState();
}

class _RightPaneState extends State<RightPane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.accentColor.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expanded ensures ListView gets a bounded height
          Expanded(
            child: Column(
              children: [
                Row(
                  children: const [
                    Text('Item'),
                    Spacer(),
                    Text('Quantity'),
                    Spacer(),
                    Text('Price'),
                  ],
                ),
                // Wrap ListView.builder in Expanded
                Expanded(
                  child: BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, state) {
                      // You can add listener logic if needed
                    },
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductCart) {
                        return ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return Row(
                              children: [
                                Text(product.name),
                                const Spacer(),
                                Text(product.quantity.toString()),
                                const Spacer(),
                                Text('\$${product.price.toStringAsFixed(2)}'),
                              ],
                            );
                          },
                        );
                      } else if (state is ProductError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return const Center(child: Text("No items found"));
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Center(
                child: Text('Total Amount: \$${0.0}'), // Replace with dynamic total
              ),
              ElevatedButton(
                onPressed: () {
                  // Add checkout logic
                },
                child: const Text('Checkout'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
