class ErrorResponse {
  ApiError? apiError;

  ErrorResponse({this.apiError});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    apiError = json['apierror'] != null
        ?  ApiError.fromJson(json['apierror'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (apiError != null) {
      data['apierror'] = apiError!.toJson();
    }
    return data;
  }
}

class ApiError {
  String? status;
  int? timestamp;
  String? message;
  String? description;
  String? subErrors;

  ApiError(
      {this.status,
        this.timestamp,
        this.message,
        this.description,
        this.subErrors});

  ApiError.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    timestamp = json['timestamp'];
    message = json['message'];
    description = json['description'];
    subErrors = json['subErrors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['timestamp'] = timestamp;
    data['message'] = message;
    data['description'] = description;
    data['subErrors'] = subErrors;
    return data;
  }
}
