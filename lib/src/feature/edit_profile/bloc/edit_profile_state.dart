part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  EditProfileState({
    this.status = Status.initial,
    this.selectedImage,
    ImagePicker? picker,
  }) : picker = picker ?? ImagePicker();

  final Status status;
  final XFile? selectedImage;
  final ImagePicker picker;

  @override
  List<Object?> get props => [selectedImage, picker];

  EditProfileState copyWith({
    final Status? status,
    final XFile? selectedImage,
    final ImagePicker? picker,
}) => EditProfileState(
    status: status ?? this.status,
    picker: picker ?? this.picker,
    selectedImage: selectedImage ?? this.selectedImage,
  );

}
