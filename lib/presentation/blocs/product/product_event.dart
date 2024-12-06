// product_event.dart
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class FilterProductsByCategory extends ProductEvent {
  final String category;

  FilterProductsByCategory(this.category);

  @override
  List<Object> get props => [category];
}
