class ApiBaseResponse<T> {
  T data;
  bool success;
  String message;
  String status;
  String title;

  ApiBaseResponse({
    required this.data,
    required this.success,
    required this.message,
    required this.status,
    required this.title,
  });

  factory ApiBaseResponse.fromJson(Map<String, dynamic> json) =>
      ApiBaseResponse(
        data: json["data"] as T,
        success: json["success"] as bool,
        message: json["message"] as String,
        status: json["status"] as String,
        title: json["title"] as String,
      );
}
