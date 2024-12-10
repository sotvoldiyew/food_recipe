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
      },
    );
  }

  Future<void> _search(
    SearchRecipes$SearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    List<SearchModel> recipes = [];

    final response = await event.context.dependencies.searchRepository.searchRecipes(
      query: event.searchText,
    );

    for (var recipe in response) {
      recipes.add(recipe);
    }

    log("Response [searchRecipes]: $response");

    if (event.searchText.isNotEmpty && response.isNotEmpty) {
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

    List<SearchModel> recipes = [];

    final response = await event.context.dependencies.searchRepository.recentRecipes(
      userId: 5,
    );

    log("Response [getRecentRecipes]: $response");

    for (var recipe in response) {
      recipes.add(recipe);
    }

    emit(state.copyWith(
      status: Status.success,
      recentRecipes: recipes,
    ));
  }
}
