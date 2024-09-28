import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_template/api/logger_interceptor.dart';
import 'package:flutter_template/api/preferences/shared_preferences_helper.dart';
import 'package:flutter_template/modules/vehicle_details_view/model/add_vehicle_model.dart';
import 'package:flutter_template/modules/vehicle_details_view/model/my_vehicle_model.dart';
import 'package:flutter_template/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/constants.dart';

Map<String, String> headers() {
  final Map<String, String> headers = <String, String>{};
  headers["accept"] = "*/*";
  log("user token :: ${SharedPreferencesHelper.instance.getUserToken()}");
  if (SharedPreferencesHelper.instance.getUserToken()?.isNotEmpty ?? false) {
    ///remove after test
    String token =
        "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaWF0IjoxNzI2ODM1MTk3LCJleHAiOjE3Mjc0Mzk5OTd9.QC8sQqIWJF9G_B1b1nTQXCjgF4ZpaZTajWH9tNxmD0XDmV9jiyUbBbfSRDCRCdXUHsrO3pcxYJDUP9hY9ERDEA";
    /* headers["Authorization"] = token;*/
    headers["Authorization"] = '${SharedPreferencesHelper.instance.getUserToken()}';
    log("headers ::: $headers");
  }
  return headers;
}

Map<String, String> contentHeader() {
  final Map<String, String> headers = <String, String>{};
  headers["accept"] = "*/*";
  headers["Content-Type"] = "application/json";
  log("user token :: ${SharedPreferencesHelper.instance.getUserToken()}");
  if (SharedPreferencesHelper.instance.getUserToken()?.isNotEmpty ?? false) {
    headers["Authorization"] = '${SharedPreferencesHelper.instance.getUserToken()}';
    log("headers ::: $headers");
  }
  return headers;
}

class Api {
  static Api? _instance;

  static http.Client get dio => InterceptedClient.build(
        interceptors: [
          LoggerInterceptor(),
        ],
      );

  factory Api() {
    if (_instance == null) {
      _instance = Api._();
      return _instance!;
    } else {
      return _instance!;
    }
  }

  Api._();

  Future<http.Response> post({
    required String url,
    Map<String, dynamic>? queryData,
    Map<String, dynamic>? bodyData,
  }) async {
    log("post ${await headers()}}");
    log("post url::::: ${getUrl(url, queryParameters: queryData)}");
    final response = await dio.post(
      getUrl(url, queryParameters: queryData),
      body: jsonEncode(bodyData),
      headers: queryData == null ? contentHeader() : headers(),
    );
    print("response $response");
    return response;
  }

  Future<http.Response> put(
    String url, {
    Map<String, dynamic>? queryData,
    Map<String, dynamic>? bodyData,
  }) async {
    log("put ${await headers()}}");
    final response =
        await dio.put(getUrl(url, queryParameters: queryData), body: jsonEncode(bodyData), headers: queryData == null ? contentHeader() : headers());
    return response;
  }

  Future<http.Response> patch(
    String url, {
    Map<String, dynamic>? queryData,
    Map<String, dynamic>? bodyData,
  }) async {
    final response = await dio.patch(getUrl(url, queryParameters: queryData),
        body: jsonEncode(bodyData), headers: queryData == null ? contentHeader() : headers());
    return response;
  }

  Future<http.Response> delete(
    String url, {
    Map<String, dynamic>? queryData,
    Map<String, dynamic>? bodyData,
  }) async {
    final response = await dio.delete(getUrl(url, queryParameters: queryData), body: jsonEncode(bodyData), headers: headers());
    return response;
  }

  Future<http.Response> head(
    String url, {
    Map<String, dynamic>? queryData,
  }) async {
    final response = await dio.head(
      getUrl(url, queryParameters: queryData),
      headers: headers(),
    );
    return response;
  }

  Future<http.Response> get(
    String url, {
    Map<String, dynamic>? queryData,
  }) async {
    log("get ${headers()}}");
    final response = await dio.get(
      getUrl(url, queryParameters: queryData),
      headers: contentHeader(),
    );
    return response;
  }

  Future<String?> multiPartRequestAddVehicle(String endpoint, {required MyVehicleData addProfileFormData, String? imagePath}) async {
    try {
      var headers = {'accept': '*/*', 'Authorization': '${SharedPreferencesHelper.instance.getUserToken()}'};
      var request = http.MultipartRequest('POST', Uri.parse('http://103.206.139.86:8070/vehicle/'));
      final body = {
        'fuelType': "${addProfileFormData.fuelType}",
        'transmissionType': "${addProfileFormData.transmissionType}",
        'vehicleMake': "${addProfileFormData.vehicleMake}",
        'vehicleModel': "${addProfileFormData.vehicleModel}",
        'vehicleNumber': "${addProfileFormData.vehicleNumber}",
        'vehicleYear': "${addProfileFormData.vehicleYear}",
      };
      request.fields.addAll(body);
      if (imagePath?.isNotEmpty ?? false) {
        request.files.add(await http.MultipartFile.fromPath('photo', imagePath ?? ""));
      }

      request.headers.addAll(headers);
      http.Response response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      log("response ${response.body}");
    } catch (e, st) {
      log('multiPartRequest Error :: $e ::: $st');
    }
    return null;
  }

