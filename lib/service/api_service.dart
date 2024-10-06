import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/global/model/response_model.dart';
import 'package:car_wash/helper/local_db/local_db.dart';
import 'package:car_wash/helper/tost_message/show_snackbar.dart';
import 'package:car_wash/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final log = logger(ApiClient);

typedef ServerResponse<T> = Future<Either<ErrorResponseModel, T>>;

Map<String, String> basicHeaderInfo() {
  return {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
  };
}

Future<Map<String, String>> bearerHeaderInfo() async {
  DBHelper dbHelper = serviceLocator();
  final token = await dbHelper.getToken();
  Logger().e("Bearer $token");
  return {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: "Bearer $token",
  };
}

class ApiClient {
  //ApiMethod();
  // Get method
  Future get(
      {String? url,
      bool? isBasic,
      int code = 200,
      int duration = 15,
      bool showResult = false,
      BuildContext? context}) async {
    log.i(
        '|📍📍📍|----------------- [[ GET ]] method details start -----------------|📍📍📍|');
    log.i(url);
    log.i(
        '|📍📍📍|----------------- [[ GET ]] method details ended -----------------|📍📍📍|');

    try {
      final response = await http
          .get(
            Uri.parse(url!),
            headers: isBasic! ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));

      log.i(
          '|📒📒📒|-----------------[[ GET ]] method response start -----------------|📒📒📒|');

      if (showResult) {
        log.i(response.body.toString());
      }

      log.i(response.statusCode);

      log.i(
          '|📒📒📒|-----------------[[ GET ]] method response end -----------------|📒📒📒|');

      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        log.e('🐞🐞🐞 Error Alert On Status Code 🐞🐞🐞');
        log.e(
            'unknown error hitted in status code${jsonDecode(response.body)}');

        return jsonDecode(response.body);
      }
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      //showSnackBar(context!, 'Check your Internet Connection and try again!');
      //context.pushNamed(RoutePath.errorScreen);

      if (context != null && context.mounted) {
        showSnackBar(
            context: context,
            content: 'Check your Internet Connection and try again!');
        context.pushNamed(RoutePath.errorScreen);
      }
      return null;
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');

      log.e('Time out exception$url');

      if (context != null && context.mounted) {
        showSnackBar(
          context: context,
          content: 'Check your Internet Connection and try again!',
        );
        context.pushNamed(RoutePath.errorScreen);
      }

