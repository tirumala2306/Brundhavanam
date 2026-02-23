import 'api_client.dart';
import 'api_response.dart';

class AppService {
  final ApiClient apiClient;

  AppService(this.apiClient);

  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    String? token,
    T Function(dynamic json)? fromJson,
  }) {
    return apiClient.request(
      method: "GET",
      endpoint: endpoint,
      queryParams: queryParams,
      token: token,
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
    T Function(dynamic json)? fromJson,
  }) {
    return apiClient.request(
      method: "POST",
      endpoint: endpoint,
      body: body,
      token: token,
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
    T Function(dynamic json)? fromJson,
  }) {
    return apiClient.request(
      method: "PUT",
      endpoint: endpoint,
      body: body,
      token: token,
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    String? token,
    T Function(dynamic json)? fromJson,
  }) {
    return apiClient.request(
      method: "DELETE",
      endpoint: endpoint,
      token: token,
      fromJson: fromJson,
    );
  }
}
// import '../services/api_services/api_constants.dart';
// import '../services/api_services/crud_service.dart';
// import '../services/api_services/api_response.dart';

// class UserRepository {
//   final AppService appService;

//   UserRepository(this.crudService);

//   Future<ApiResponse<dynamic>> fetchUsers() {
//     return appService.get(ApiConstants.users);
//   }

//   Future<ApiResponse<dynamic>> createUser(Map<String, dynamic> data) {
//     return crudService.post(
//       ApiConstants.users,
//       body: data,
//     );
//   }
// }
