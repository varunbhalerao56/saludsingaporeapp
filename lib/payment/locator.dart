import 'package:cloud_functions/cloud_functions.dart';
import 'package:get_it/get_it.dart';

import 'network/network_service.dart';

const _cloudFunctionsRegion = "asia-east2";

GetIt locator = GetIt();

void initializeLocator() {
  locator.registerLazySingleton(
      () => CloudFunctions(region: _cloudFunctionsRegion));
  locator.registerLazySingleton(() => NetworkService(locator.get()));
}
