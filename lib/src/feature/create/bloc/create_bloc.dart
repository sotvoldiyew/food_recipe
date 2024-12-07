import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/utils/status_enum.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(CreateState()) {
    on<ImagePicker$CreateEvent>(_pickImage);
    on<CategorySelecter$CreateEvent>(_selectCategory);
  }

  Future<void> _pickImage(
    ImagePicker$CreateEvent event,
    Emitter<CreateState> emit,
  ) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        emit(state.copyWith(
          status: Status.success,
          selectedImage: image,
        ));
      } else {
        emit(state.copyWith(
          status: Status.error,
        ));
      }
    } catch (e) {
      log('Rasm tanlashda xatolik: $e');
      emit(state.copyWith(
        status: Status.error,
      ));
    }
  }

  Future<void> _selectCategory(
    CategorySelecter$CreateEvent event,
    Emitter<CreateState> emit,
  ) async {
    try {
      if (event.selectedCategory.isNotEmpty && state.categories.contains(event.selectedCategory)) {
        emit(state.copyWith(
          status: Status.success,
          selectedCategory: event.selectedCategory,
        ));
      } else {
        emit(state.copyWith(
          status: Status.error,
        ));
      }
    } catch (e) {
      log('Kategoriya tanlashda xatolik: $e');
      emit(state.copyWith(
        status: Status.error,
      ));
    }
  }
}
