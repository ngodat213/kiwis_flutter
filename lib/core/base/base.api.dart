import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:kiwis_flutter/services/services.dart';

enum ApiStatus { SUCCEEDED, FAILED, INTERNET_UNAVAILABLE }

enum ApiMethod { GET, POST, PUT, DELETE }

Map<ApiMethod, String> apiMethod = {
  ApiMethod.GET: 'get',
  ApiMethod.POST: 'post',
  ApiMethod.PUT: 'put',
  ApiMethod.DELETE: 'delete'
};

/// ## [BaseDataAPI] - Base Class for handling API
class BaseDataAPI {
  dynamic object;
  var apiStatus;
  var ex;
  BaseDataAPI({this.object, this.apiStatus, this.ex});
}

void printLogYellow(String message) {
  print('\x1B[33m$message\x1B[0m');
}

void printLogError(String message) {
  print('\x1B[31m$message\x1B[0m');
}

void printLogSusscess(String message) {
  print('\x1B[32m$message\x1B[0m');
}

class BaseAPI {
  /// ## [domain] is domain of API
  static String domain = '';

  /// _dio is instance of dio
  final Dio _dio = Dio();

  /// BaseAPI is instance of BaseAPI
  BaseAPI();

  /// # [fetchData] is fetch data from API
  /// * Param [url] is url of API without domain
  /// * Param [params] is params of API with key and value
  /// * Param [body] is body of API with key and value
  /// * Param [headers] is headers of API with key and value
  /// * Return [BaseDataAPI] is object of BaseDataAPI with object and apiStatus
  /// * Example:
  ///  ```dart
  ///  return BaseDataAPI(object: response.data, apiStatus:ApiStatus.SUCCEEDED);
  /// ```
  Future<Map<String, String>> getHeaders() async {
    final userToken = await AuthServices.getAuthBearerToken();
    print('User token:($userToken)');
    return {
      "Authorization": "Bearer $userToken",
      // "lang": translator.activeLocale.languageCode,
    };
  }

  Future<Response> fetchData(
    url, {
    dynamic body,
    bool includeHeaders = false,
    bool forceRefresh = false,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    ApiMethod method = ApiMethod.GET,
  }) async {
    /// Continue to fetch data
    /// response is response of API
    Response response;
    printLogYellow('API:${apiMethod[method]}|================--------------->');
    print('url: $domain$url');
    print('header: $headers');
    print('params: $params');
    print('body: $body');
    try {
      final cacheOptions = CacheOptions(
        store: MemCacheStore(),
        maxStale: const Duration(hours: 1), // set the cache duration
        policy:
            forceRefresh ? CachePolicy.refreshForceCache : CachePolicy.request,
      );

      Options options = Options();
      options.method = apiMethod[method];
      options.headers = await getHeaders();
      response = await _dio.request(domain + url,
          data: body, queryParameters: params, options: options);
    } on DioException catch (e) {
      /// If error is DioError, return [ApiStatus.FAILED]
      printLogError('Error [${apiMethod[method]} API]: $e');
      printLogYellow(
          'END API ${apiMethod[method]}<---------------================|');
      throw fromDioError(e);
    }
    // If response.data is DioError, return [ApiStatus.FAILED]
    if (response.data is DioException) {
      printLogError('Error [${apiMethod[method]} API]: ${response.data}');
      printLogYellow('END API GET<---------------================|');
      throw fromDioError(response.data);
    }
    // If response.data is not null, return [response.data ,ApiStatus.SUCCEEDED]
    printLogSusscess('Success [${apiMethod[method]} API]: ${response.data}');
    printLogYellow(
        'END API ${apiMethod[method]}<---------------================|');
    return response;
  }

  Future<Response> fileUpload(String url,
      {dynamic body,
      bool includeHeaders = false,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? params,
      ApiMethod method = ApiMethod.POST,
      required Uint8List file}) async {
    /// Check internet connection is available
    /// * If internet connection is not available,
    ///  return [ApiStatus.INTERNET_UNAVAILABLE]
    /// * If internet connection is available,
    /// continue to fetch data

    if (!(await Connectivity().checkConnectivity() !=
        ConnectivityResult.none)) {
      return Response(
        statusCode: 400,
        requestOptions: RequestOptions(path: url),
      );
    }

    /// Continue to fetch data
    /// response is response of API
    Response response;
    printLogYellow('API:${apiMethod[method]}|================--------------->');
    print('url: $domain$url');
    print('header: ${includeHeaders ? headers : await getHeaders()}');
    print('body: $body');
    try {
      Options options = Options();
      options.method = apiMethod[method];
      options.headers = includeHeaders
          ? headers != null
              ? headers
              : await getHeaders()
          : null;
      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(file, filename: 'upload.png'),
        if (body != null && body.isNotEmpty) ...body,
      });
      response = await _dio.request(
        domain + url,
        data: formData,
        queryParameters: params,
        options: options,
      );
    } on DioException catch (e) {
      /// If error is DioError, return [ApiStatus.FAILED]
      printLogError('Error [${apiMethod[method]} API]: $e');
      printLogYellow(
          'END API ${apiMethod[method]}<---------------================|');
      return Response(
        statusCode: 400,
        requestOptions: RequestOptions(path: url),
      );
    }
    // If response.data is DioError, return [ApiStatus.FAILED]
    if (response.data is DioException) {
      printLogError('Error [${apiMethod[method]} API]: ${response.data}');
      printLogYellow('END API GET<---------------================|');
      return Response(
        statusCode: 400,
        requestOptions: RequestOptions(path: url),
      );
    }
    // If response.data is not null, return [response.data ,ApiStatus.SUCCEEDED]
    printLogSusscess('Success [${apiMethod[method]} API]: ${response.data}');
    printLogYellow(
        'END API ${apiMethod[method]}<---------------================|');
    return response;
  }

  Future<Response> fetchFormData(
    String url, {
    required Uint8List file,
    Map<String, dynamic>? headers,
  }) async {
    /// Check internet connection is available
    /// * If internet connection is not available,
    ///  return [ApiStatus.INTERNET_UNAVAILABLE]
    /// * If internet connection is available,
    /// continue to fetch data
    if (!(await Connectivity().checkConnectivity() !=
        ConnectivityResult.none)) {
      return Response(
        statusCode: 400,
        requestOptions: RequestOptions(path: url),
      );
    }

    /// Continue to fetch data
    /// response is response of API
    Response response;
    try {
      Options options = Options();
      options.headers = headers;
      String fileName = 'upload.png'; // Default filename
      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(file, filename: fileName),
      });
      response = await _dio.put(domain + url, data: formData, options: options);
    } on DioException catch (err) {
      return Response(
        statusCode: 400,
        requestOptions: RequestOptions(path: url),
      );
    }

    if (response.data is DioException) {
      return Response(
        statusCode: 400,
        requestOptions: RequestOptions(path: url),
      );
    }

    return response;
  }

  Response fromDioError(DioException ex) {
    var response = Response(requestOptions: ex.requestOptions);
    response.statusCode = 400;
    String? errorMessage = response.statusMessage;
    switch (ex.type) {
      case DioExceptionType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timed out.';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Request send timeout.';
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(ex.response?.statusCode);
        break;
      case DioExceptionType.unknown:
        if (ex.message!.contains('SocketException')) {
          errorMessage = 'No Internet.';
          break;
        }
        errorMessage = 'Unexpected error occurred.';
        break;
      default:
        errorMessage = 'Something went wrong';
        break;
    }
    throw errorMessage;
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 401:
        return 'Authentication failed.';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return 'The requested resource does not exist.';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }
}
