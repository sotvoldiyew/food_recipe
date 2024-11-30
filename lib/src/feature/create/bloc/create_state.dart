part of 'create_bloc.dart';

class CreateState extends Equatable {
  CreateState({
    this.categories = const ["Appetizer", "Main Course", "Dessert", "Beverage"],
    this.ingredientControllers = const [],
    this.selectedCategory,
    this.status = Status.initial,
    this.selectedImage,
    ImagePicker? picker,
  }) : picker = picker ?? ImagePicker();

  final List<String> categories; // Kategoriyalar ro‘yxati
  final List<TextEditingController> ingredientControllers; // Ingredient controllerlari
  final String? selectedCategory; // Tanlangan kategoriya
  final Status status; // Holat
  final XFile? selectedImage; // Tanlangan rasm
  final ImagePicker picker; // Rasm tanlash uchun obyekt

  @override
  List<Object?> get props => [
    categories,
    ingredientControllers,
    selectedCategory,
    status,
    selectedImage,
    picker,
  ];

  CreateState copyWith({
    List<String>? categories,
    List<TextEditingController>? ingredientControllers,
    String? selectedCategory,
    Status? status,
    XFile? selectedImage,
    ImagePicker? picker,
  }) {
    return CreateState(
      categories: categories ?? this.categories,
      ingredientControllers:
      ingredientControllers ?? this.ingredientControllers,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      status: status ?? this.status,
      selectedImage: selectedImage ?? this.selectedImage,
      picker: picker ?? this.picker,
    );
  }
}
