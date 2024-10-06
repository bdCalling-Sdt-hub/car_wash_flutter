import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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

extension HeightWidthExt on int {
  Widget get heightWidth {
    return Gap(toDouble());
  }
}
