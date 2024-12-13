part of 'profile_bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();
}

class ViewMore$ProfileEvent extends ProfileEvent {
  const ViewMore$ProfileEvent({
    required this.text,
    required this.maxWidth,
    required this.style,
  });

  final String text;
  final double maxWidth;
  final TextStyle style;
}

 class UpdateText$ProfileEvent extends ProfileEvent{
 const UpdateText$ProfileEvent();
 }