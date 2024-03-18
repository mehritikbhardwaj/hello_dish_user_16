// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hello_dish_app/screens/authentication/login/model/loginResponseModel.dart';
import 'package:hello_dish_app/screens/cart/model/order_model.dart';
import 'package:hello_dish_app/screens/home/models/create_order_model.dart';
import 'package:hello_dish_app/screens/home/models/locationModel.dart';
import 'package:hello_dish_app/screens/home/models/offersModel.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as fileUtil;

import '../../screens/home/models/homeModel.dart';
import '../../screens/home/models/restaurentDetails.dart';

typedef OnDownloadProgressCallback = void Function(
    int receivedBytes, int totalBytes);
typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);

class HTTPClient {
  static Future<Map<String, dynamic>> postRequest(String api, Map params,
      {String type = "raw"}) async {
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);
    final url = Uri.parse(api);
    final http.Response res;

    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("url: $url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    Get.log("params: $params");

    res = await http
        .post(url, body: type == "raw" ? jsonEncode(params) : params, headers: {
      // 'apiusername': APIs.apiUserName,
      // 'apipassword': APIs.apipassword,
      'Content-type': type == "raw"
          ? 'application/json'
          : "application/x-www-form-urlencoded",
    });

    // Get.log("userId $userid");
    // Get.log("userId  $sCode");

    final Map<String, dynamic> json = await jsonDecode(res.body);
    Get.log(
        "-------------------------------------------- RESPONSE --------------------------------------------");

    Get.log(" Response api $json");
    Get.log(
        "========================================================================================================");
    return json;
  }

  static Future<Map<String, dynamic>> putRequest(String api, Map params,
      {String type = "raw"}) async {
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);
    final url = Uri.parse(api);
    final http.Response res;

    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("url: $url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    Get.log("params: $params");
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)! ?? "";

    res = await http
        .put(url, body: type == "raw" ? jsonEncode(params) : params, headers: {
      // 'apiusername': APIs.apiUserName,
      // 'apipassword': APIs.apipassword,
      'Authorization': 'Bearer $token',

      'Content-type': type == "raw"
          ? 'application/json'
          : "application/x-www-form-urlencoded",
    });

    //Get.log("userId " "");
    // Get.log("userId  $sCode");

    final Map<String, dynamic> json = await jsonDecode(res.body);
    Get.log(
        "-------------------------------------------- RESPONSE --------------------------------------------");

