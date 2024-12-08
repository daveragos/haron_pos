import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haron_pos/data/model/product.dart';
import 'package:haron_pos/presentation/blocs/product/product_bloc.dart';
import 'package:haron_pos/presentation/blocs/product/product_event.dart';
import 'package:haron_pos/presentation/blocs/product/product_state.dart';
import 'package:haron_pos/presentation/pages/right_pane.dart';

class CenterPane extends StatefulWidget {
  const CenterPane({super.key});

  @override
  State<CenterPane> createState() => _CenterPaneState();
}

class _CenterPaneState extends State<CenterPane> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(

      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          final categories = ['All', ...state.categories.map((c) => c.name)];

          // Rebuild the TabController if the number of tabs changes
          if (_tabController.length != categories.length) {
            _tabController.dispose();
            _tabController =
                TabController(length: categories.length, vsync: this);
          }

          return Column(
            children: [
              TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.orange,
                tabs: categories.map((name) => Tab(text: name)).toList(),
                onTap: (index) {
                  final category = categories[index];
                  context
                      .read<ProductBloc>()
                      .add(FilterProductsByCategory(category));
                },
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductCard(product: product);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RightPane(),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is ProductError) {
          return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red)));
        } else {
          return const Center(child: Text("Unknown state"));
        }
      },
    );
  }
}
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              'assets/${product.id}.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Row(
            children: [
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(product.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('\$${product.price.toStringAsFixed(2)}'),
                ],
              ),
              const Spacer(),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    context.read<ProductBloc>().add(AddToCart(product.id));
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    context.read<ProductBloc>().add(RemoveFromCart(product.id));
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
