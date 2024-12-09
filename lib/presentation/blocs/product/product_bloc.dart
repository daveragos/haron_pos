import 'dart:convert';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haron_pos/data/model/category.dart';
import 'package:haron_pos/data/model/product.dart';
import 'package:haron_pos/presentation/blocs/product/product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<Product> allProducts = [];
  List<Category> allCategories = [];
  List<Product> cartProducts = [];

  ProductBloc() : super(ProductLoading()) {

    on<LoadProducts>(_onLoadProducts);

    on<FilterProductsByCategory>(_onFilterProductsByCategory);

    on<DetailsOfProduct>(_onDetailsOfProduct);

    on<AddToCart>(_onAddToCart);

    on<RemoveFromCart>(_onRemoveFromCart);

    on<UpdateQuantity>(_onUpdateQuantity);

    on<ClearCart>(_onClearCart);

    on<Checkout>(_onCheckout);

    on<ClearCheckout>(_onClearCheckout);

    on<UpdateShippingAddress>(_onUpdateShippingAddress);

    on<UpdatePaymentMethod>(_onUpdatePaymentMethod);

    on<UpdateOrderType>(_onUpdateOrderType);

    on<UpdateCustomer>(_onUpdateCustomer);

    on<UpdateTotalAmount>(_onUpdateTotalAmount);

    on<UpdateIsPaid>(_onUpdateIsPaid);

    on<UpdateOrderDate>(_onUpdateOrderDate);

  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading());

      // Load data from JSON
      final String response = await rootBundle.loadString('assets/dummy.json');
      final Map<String, dynamic> data = json.decode(response);

      // Parse categories and products
      allCategories = (data['categories'] as List)
          .map((category) => Category.fromJson(category))
          .toList();
      allProducts = (data['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList();

      emit(ProductLoaded(allProducts, allCategories));
    } catch (e) {
      emit(ProductError("Failed to load data: ${e.toString()}"));
    }
  }

  void _onFilterProductsByCategory(FilterProductsByCategory event, Emitter<ProductState> emit) {
    final filteredProducts = allProducts
        .where((product) =>
            event.category == 'All' || product.category == event.category)
        .toList();
    emit(ProductLoaded(filteredProducts, allCategories));
  }

void _onDetailsOfProduct(DetailsOfProduct event, Emitter<ProductState> emit) {

  final product = allProducts.firstWhere((product) => product.id == event.productId);
  emit(ProductDetails(product));
}


void _onAddToCart(AddToCart event, Emitter<ProductState> emit) {
  final product = allProducts.firstWhere((p) => p.id == event.productId);

  // Check if the product already exists in the cart
  final existingProduct = cartProducts.firstWhere(
    (p) => p.id == product.id,
    orElse: () => Product(
      id: '',
      name: '',
      category: '',
      price: 0,
      quantity: 0,
      unit: '',
    ),
  );

  if (existingProduct.id.isNotEmpty) {
    // Update quantity
    cartProducts = cartProducts.map((p) {
      if (p.id == product.id) {
        return p.copyWith(quantity: p.quantity + 1);
      }
      return p;
    }).toList();
  } else {
    // Add new product to the cart with specified quantity
    cartProducts.add(product.copyWith(quantity: 1));
  }

  emit(ProductLoaded(allProducts, allCategories)); // Emit ProductLoaded consistently
}

void _onRemoveFromCart(RemoveFromCart event, Emitter<ProductState> emit) {
  cartProducts.removeWhere((product) => product.id == event.productId); // Remove product
  emit(ProductLoaded(allProducts, allCategories)); // Emit ProductLoaded consistently
}


void _onUpdateTotalAmount(UpdateTotalAmount event, Emitter<ProductState> emit) {
  final totalAmount = cartProducts.fold(
    0.0,
    (sum, product) => sum + (product.price * product.quantity),
  );

  print('Total Amount: \$${totalAmount.toStringAsFixed(2)}');
  emit(ProductLoaded(allProducts, allCategories));
}

void _onUpdateQuantity(UpdateQuantity event, Emitter<ProductState> emit) {
  final product = allProducts.firstWhere((product) => product.id == event.productId);
  emit(ProductCart(cartProducts.map((product) {
    if (product.id == event.productId) {
      return product.copyWith(quantity: event.quantity);
    }
    return product;
  }).toList()));
}

void _onClearCart(ClearCart event, Emitter<ProductState> emit) {
  cartProducts.clear();
  emit(ProductLoaded(allProducts, allCategories));
}

void _onCheckout(Checkout event, Emitter<ProductState> emit) {
  emit(ProductCheckout(cartProducts));
}

void _onClearCheckout(ClearCheckout event, Emitter<ProductState> emit) {
  emit(ProductCart([]));
}

void _onUpdateShippingAddress(UpdateShippingAddress event, Emitter<ProductState> emit) {
  emit(ProductCart(cartProducts));
}

void _onUpdatePaymentMethod(UpdatePaymentMethod event, Emitter<ProductState> emit) {
  emit(ProductCart(cartProducts));
}

void _onUpdateOrderType(UpdateOrderType event, Emitter<ProductState> emit) {
  emit(ProductCart(cartProducts));
}

void _onUpdateCustomer(UpdateCustomer event, Emitter<ProductState> emit) {
  emit(ProductCart(cartProducts));
}

void _onUpdateIsPaid(UpdateIsPaid event, Emitter<ProductState> emit) {
  // TODO: Update isPaid
  emit(ProductCart(cartProducts));
}

void _onUpdateOrderDate(UpdateOrderDate event, Emitter<ProductState> emit) {
  // TODO: Update order date
  emit(ProductCart(cartProducts));
}

}