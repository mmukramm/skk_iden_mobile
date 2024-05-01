class ApiResponse {
  final String? status;
  final String? message;
  final dynamic data;

  ApiResponse({
    required this.status,
    this.data,
    this.message,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json["status"],
      data: json["data"],
      message: json["message"],
    );
  }
}