      return null;
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert Client Exception🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());
      if (context != null && context.mounted) {
        context.pushNamed(RoutePath.errorScreen);
      }
      return null;
    } catch (e) {
      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');

      log.e('❌❌❌ unlisted error received');

      log.e("❌❌❌ $e");
      if (context != null && context.mounted) {
        context.pushNamed(RoutePath.errorScreen);
      }
      return null;
    }
  }

  // Post Method
  Future<Response> post(
      {required String url,
      bool isBasic = false,
      Map<String, dynamic>? body,
      int duration = 30,
      bool showResult = true}) async {
    try {
      log.i(
          '|📍📍📍|-----------------[[ POST ]] method details start -----------------|📍📍📍|');

      log.i("URL => $url");

      log.i("Body => $body");

      log.i(
          '|📍📍📍|-----------------[[ POST ]] method details end ------------|📍📍📍|');

      final response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));

      log.i(
          '|📒📒📒|-----------------[[ POST ]] method response start ------------------|📒📒📒|');

      if (showResult) {
        log.i("response.body => ${response.body}");
      }

      log.i("response.statusCode => ${response.statusCode}");

      log.i(
          '|📒📒📒|-----------------[[ POST ]] method response end --------------------|📒📒📒|');

      body = jsonDecode(response.body);

      return Response(
        body: body ?? response.body,
        bodyString: response.body.toString(),
        request: Request(
            headers: response.request!.headers,
            method: response.request!.method,
            url: response.request!.url),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
      );
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return const Response(
          body: {},
          statusCode: 400,
          statusText: '🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');

      log.e('Time out exception$url');

      return Response(
          body: {}, statusCode: 400, statusText: 'Time out exception $url');
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert Client Exception🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());

      return Response(
          body: {},
          statusCode: 400,
          statusText: 'client exception hitted $url');
    } catch (e) {
      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');

      log.e('❌❌❌ unlisted error received');

      log.e("❌❌❌ $e");

      return const Response(
          body: {},
          statusCode: 400,
          statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞');
    }
  }

  Future<Response> patch(
      {required String url,
      bool isBasic = false,
      Map<String, dynamic>? body,
      int duration = 30,
      bool showResult = true}) async {
    try {
      log.i(
          '|📍📍📍|-----------------[[ PATCH ]] method details start -----------------|📍📍📍|');

      log.i("URL => $url");

      log.i("Body => $body");

      log.i(
          '|📍📍📍|-----------------[[ PATCH ]] method details end ------------|📍📍📍|');

      final response = await http
          .patch(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));

      log.i(
          '|📒📒📒|-----------------[[ PATCH ]] method response start ------------------|📒📒📒|');

      if (showResult) {
        log.i("response.body => ${response.body}");
      }

      log.i("response.statusCode => ${response.statusCode}");

      log.i(
          '|📒📒📒|-----------------[[ PATCH ]] method response end --------------------|📒📒📒|');

      body = jsonDecode(response.body);

      return Response(
        body: body ?? response.body,
        bodyString: response.body.toString(),
        request: Request(
            headers: response.request!.headers,
            method: response.request!.method,
            url: response.request!.url),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
      );
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return const Response(
          body: {},
          statusCode: 400,
          statusText: '🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');

      log.e('Time out exception$url');

      return Response(
          body: {}, statusCode: 400, statusText: 'Time out exception $url');
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert Client Exception🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());

      return Response(
          body: {},
          statusCode: 400,
          statusText: 'client exception hitted $url');
    } catch (e) {
      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');

      log.e('❌❌❌ unlisted error received');

      log.e("❌❌❌ $e");

      return const Response(
          body: {},
          statusCode: 400,
          statusText: '🐞🐞🐞 Other Error Alert 🐞🐞🐞');
    }
  }

  // Param get method
  Future<Map<String, dynamic>?> paramGet(
      {String? url,
      bool? isBasic,
      Map<String, String>? body,
      int code = 200,
      int duration = 15,
      bool showResult = false}) async {
    log.i(
        '|Get param📍📍📍|----------------- [[ GET ]] param method Details Start -----------------|📍📍📍|');

    log.i("##body given --> ");

    if (showResult) {
      log.i(body);
    }

    log.i("##url list --> $url");

    log.i(
        '|Get param📍📍📍|----------------- [[ GET ]] param method details ended ** ---------------|📍📍📍|');

    try {
      final response = await http
          .get(
            Uri.parse(url!).replace(queryParameters: body),
            headers: isBasic! ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(const Duration(seconds: 15));

      log.i(
          '|📒📒📒| ----------------[[ Get ]] Peram Response Start---------------|📒📒📒|');

      if (showResult) {
        log.i(response.body.toString());
      }

      log.i(
          '|📒📒📒| ----------------[[ Get ]] Peram Response End **-----------------|📒📒📒|');

      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');

        log.e(
            'unknown error hitted in status code  ${jsonDecode(response.body)}');

        return null;
      }
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return null;
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');

      log.e('Time out exception$url');

      return null;
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());

      return null;
    } catch (e) {
      log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');

      log.e('#url->$url||#body -> $body');

      log.e('❌❌❌ unlisted error received');

      log.e("❌❌❌ $e");

      return null;
    }
  }

  // Post Method
  // Post Method
  Future multipart(
      {String? url,
      bool? isBasic,
      Map<String, String>? body,
      String? filepath,
      String? filedName,
      int code = 200,
      bool showResult = false}) async {
    try {
      log.i(
          '|📍📍📍|-----------------[[ Multipart ]] method details start -----------------|📍📍📍|');

      log.i(url);

      log.i(body);
      log.i(filepath);

      log.i(
          '|📍📍📍|-----------------[[ Multipart ]] method details end ------------|📍📍📍|');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url!),
      )
        ..fields.addAll(body!)
        ..headers.addAll(
          isBasic! ? basicHeaderInfo() : await bearerHeaderInfo(),
        )
        ..files.add(await http.MultipartFile.fromPath(filedName!, filepath!));
      var response = await request.send();
      var jsonData = await http.Response.fromStream(response);

      log.i(
          '|📒📒📒|-----------------[[ POST ]] method response start ------------------|📒📒📒|');

      log.i(jsonData.body.toString());

      log.i(response.statusCode);

      log.i(
          '|📒📒📒|-----------------[[ POST ]] method response end --------------------|📒📒📒|');

      if (response.statusCode == code) {
        return jsonDecode(jsonData.body);
      } else {
        log.e('🐞🐞🐞 Error Alert On Status Code 🐞🐞🐞');

        log.e(
            'unknown error hitted in status code ${jsonDecode(jsonData.body)}');

        // CustomSnackBar.error(
        //     jsonDecode(response.body)['message']['error'].toString());
        return jsonDecode(jsonData.body);
      }
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return null;
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');

      log.e('Time out exception$url');

      return null;
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert Client Exception🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());

      return null;
    } catch (e) {
      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');

      log.e('❌❌❌ unlisted error received');

      log.e("❌❌❌ $e");

      return null;
    }
  }

  // multipart multi file Method
  Future<Map<String, dynamic>?> multipartMultiFile({
    String? url,
    bool? isBasic,
    Map<String, String>? body,
    int code = 200,
    bool showResult = false,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {
    try {
      log.i(
          '|📍📍📍|-----------------[[ Multipart ]] method details start -----------------|📍📍📍|');

      log.i(url);

      if (showResult) {
        log.i(body);
        log.i(pathList);
        log.i(fieldList);
      }

      log.i(
          '|📍📍📍|-----------------[[ Multipart ]] method details end ------------|📍📍📍|');
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url!),
      )
        ..fields.addAll(body!)
        ..headers.addAll(
          isBasic! ? basicHeaderInfo() : await bearerHeaderInfo(),
        );

      for (int i = 0; i < fieldList.length; i++) {
        request.files
            .add(await http.MultipartFile.fromPath(fieldList[i], pathList[i]));
      }

      var response = await request.send();
      var jsonData = await http.Response.fromStream(response);

      log.i(
          '|📒📒📒|-----------------[[ POST ]] method response start ------------------|📒📒📒|');

      log.i(jsonData.body.toString());

      log.i(response.statusCode);

      log.i(
          '|📒📒📒|-----------------[[ POST ]] method response end --------------------|📒📒📒|');

      if (response.statusCode == code) {
        return jsonDecode(jsonData.body) as Map<String, dynamic>;
      } else {
        log.e('🐞🐞🐞 Error Alert On Status Code 🐞🐞🐞');

        log.e(
            'unknown error hitted in status code ${jsonDecode(jsonData.body)}');

        // CustomSnackBar.error(
        //     jsonDecode(response.body)['message']['error'].toString());
        return null;
      }
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return null;
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');

      log.e('Time out exception$url');

      return null;
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert Client Exception🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());

      return null;
    } catch (e) {
      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');

      log.e('❌❌❌ unlisted error received');

      log.e("❌❌❌ $e");

      return null;
    }
  }

  // Delete method
  Future<Map<String, dynamic>?> delete(
      {String? url,
      bool? isBasic,
      int code = 202,
      bool isLogout = false,
      int duration = 15,
      bool showResult = false}) async {
    log.i(
        '|📍📍📍|-----------------[[ DELETE ]] method details start-----------------|📍📍📍|');

    log.i(url);

    log.i(
        '|📍📍📍|-----------------[[ DELETE ]] method details end ------------------|📍📍📍|');

    try {
      var headers = isBasic! ? basicHeaderInfo() : await bearerHeaderInfo();

      if (isLogout) {
// headers

// ..addAll({"fcm_token": await FirebaseMessaging.instance.getToken()});
      }

      log.i(headers);

      final response = await http
          .delete(
            Uri.parse(url!),
            headers: headers,
          )
          .timeout(Duration(seconds: duration));

      log.i(
          '|📒📒📒|----------------- [[ DELETE ]] method response start-----------------|📒📒📒|');

      if (showResult) {
        log.i(response.body.toString());
      }

      log.i(response.statusCode);

      log.i(
          '|📒📒📒|----------------- [[ DELETE ]] method response start-----------------|📒📒📒|');

      if (response.statusCode == code) {
// LocalStorage.clear();

        return jsonDecode(response.body);
      } else {
        log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');

        log.e(
            'unknown error hitted in status code  ${jsonDecode(response.body)}');

        return null;
      }
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return null;
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');

      log.e('Time out exception$url');

      return null;
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());

      return null;
    } catch (e) {
      log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');

      log.e('❌❌❌ unlisted error received');

      log.e("❌❌❌ $e");

      return null;
    }
  }

  Future<Map<String, dynamic>?> put(
      {String? url,
      bool? isBasic,
      Map<String, dynamic>? body,
      int code = 202,
      int duration = 15,
      bool showResult = false}) async {
    try {
      log.i(
          '|📍📍📍|-------------[[ PUT ]] method details start-----------------|📍📍📍|');

      log.i(url);

      log.i(body);

      log.i(
          '|📍📍📍|-------------[[ PUT ]] method details end ------------|📍📍📍|');

      final response = await http
          .put(
            Uri.parse(url!),
            body: jsonEncode(body),
            headers: isBasic! ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));

      log.i(
          '|📒📒📒|-----------------[[ PUT ]] AKA Update method response start-----------------|📒📒📒|');

      if (showResult) {
        log.i(response.body);
      }

      log.i(response.statusCode);

      log.i(
          '|📒📒📒|-----------------[[ PUT ]] AKA Update method response End -----------------|📒📒📒|');

      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');

        log.e(
            'unknown error hitted in status code  ${jsonDecode(response.body)}');

        return null;
      }
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return null;
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');

      log.e('Time out exception$url');

      return null;
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());

      return null;
    } catch (e) {
      log.e('🐞🐞🐞 Error Alert 🐞🐞🐞');

      log.e('unlisted catch error received');

      log.e(e.toString());

      return null;
    }
  }

  Future<Map<String, dynamic>?> multipartKYC({
    String? url,
    bool? isBasic,
    int code = 200,
    bool showResult = false,
    required String fontPath,
    required String backPath,
  }) async {
    try {
      log.i(
          '|📍📍📍|-----------------[[ Multipart ]] method details start -----------------|📍📍📍|');

      log.i(url);

      log.i(fontPath);
      log.i(backPath);

      log.i(
          '|📍📍📍|-----------------[[ Multipart ]] method details end ------------|📍📍📍|');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url!),
      )
        ..headers.addAll(
          isBasic! ? basicHeaderInfo() : await bearerHeaderInfo(),
        )
        ..files.add(await http.MultipartFile.fromPath('id_back_part', fontPath))
        ..files
            .add(await http.MultipartFile.fromPath('id_front_part', backPath));
      var response = await request.send();
      var jsonData = await http.Response.fromStream(response);

      log.i(
          '|📒📒📒|-----------------[[ POST ]] method response start ------------------|📒📒📒|');

      log.i(jsonData.body.toString());

      log.i(response.statusCode);

      log.i(
          '|📒📒📒|-----------------[[ POST ]] method response end --------------------|📒📒📒|');

      if (response.statusCode == code) {
        return jsonDecode(jsonData.body) as Map<String, dynamic>;
      } else {
        log.e('🐞🐞🐞 Error Alert On Status Code 🐞🐞🐞');

        log.e(
            'unknown error hitted in status code ${jsonDecode(jsonData.body)}');
        return null;
      }
    } on SocketException {
      log.e('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      return null;
    } on TimeoutException {
      log.e('🐞🐞🐞 Error Alert Timeout Exception🐞🐞🐞');

      log.e('Time out exception$url');

      return null;
    } on http.ClientException catch (err, stackrace) {
      log.e('🐞🐞🐞 Error Alert Client Exception🐞🐞🐞');

      log.e('client exception hitted');

      log.e(err.toString());

      log.e(stackrace.toString());

      return null;
    } catch (e) {
      log.e('🐞🐞🐞 Other Error Alert 🐞🐞🐞');

      log.e('❌❌❌ unlisted error received');

      log.e("❌❌❌ $e");

      return null;
    }
  }
}
