import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/service/api_url.dart';

extension RouteBasePathExt on String {
  String get addBasePath {
    return RoutePath.basePath + this;
  }
}

extension ApiBasePathExt on String {
  String get addBaseUrl {
    return ApiUrl.baseUrl + this;
  }
}
