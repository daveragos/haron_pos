import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haron_pos/config/theme.dart';
import 'package:haron_pos/data/model/product.dart';
import 'package:haron_pos/presentation/blocs/product/product_bloc.dart';
import 'package:haron_pos/presentation/blocs/product/product_event.dart';
import 'package:haron_pos/presentation/blocs/product/product_state.dart';
import 'package:haron_pos/presentation/pages/product_page/right_pane.dart';

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
                      .watch<ProductBloc>()
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

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantityToAdd = 1; // Local counter for quantity adjustments

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              'assets/${widget.product.id}.jpg',
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
                  Text(widget.product.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('\$${widget.product.price.toStringAsFixed(2)}'),
                ],
              ),
              const Spacer(),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 4),
              // Decrease quantity
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.highlightColor,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (_quantityToAdd > 1) {
                        _quantityToAdd--;
                      }
                    });
                  },
                  icon: const Icon(Icons.remove),
                ),
              ),
              const SizedBox(width: 8),
              // Display quantity
              Text(
                '$_quantityToAdd',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 8),
              // Increase quantity
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _quantityToAdd++;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
              const Spacer(),
              // Add to cart button
             ElevatedButton(
  onPressed: () {
    // Add product to cart with the current quantity
    context.watch<ProductBloc>().add(AddToCart(widget.product.id));

    // Update the quantity in the cart
    final bloc = context.watch<ProductBloc>();
    final cartProduct = bloc.cartProducts.firstWhere(
      (p) => p.id == widget.product.id,
      orElse: () => widget.product.copyWith(quantity: 0),
    );

    if (cartProduct.quantity == 0) {
      bloc.cartProducts.add(widget.product.copyWith(quantity: _quantityToAdd));
    } else {
      cartProduct.quantity += _quantityToAdd;
    }

    // Emit updated total amount
    double totalAmount = bloc.cartProducts.fold(
      0.0,
      (sum, product) => sum + (product.price * product.quantity),
    );
    bloc.add(UpdateTotalAmount(totalAmount));

    // Reset the local quantity counter
    setState(() {
      _quantityToAdd = 1;
    });
  },
  child: const Text('Add'),
),

              const SizedBox(width: 4),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
