part of 'saved_bloc.dart';

class SavedState extends Equatable {
  SavedState({this.isSaved = false, this.status = Status.initial, });

  final bool isSaved;
  final Status status;

  @override
  List<Object?> get props => [isSaved];

  SavedState copyWith({
    final Status? status,
    final bool? isSaved,
}) => SavedState(
    status: status ?? this.status,
    isSaved: isSaved ?? this.isSaved,
  );
}