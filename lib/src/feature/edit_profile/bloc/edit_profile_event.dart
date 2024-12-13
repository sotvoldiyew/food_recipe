part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent {
 const EditProfileEvent();
}

class ImagePicker$EditProfileEvent extends EditProfileEvent{
 final BuildContext context;

 const ImagePicker$EditProfileEvent({required this.context});
}