    Get.log(" Response api $json");
    Get.log(
        "========================================================================================================");
    return json;
  }

  static bool trustSelfSigned = true;

  static HttpClient getHttpClient() {
    HttpClient httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 100);
    // ..badCertificateCallback =
    //     ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  static Future<Map<String, dynamic>> postRequestCoordinates(
    String api,
  ) async {
    final url = Uri.parse(api);
    final http.Response res;

    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("$url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");

    res = await http.post(
      url,
    );

    final Map<String, dynamic> json = await jsonDecode(res.body);
    Get.log(
        "-------------------------------------------- RESPONSE --------------------------------------------");

    Get.log("$json");
    Get.log(
        "========================================================================================================");
    return json;
  }

  static Future<Map<String, dynamic>> multipartRequest(
      String api,
      Map params,
      String imgPath,
      //  XFile file,
      MediaType mediaType,
      bool isComingForWatermark) async {
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);
    final url = Uri.parse(api);
    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("$url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    Get.log("$params");

    //final length = await file.length();

    final request = http.MultipartRequest("POST", url);
    // request.headers["apiusername"] = APIs.apiUserName;
    // request.headers["apipassword"] = APIs.apipassword;
    // request.headers["Content-type"] = "multipart/form-data";
    // request.headers["uid"] = userid.toString();
    // request.headers["scode"] = sCode.toString();

    // if (isComingForWatermark) {
    //   request.fields["loc"] = params["loc"];
    //   request.fields["width"] = params["width"];
    //   request.fields["oldfile"] = params["oldfile"];
    // }

    // request.files.add(http.MultipartFile(
    //     'file', file.readAsBytes().asStream(), length,
    //     filename: file.name, contentType: mediaType));
    final streamRes = await request.send();
    final res = await http.Response.fromStream(streamRes);
    final Map<String, dynamic> json = await jsonDecode(res.body);
    return json;
  }

  static Future<Map<String, dynamic>> multipartWithoutFileRequest(
    String api,
    Map params,
  ) async {
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);
    final url = Uri.parse(api);
    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("$url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    Get.log("$params");

    final request = http.MultipartRequest("POST", url);
    // request.headers["apiusername"] = APIs.apiUserName;
    // request.headers["apipassword"] = APIs.apipassword;
    // request.headers["Content-type"] = "multipart/form-data";
    // request.headers["uid"] = userid.toString();
    // request.headers["scode"] = sCode.toString();

    request.fields["loc"] = params["loc"];
    request.fields["width"] = params["width"];
    request.fields["oldfile"] = params["oldfile"];

    final streamRes = await request.send();
    final res = await http.Response.fromStream(streamRes);
    final Map<String, dynamic> json = await jsonDecode(res.body);
    Get.log("response $json");

    return json;
  }

  static Future<Map<String, dynamic>> multipartUploadAPicRequest(
    String api,
    Map params,
    String imgPath,
    // XFile file,
    MediaType mediaType,
  ) async {
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);
    final url = Uri.parse(api);
    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("$url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    Get.log("$params");

    // final length = await file.length();

    final request = http.MultipartRequest("POST", url);
    // request.headers["apiusername"] = APIs.apiUserName;
    // request.headers["apipassword"] = APIs.apipassword;
    // request.headers["Content-type"] = "multipart/form-data";
    // request.headers["uid"] = userid.toString();
    // request.headers["scode"] = sCode.toString();

    request.fields["typeofimport"] = "0";
    request.fields["albumid"] = params["albumid"];
    request.fields["datetime"] = params["datetime"];
    request.fields["angle"] = params["angle"];
    request.fields["geokey"] = params["geokey"];

    // request.files.add(http.MultipartFile(
    //     'file', file.readAsBytes().asStream(), length,
    //     filename: imgPath, contentType: mediaType));
    final streamRes = await request.send();

    final res = await http.Response.fromStream(streamRes);

    final Map<String, dynamic> json = await jsonDecode(res.body);
    return json;
  }

  static Future<String> fileUploadMultipart(
      {String? api,
      Map<String, dynamic>? params,
      required MediaType? mediaType,
      File? file,
      OnUploadProgressCallback? onUploadProgress,
      Function(int)? fileUploaded}) async {
    assert(file != null);
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);

    final url = Uri.parse(api!);

    final httpClient = HttpClient(); //getHttpClient();

    final request = await httpClient.postUrl(Uri.parse(api));

    int byteCount = 0;

    var multipart = await http.MultipartFile.fromPath(
        fileUtil.basename(file!.path), file.path,
        contentType: mediaType);

    // var multipart = http.MultipartFile.fromBytes(
    //     'file', await File.fromUri(Uri.parse(file!.path)).readAsBytes(),
    //     contentType: MediaType('image', 'jpeg'));

    var requestMultipart = http.MultipartRequest("POST", Uri.parse(api));

    // requestMultipart.headers["apiusername"] = APIs.apiUserName;
    // requestMultipart.headers["apipassword"] = APIs.apipassword;
    requestMultipart.headers["Content-type"] = "multipart/form-data";
    // requestMultipart.headers["uid"] = userid.toString();
    // requestMultipart.headers["scode"] = sCode.toString();

    requestMultipart.fields["typeofimport"] = "0";
    requestMultipart.fields["albumid"] = params?["albumid"];
    requestMultipart.fields["datetime"] = params?["datetime"];
    requestMultipart.fields["angle"] = params?["angle"];
    requestMultipart.fields["geokey"] = params?["geokey"];

    requestMultipart.files.add(multipart);

    var msStream = requestMultipart.finalize();

    var totalByteLength = requestMultipart.contentLength;

    request.contentLength = totalByteLength;

    // request.headers.set("apiusername", APIs.apiUserName);
    // request.headers.set("apipassword", APIs.apipassword);
    // request.headers.set("Content-type", "multipart/form-data");
    // request.headers.set("uid", userid.toString());
    // request.headers.set("scode", sCode.toString());
    request.headers.set(HttpHeaders.contentTypeHeader,
        requestMultipart.headers[HttpHeaders.contentTypeHeader]!);

    Stream<List<int>> streamUpload = msStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);

          byteCount += data.length;

          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
          fileUploaded!(totalByteLength);
          print("Upload is done");
        },
      ),
    );

    final res = await request.addStream(streamUpload);

    print("res $res");

    final httpResponse = await request.close();

    var statusCode = httpResponse.statusCode;
    print("httpStatusCode $statusCode");
    if (statusCode ~/ 100 != 2) {
      return "error";
      // throw Exception(
      //     'Error uploading file, Status code: ${httpResponse.statusCode}');
    } else {
      return await readResponseAsString(httpResponse);
    }
  }

  static Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }

  static Future<Map<String, dynamic>> uploadUserImage(
    String api,
    Map<String, String> params,
    // XFile file,
  ) async {
    final url = Uri.parse(api);
    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("$url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    Get.log("$params");

    //final length = await file.length();

    final request = http.MultipartRequest("POST", url);
    request.headers["apiusername"] = "lbus8830082tree";
    request.headers["apipassword"] = "NDU0dDctZmRhajcta2Zkc2ozLWZkYXNr";
    request.headers["Content-type"] = "multipart/form-data";

    request.fields.addAll(params);

    // request.files.add(http.MultipartFile(
    //     isFormDrawer ? 'files' : 'file', file.readAsBytes().asStream(), length,
    //     filename: file.name, contentType: mediaType));
    // request.files.add(http.MultipartFile(
    //     "image",
    //     contentType: MediaType('image', 'jpeg'),
    //     filename: file.path,
    //     file.readAsBytes().asStream(),
    //     length));
    final streamRes = await request.send();
    final res = await http.Response.fromStream(streamRes);
    final Map<String, dynamic> json = await jsonDecode(res.body);
    return json;
  }

  static Future<LoginResponseModel> getLoginResponse(
      String api, dynamic body) async {
    final url = Uri.parse(api);

    final http.Response res;
    res = await http.post(url, body: body);
    Get.log(res.body);
    return loginResponseModelFromJson(res.body);
  }

  static Future<OffersModel> getOffersList(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    res = await http.get(url, headers: {
      'apiusername': 'lbus8830082tree',
      'apipassword': 'NDU0dDctZmRhajcta2Zkc2ozLWZkYXNr',
      'Content-type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1OTMzMDFiOWY0N2M1NTE2M2FiOGQzMSIsImlhdCI6MTcwNzY1NDc5Mn0.kN5YVdoumzLoQw3xPf7meHSt8WBACzgCKVGgn2V4Vfw',
    });

    return offersModelFromJson(res.body);
  }

  static Future<HomeModel> homeScreen(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    res = await http.get(url, headers: {
      'apiusername': 'lbus8830082tree',
      'apipassword': 'NDU0dDctZmRhajcta2Zkc2ozLWZkYXNr',
      'Content-type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ODlhMTMxMGNlN2UzNmE1OTU4YjI1MSIsImlhdCI6MTcwODUzOTA0M30.Ekg_pvZVJSxzki_sZBaJbVr1R3sRDGdNhaofz56EL14',
    });

    return homeModelFromJson(res.body);
  }

  static Future<LocationModel> getLocationnList(String api) async {
    final url = Uri.parse(api);
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)! ?? "";

    final http.Response res;
    res = await http.get(url, headers: {
      'apiusername': 'lbus8830082tree',
      'apipassword': 'NDU0dDctZmRhajcta2Zkc2ozLWZkYXNr',
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    return locationModelFromJson(res.body);
  }

  static Future<void> addFav(String api) async {
    final url = Uri.parse(api);

    final http.Response res = await http.get(
      url,
      headers: {
        'apiusername': 'lbus8830082tree',
        'apipassword': 'NDU0dDctZmRhajcta2Zkc2ozLWZkYXNr',
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ODlhMTMxMGNlN2UzNmE1OTU4YjI1MSIsImlhdCI6MTcwODUzOTA0M30.Ekg_pvZVJSxzki_sZBaJbVr1R3sRDGdNhaofz56EL14',
      },
    );

    if (res.statusCode == 200) {
      final responseData = jsonDecode(res.body);
      final bool status = responseData['status'];
      final String message = responseData['message'];
      print('Status: $status');
      print('Message: $message');
    } else {
      print('Request failed with status: ${res.statusCode}.');
    }
  }

  static Future<RestDetailsModel> getRestDetails(String api, Map? param) async {
    print("Rest details");
    final url = Uri.parse(api);

    final http.Response res;
    res = await http.post(url,
        headers: {
          'apiusername': 'lbus8830082tree',
          'apipassword': 'NDU0dDctZmRhajcta2Zkc2ozLWZkYXNr',
          'Content-type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ODlhMTMxMGNlN2UzNmE1OTU4YjI1MSIsImlhdCI6MTcwODUzOTA0M30.Ekg_pvZVJSxzki_sZBaJbVr1R3sRDGdNhaofz56EL14',
        },
        body: jsonEncode(param));

    return restDetailsModelFromJson(res.body);
  }

  static Future<CreateOrderModel> createOrder(String api, Map? param) async {
    final url = Uri.parse(api);

    final http.Response res;
    res = await http.post(url,
        headers: {
          'apiusername': 'lbus8830082tree',
          'apipassword': 'NDU0dDctZmRhajcta2Zkc2ozLWZkYXNr',
          'Content-type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ODlhMTMxMGNlN2UzNmE1OTU4YjI1MSIsImlhdCI6MTcwODUzOTA0M30.Ekg_pvZVJSxzki_sZBaJbVr1R3sRDGdNhaofz56EL14',
        },
        body: jsonEncode(param));

    final map = jsonDecode(res.body);

    return CreateOrderModel.fromJson(map);
  }

  static Future<OrderModel> getCartItem(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    res = await http.get(url, headers: {
      'apiusername': 'lbus8830082tree',
      'apipassword': 'NDU0dDctZmRhajcta2Zkc2ozLWZkYXNr',
      'Content-type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ODlhMTMxMGNlN2UzNmE1OTU4YjI1MSIsImlhdCI6MTcwODUzOTA0M30.Ekg_pvZVJSxzki_sZBaJbVr1R3sRDGdNhaofz56EL14',
    });
    final map = jsonDecode(res.body);

    return OrderModel.fromJson(map);
  }

  static Future<OrderModel> updateOrder(String api, Map? param) async {
    final url = Uri.parse(api);

    final http.Response res;
    res = await http.put(url,
        headers: {
          'apiusername': 'lbus8830082tree',
          'apipassword': 'NDU0dDctZmRhajcta2Zkc2ozLWZkYXNr',
          'Content-type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ODlhMTMxMGNlN2UzNmE1OTU4YjI1MSIsImlhdCI6MTcwODUzOTA0M30.Ekg_pvZVJSxzki_sZBaJbVr1R3sRDGdNhaofz56EL14',
        },
        body: jsonEncode(param));

    final map = jsonDecode(res.body);
    isList = false;
    return OrderModel.fromJson(map);
  }
}
