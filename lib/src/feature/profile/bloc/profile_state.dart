part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.text = "" ,
    this.isExpanded = false,
    this.status = Status.initial,
  });

  final bool isExpanded;
  final Status status;
  final String text;

  @override
  List<Object?> get props => [isExpanded, status, text];

  ProfileState copyWith({
    final String? text,
    final bool? isExpanded,
    final Status? status,
  }) =>
      ProfileState(
        text:  text ?? this.text,
        status: status ?? this.status,
        isExpanded: isExpanded ?? this.isExpanded,
      );
}
