import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'api_base_url.dart';
import 'api_exception.dart';
import 'api_response.dart';

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Map<String, String> _headers({String? token}) {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Uri _buildUri(String endpoint, [Map<String, dynamic>? queryParams]) {
    final uri = Uri.parse(ApiBaseUrl.baseUrl + endpoint);
    if (queryParams != null) {
      return uri.replace(queryParameters: queryParams);
    }
    return uri;
  }

  // Future<ApiResponse<T>> request<T>({
  //   required String method,
  //   required String endpoint,
  //   Map<String, dynamic>? body,
  //   Map<String, dynamic>? queryParams,
  //   String? token,
  //   T Function(dynamic json)? fromJson,
  // }) async {
  //   try {
  //     final uri = _buildUri(endpoint, queryParams);

  //     late http.Response response;

  //     switch (method) {
  //       case "GET":
  //         response = await _client.get(uri, headers: _headers(token: token));
  //         break;
  //       case "POST":
  //         response = await _client.post(
  //           uri,
  //           headers: _headers(token: token),
  //           body: jsonEncode(body),
  //         );
  //         break;
  //       case "PUT":
  //         response = await _client.put(
  //           uri,
  //           headers: _headers(token: token),
  //           body: jsonEncode(body),
  //         );
  //         break;
  //       case "DELETE":
  //         response =
  //             await _client.delete(uri, headers: _headers(token: token));
  //         break;
  //       default:
  //         throw ApiException(message: "Unsupported HTTP method");
  //     }

  //     return _handleResponse(response, fromJson);
  //   } catch (e) {
  //     return ApiResponse.failure(_handleError(e));
  //   }
  // }

  Future<ApiResponse<T>> request<T>({
    required String method,
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    String? token,
    T Function(dynamic json)? fromJson,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParams);

      log("URL = $uri");
      log("BODY = $body");

      late http.Response response;

      switch (method) {
        case "POST":
          response = await _client.post(
            uri,
            headers: _headers(token: token),
            body: jsonEncode(body),
          );
          break;

        default:
          throw ApiException(message: "Unsupported HTTP method");
      }

      log("STATUS CODE = ${response.statusCode}");
      log("RAW RESPONSE = ${response.body}");

      return _handleResponse(response, fromJson);
    } catch (e) {
      log("API ERROR = $e");

      return ApiResponse.failure(_handleError(e));
    }
  }

  ApiResponse<T> _handleResponse<T>(
    http.Response response,
    T Function(dynamic json)? fromJson,
  ) {
    final statusCode = response.statusCode;
    final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (statusCode >= 200 && statusCode < 300) {
      final data = fromJson != null ? fromJson(body["data"]) : body["data"];
      return ApiResponse.success(data);
    } else {
      throw ApiException(
        message: body?["message"] ?? "Something went wrong",
        statusCode: statusCode,
      );
    }
  }

  String _handleError(Object error) {
    if (error is ApiException) return error.message;
    return "Unexpected error occurred";
  }
}
