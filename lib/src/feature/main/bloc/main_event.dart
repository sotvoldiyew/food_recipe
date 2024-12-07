part of 'main_bloc.dart';

sealed class MainEvent {
  const MainEvent();
}

final class GetAllData$MainEvent extends MainEvent {
  final BuildContext context;

  const GetAllData$MainEvent({required this.context});
}

final class GetRecipesByCategory$MainEvent extends MainEvent {
  final BuildContext context;
  final int category;

  const GetRecipesByCategory$MainEvent({
    required this.context,
    required this.category,
  });
}
