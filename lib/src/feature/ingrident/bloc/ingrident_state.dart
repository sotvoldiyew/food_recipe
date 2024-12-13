part of 'ingrident_bloc.dart';

class IngridentState extends Equatable {
  const IngridentState({
    this.isSaved = false,
    this.isFollow = false,
    this.isIngrident = true,
    this.isProcedure = false,
    this.status = Status.initial,
  });

  final Status status;
  final bool isIngrident;
  final bool isProcedure;
  final bool isFollow;
  final bool isSaved;

  @override
  List<Object?> get props => [isFollow, status, isIngrident, isProcedure, isSaved];

  IngridentState copyWith({
    final bool? isSaved,
    final bool? isFollow,
    final Status? status,
    final bool? isProcedure,
    final bool? isIngrident,
  }) =>
      IngridentState(
        isSaved: isSaved ?? this.isSaved,
        isFollow: isFollow ?? this.isFollow,
        status: status ?? this.status,
        isIngrident: isIngrident ?? this.isIngrident,
        isProcedure: isProcedure ?? this.isProcedure,
      );
}
