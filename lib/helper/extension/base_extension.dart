import 'package:car_wash/core/routes/route_path.dart';

extension BasePathExtensions on String {
  String get addBasePath {
    return RoutePath.basePath + this;
  }
}
