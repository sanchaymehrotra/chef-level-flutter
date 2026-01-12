// Get:-----------------------------------------------------------------------

import 'package:dio/dio.dart';
import 'package:food_chef/core/utils/constant/environment/end_points.dart';


 

class DioClient {

  DioClient(this._dio) {

    _dio

      ..options.baseUrl = baseUrl

      ..options.headers['Authorization'] = 'Bearer '

      ..interceptors.add(LogInterceptor(

          request: true,

          requestHeader: true,

          requestBody: true,

          responseHeader: true,

          responseBody: true))

      ..options.responseType = ResponseType.json;

  }

  final Dio _dio;

  Future<Response> get(

    String url,

    Options? options, {

    CancelToken? cancelToken,

    ProgressCallback? onReceiveProgress,

  }) async {

    try {

      final Response response = await _dio.get(

        url,

        options: options,

        cancelToken: cancelToken,

        onReceiveProgress: onReceiveProgress,

      );

      return response;

    } catch (e) {

      rethrow;

    }

  }

 

  Future<Response> post(

      String url,

      Object? data,

      Options? options, {

        CancelToken? cancelToken,

        ProgressCallback? onReceiveProgress,

      }) async {

    try {

      final Response response = await _dio.post(

        url,

        data: data,

        options: options,

        cancelToken: cancelToken,

        onReceiveProgress: onReceiveProgress,

      );

      return response;

    } catch (e) {

      rethrow;

    }

  }

 

  Future<Response> put(

    Map<String, dynamic> body,

    String url,

    Options? options, {

    CancelToken? cancelToken,

    ProgressCallback? onReceiveProgress,

  }) async {

    try {

      final Response response = await _dio.put(url,

          options: options,

          cancelToken: cancelToken,

          onReceiveProgress: onReceiveProgress,

          data: body);

      return response;

    } catch (e) {

      rethrow;

    }

  }

 

  Future<Response> delete(

    String uri, {

    Map<String, dynamic>? body,

    Options? options,

    CancelToken? cancelToken,

    ProgressCallback? onSendProgress,

    ProgressCallback? onReceiveProgress,

  }) async {

    try {

      final Response response = await _dio.delete(

        uri,

        data: body,

        options: options,

        cancelToken: cancelToken,

      );

      return response;

    } catch (e) {

      rethrow;

    }

  }

}

 