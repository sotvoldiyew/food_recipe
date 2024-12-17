part of 'recipe_bloc.dart';

class RecipeState extends Equatable {
  const RecipeState({
    this.isSaved = false,
    this.status = Status.initial,
  });

  final bool isSaved;
  final Status status;

  @override
  List<Object?> get props => [isSaved, status];

  RecipeState copyWith({
    final Status? status,
    final bool? isSaved,
  }) =>
      RecipeState(
        status: status ?? this.status,
        isSaved: isSaved ?? this.isSaved,
      );
}
