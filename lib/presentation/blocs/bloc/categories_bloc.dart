import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:haron_pos/data/model/category.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CategoriesLoaded>((event, emit) {
      emit(CategoriesLoadedState(categories: event.categories));
    });

    on<CategoriesErrorEvent>((event, emit) {
      emit(CategoriesError(error: event.error));
    });

    on<LoadCategories>(_onLoadCategories);
  }

  Future<void> _onLoadCategories(LoadCategories event, Emitter<CategoriesState> emit) async {
    try {
      emit(CategoriesLoading());

      // Load data from JSON
      final String response = await rootBundle.loadString('assets/dummy.json');
      final Map<String, dynamic> data = json.decode(response);

      // Parse categories
      final List<Category> categories = (data['categories'] as List)
          .map((category) => Category.fromJson(category))
          .toList();

      emit(CategoriesLoadedState(categories: categories));
    } catch (e) {
      emit(CategoriesError(error: "Failed to load data: ${e.toString()}"));
    }
}
}
