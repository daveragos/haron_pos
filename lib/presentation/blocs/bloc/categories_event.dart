part of 'categories_bloc.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}


class LoadCategories extends CategoriesEvent {
  const LoadCategories();

  @override
  List<Object> get props => [];
}

class CategoriesLoaded extends CategoriesEvent {
  const CategoriesLoaded({required this.categories});
  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}

class CategoriesErrorEvent extends CategoriesEvent {
  const CategoriesErrorEvent({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}


