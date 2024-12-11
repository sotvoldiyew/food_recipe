part of 'ingredient_bloc.dart';

class IngredientState extends Equatable {
  const IngredientState({
    this.isSaved = false,
    this.isFollow = false,
    this.isIngredient = true,
    this.isProcedure = false,
    this.status = Status.initial,
  });

  final Status status;
  final bool isIngredient;
  final bool isProcedure;
  final bool isFollow;
  final bool isSaved;

  @override
  List<Object?> get props => [
        isFollow,
        status,
        isIngredient,
        isProcedure,
        isSaved,
      ];

  IngredientState copyWith({
    final bool? isSaved,
    final bool? isFollow,
    final Status? status,
    final bool? isProcedure,
    final bool? isIngredient,
  }) =>
      IngredientState(
        isSaved: isSaved ?? this.isSaved,
        isFollow: isFollow ?? this.isFollow,
        status: status ?? this.status,
        isIngredient: isIngredient ?? this.isIngredient,
        isProcedure: isProcedure ?? this.isProcedure,
      );
}
