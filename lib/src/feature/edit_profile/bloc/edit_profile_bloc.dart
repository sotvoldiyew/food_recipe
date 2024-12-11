import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/utils/status_enum.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileState()) {
    on<ImagePicker$EditProfileEvent>(_pickImage);
  }

  Future<void> _pickImage(
      ImagePicker$EditProfileEvent event,
      Emitter<EditProfileState> emit,
      ) async {
    try {
      final ImagePicker _picker  = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
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
}