  Future<String?> multiPartRequestEditVehicle(String endpoint,
      {required MyVehicleData editProfileFormData, String? imagePath}) async {
    try {
      var headers = {
        'accept': '*/*',
        'Authorization': '${SharedPreferencesHelper.instance.getUserToken()}'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('http://103.206.139.86:8070/moreaboutvehicle/update'));
      final body = {
        'fuelType': "${editProfileFormData.fuelType}",
        'transmissionType': "${editProfileFormData.transmissionType}",
        'vehicleId': "${editProfileFormData.id}",
        'vehicleMake': "${editProfileFormData.vehicleMake}",
        'vehicleModel': "${editProfileFormData.vehicleModel}",
        'vehicleNumber': "${editProfileFormData.vehicleNumber}",
        'vehicleYear': "${editProfileFormData.vehicleYear}",
        'moreAboutVehicle[0].answer\n': '',
        'moreAboutVehicle[0].id\n': '',
        'moreAboutVehicle[0].question\n': ''
      };
      request.fields.addAll(body);
      if (imagePath?.isNotEmpty ?? false) {
        request.files
            .add(await http.MultipartFile.fromPath('photo', imagePath ?? ""));
      }

      request.headers.addAll(headers);
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      log("response ${response.body}");
    } catch (e, st) {
      log('multiPartRequest Error :: $e ::: $st');
    }
    return null;
  }

  Future multiPartRequestUserData({
    required String endPoint,
    required String email,
    required String firstName,
    required String lastName,
    required String postCode,
    required String imagePath,
  }) async {
    try {
      var headers = {'accept': '*/*', 'Authorization': '${SharedPreferencesHelper.instance.getUserToken()}'};
      var request = http.MultipartRequest('POST', Uri.parse('${ApiConstants.baseUrl}$endPoint'));
      final body = {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'postCode': postCode,
      };

      request.files.add(await http.MultipartFile.fromPath('photo', imagePath));

      request.fields.addAll(body);
      request.headers.addAll(headers);

      http.Response response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        print(response);
        return response.body;
      }
    } catch (e, st) {
      log('multiPartRequest Error :: $e ::: $st');
    }
    return null;
  }

  Future multiPartRequestUpdateUserData({
    required String email,
    required int id,
    required String firstName,
    required String lastName,
    required String postCode,
    required String imagePath,
  }) async {
    // var headers = {
    //   'accept': '*/*',
    //   'Authorization': '${SharedPreferencesHelper.instance.getUserToken()}'
    // };
    // var request = http.MultipartRequest('POST', Uri.parse('http://103.206.139.86:8070/user/update'));
    // request.fields.addAll({
    //   'email': 'xrstudio.dev@gmail.com',
    //   'firstName': 'dc',
    //   'id': '2',
    //   'lastName': 'demo',
    //   'postCode': '123456'
    // });
    // request.files.add(await http.MultipartFile.fromPath('photo', '/data/user/0/com.vehicle.diagnostic/cache/7e13c3c2-e1ce-4fe3-8a38-fef73e696ac6/1000001663.jpg'));
    // request.headers.addAll(headers);
    //
    // http.StreamedResponse response = await request.send();
    //
    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // }
    // else {
    //   print(response.reasonPhrase);
    // }

    try {
      var headers = {
        'accept': '*/*',
        'Authorization': '${SharedPreferencesHelper.instance.getUserToken()}'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://103.206.139.86:8070/user/update'));
      request.fields.addAll({
        'email': email,
        'firstName': firstName,
        'id': id.toString(),
        'lastName': lastName,
        'postCode': postCode,
      });

      if (imagePath.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('photo', imagePath));
      }

      request.headers.addAll(headers);

      http.Response response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        print(response);
        log("imagePath ::${imagePath}");
        print("response ::${response.body}");
        return response.body;
      }
    } catch (e, st) {
      log('multiPartRequest Error :: $e ::: $st');
    }
    return null;
  }
}

Uri getUrl(String endpoint, {Map<String, dynamic>? queryParameters}) {
  String url = "${ApiConstants.baseUrl}$endpoint";
  if (queryParameters != null && queryParameters.isNotEmpty) {
    url = "$url?";
    for (int i = 0; i < queryParameters.entries.length; i++) {
      final element = queryParameters.entries.elementAt(i);
      url += '${element.key}=${element.value}';
      if (i < queryParameters.entries.length - 1) {
        url += '&';
      }
    }
  }
  log(Uri.parse(url).toString());
  return Uri.parse(url);
}

Uri parseUrl(String url) {
  log(Uri.parse(url).toString());
  return Uri.parse(url);
}
