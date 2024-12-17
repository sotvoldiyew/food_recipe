import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';

import '../../../common/model/search_model.dart';
import '../../../common/utils/status_enum.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<SearchEvent>(
      (event, emit) => switch (event) {
        SearchRecipes$SearchEvent _ => _search(event, emit),
        GetRecipes$SearchEvent _ => _getRecentRecipes(event, emit),
        AddRecentRecipe$SearchEvent _ => _addRecentRecipe(event, emit),
      },
    );
  }

  Future<void> _search(
    SearchRecipes$SearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final recipes = await event.context.dependencies.searchRepository.searchRecipes(
      query: event.searchText,
    );

    log("Response [searchRecipes]: $recipes");

    if (event.searchText.isNotEmpty) {
      emit(state.copyWith(
        status: Status.success,
        searchText: event.searchText,
        recipes: recipes,
      ));
    } else {
      emit(state.copyWith(
        status: Status.success,
        searchText: "",
        recipes: [],
      ));
    }
  }

  Future<void> _getRecentRecipes(
    GetRecipes$SearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final userId = await event.context.dependencies.searchRepository.getUserId();

    final recipes = await event.context.dependencies.searchRepository.recentRecipes(
      userId: userId,
    );

    log("Response [getRecentRecipes]: $recipes");

    emit(state.copyWith(
      status: Status.success,
      recentRecipes: recipes,
      searchText: "",
      recipes: [],
    ));
  }

  Future<void> _addRecentRecipe(
    AddRecentRecipe$SearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final response = await event.context.dependencies.searchRepository.addRecentRecipe(
      id: event.id,
    );

    log("Response [addRecentRecipe]: $response");

    emit(state.copyWith(
      status: Status.success,
    ));
  }
}
