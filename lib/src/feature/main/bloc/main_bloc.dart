import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_recipe/src/common/model/category_model.dart';
import 'package:food_recipe/src/common/model/recipe_model.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';

import '../../../common/utils/status_enum.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<MainEvent>(
      (event, emit) => switch (event) {
        GetAllData$MainEvent _ => _getAllData(event, emit),
        GetRecipesByCategory$MainEvent _ => _getByCategory(event, emit),
      },
    );
  }

  Future<void> _getAllData(
    GetAllData$MainEvent event,
    Emitter<MainState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final categories = await event.context.dependencies.mainRepository.getCategories();

    final newRecipes = await event.context.dependencies.mainRepository.getRecipes(
      data: {
        "size": 10,
        "page": 0,
      },
    );

    final recipes = await event.context.dependencies.mainRepository.getRecipeByCategory(
      id: state.selectedCategoryId,
      data: {
        "size": 10,
        "page": 0,
      },
    );

    log("Response [getCategories]: $categories");
    log("Response [getRecipes]: $newRecipes");

    emit(state.copyWith(
      status: Status.success,
      categories: categories,
      newRecipes: newRecipes,
      recipes: recipes,
    ));
  }

  Future<void> _getByCategory(
    GetRecipesByCategory$MainEvent event,
    Emitter<MainState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final recipes = await event.context.dependencies.mainRepository.getRecipeByCategory(
      id: event.category,
      data: {
        "size": 10,
        "page": 0,
      },
    );

    log("Response [getRecipeByCategory]: $recipes");

    emit(state.copyWith(
      status: Status.success,
      recipes: recipes,
      selectedCategoryId: event.category,
    ));
  }
}
