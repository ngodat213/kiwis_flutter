class ApiResponse {
  int get totalDataCount => body["meta"]["total"];
  int get totalPageCount => body["pagination"]["total_pages"];
  List get data => body["data"] ?? [];
  // Just a way of saying there was no error with the request and response return
  bool get allGood => success!;
  bool hasError() => error != null && ((error?.length ?? 0) > 0);
  bool hasData() => data.isNotEmpty;
  int? code;
  String? message;
  bool? success;
  dynamic body;
  String? error;

  ApiResponse({
    this.code,
    this.message,
    this.body,
    this.success,
    this.error,
  });

  toJson() {
    return {
      'code': code,
      'message': message,
      'body': body,
      'errors': error,
      'data': data
    };
  }

  factory ApiResponse.fromResponse(dynamic response) {
    //
    int code = response['statusCode'];
    dynamic body = response['data']; // Would mostly be a Map
    bool success = response['success'];

    String error = '';
    String message = "";

    switch (code) {
      case 200:
        try {
          message = body is Map ? (body["message"] ?? "") : "";
        } catch (error) {
          print("Message reading error ==> $error");
        }
        break;
      default:
        message = response["message"] ?? "";
        error = response["error"] ?? "";
        print("ERROR ==> Whoops! $error");
        break;
    }

    return ApiResponse(
      code: code,
      message: message,
      body: body,
      success: success,
      error: error,
    );
  }
}
