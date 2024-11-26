part of 'create_bloc.dart';

sealed class CreateEvent {
  const CreateEvent();
}

class ImagePicker$CreateEvent extends CreateEvent {
  const ImagePicker$CreateEvent();
}

class AddIngrident$CreateEvent extends CreateEvent {
  const AddIngrident$CreateEvent();
}

class CategorySelecter$CreateEvent extends CreateEvent {
  const CategorySelecter$CreateEvent({required this.selectedCategory});

  final String selectedCategory;
}
