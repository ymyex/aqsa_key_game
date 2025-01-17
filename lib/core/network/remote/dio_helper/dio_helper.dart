import 'package:dio/dio.dart';
import '../../../constant/app_constance.dart';
import 'package:logger/logger.dart';

class DioHelper {
  static late Dio dio;
  static final Logger logger = Logger();

  static init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstance.quranApisBaseURL, // Default base URL
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 10), // 10 seconds
        receiveTimeout: const Duration(seconds: 10), // 10 seconds
      ),
    );

    // Add interceptors for detailed logging
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        logger.d(
            "REQUEST[${options.method}] => URL: ${options.baseUrl}${options.path}");
        logger.d("Headers: ${options.headers}");
        logger.d("Data: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        logger.d("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        logger.e("ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}");
        if (e.response != null) {
          logger.e("ERROR DATA: ${e.response?.data}");
        }
        return handler.next(e);
      },
    ));
  }

  static Future<Response> getData({
    required String endPoint,
    bool mainUrl = false,
    Map<String, dynamic>? query,
    String? bearer,
  }) async {
    dio.options.headers = {
      'Accept-Language': AppConstance.appLanguage,
      if (bearer != null) 'Authorization': 'Bearer $bearer',
      "Accept": "application/json"
    };

    dio.options.baseUrl =
        mainUrl ? AppConstance.mainApisBaseURL : AppConstance.quranApisBaseURL;

    return await dio.get(endPoint, queryParameters: query);
  }

  static Future<Response> postData({
    required String endPoint,
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? query,
    String? bearer,
    bool mainUrl = false,
  }) async {
    if (isFormData) {
      dio.options.headers = {
        'Accept-Language': AppConstance.appLanguage,
        if (bearer != null) 'Authorization': 'Bearer $bearer',
        "Accept": "application/json",
        // Do not set 'Content-Type' manually; Dio handles it
      };
    } else {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept-Language': AppConstance.appLanguage,
        if (bearer != null) 'Authorization': 'Bearer $bearer',
        "Accept": "application/json"
      };
    }

    dio.options.baseUrl =
        mainUrl ? AppConstance.mainApisBaseURL : AppConstance.quranApisBaseURL;

    // Define request options
    Options options = Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
    );

    return await dio.post(
      endPoint,
      queryParameters: query,
      data: isFormData ? FormData.fromMap(data) : data,
      options: options,
    );
  }

  static Future<Response> patchData({
    required String endPoint,
    dynamic data,
    bool isFormData = false,
    Map<String, dynamic>? query,
    String? bearer,
    bool mainUrl = false,
  }) async {
    if (isFormData) {
      dio.options.headers = {
        'Accept-Language': AppConstance.appLanguage,
        if (bearer != null) 'Authorization': 'Bearer $bearer',
        "Accept": "application/json"
      };
    } else {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept-Language': AppConstance.appLanguage,
        if (bearer != null) 'Authorization': 'Bearer $bearer',
        "Accept": "application/json"
      };
    }

    dio.options.baseUrl =
        mainUrl ? AppConstance.mainApisBaseURL : AppConstance.quranApisBaseURL;

    Options options = Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
    );

    return await dio.patch(
      endPoint,
      queryParameters: query,
      data: isFormData ? FormData.fromMap(data) : data,
      options: options,
    );
  }

  static Future<Response> putData({
    required String endPoint,
    required dynamic data,
    Map<String, dynamic>? query,
    bool mainUrl = false,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept-Language': AppConstance.appLanguage,
      "Accept": "application/json"
    };

    dio.options.baseUrl =
        mainUrl ? AppConstance.mainApisBaseURL : AppConstance.quranApisBaseURL;

    return await dio.put(endPoint, queryParameters: query, data: data);
  }

  static Future<Response> deleteData({
    required String endPoint,
    dynamic data,
    Map<String, dynamic>? query,
    String? bearer,
    bool mainUrl = false,
  }) async {
    dio.options.headers = {
      'Accept-Language': AppConstance.appLanguage,
      if (bearer != null) 'Authorization': 'Bearer $bearer',
      "Accept": "application/json",
    };

    dio.options.baseUrl =
        mainUrl ? AppConstance.mainApisBaseURL : AppConstance.quranApisBaseURL;

    Options options = Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
    );

    return await dio.delete(
      endPoint,
      queryParameters: query,
      data: data,
      options: options,
    );
  }
}
