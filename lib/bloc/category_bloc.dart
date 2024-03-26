import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mda/models/search.dart';
import 'package:mda/repositories/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInit()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  void _onSelectCategory(event, emit) {
    if (state is CategoryLoaded) {
      final category = event.category;
      final isSelected = event.isSelected;

      final List<Category> categories = (state as CategoryLoaded).categories;
      final updatedCategories = categories.map((e) {
        return (e.alias == category.alias)
            ? e.copyWith(isSelected: isSelected)
            : e;
      }).toList();

      emit(CategoryLoaded(updatedCategories));
    }
  }

  void _onLoadCategories(event, emit) async {
    emit(CategoryLoading());

    var categories = await CategoryRepository.getCategories();

    /// Wait for 0.5 to create a loading effect
    await Future.delayed(const Duration(milliseconds: 500), () {
      emit(CategoryLoaded(categories));
    });
  }
}

abstract class CategoryEvent {}

class LoadCategoriesEvent extends CategoryEvent {}

class SelectCategoryEvent extends CategoryEvent {
  final Category category;
  final bool isSelected;

  SelectCategoryEvent(this.category, this.isSelected);
}

@immutable
abstract class CategoryState {}

class CategoryInit extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}
