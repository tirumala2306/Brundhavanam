class ApiResponse<T> {
  final T? data;
  final String? error;
  final bool success;

  ApiResponse.success(this.data)
      : error = null,
        success = true;

  ApiResponse.failure(this.error)
      : data = null,
        success = false;
}
