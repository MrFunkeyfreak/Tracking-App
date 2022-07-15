import 'package:bestfitnesstrackereu/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

// locator for navigation service

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
