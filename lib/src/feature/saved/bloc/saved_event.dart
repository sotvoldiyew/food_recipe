part of 'saved_bloc.dart';

sealed class SavedEvent{
 const SavedEvent();
}

class SaveButton$Savedevent extends SavedEvent{
  const SaveButton$Savedevent();
}