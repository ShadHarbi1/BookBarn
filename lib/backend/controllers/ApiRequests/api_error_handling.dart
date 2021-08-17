import 'dart:io';

import 'package:dio/dio.dart';

class ApiErrorHandling {
  static getDioException(error) {
    if (error is Exception) {
      String _errorMsg;
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              _errorMsg = "Request Cancelled";
              break;
            case DioErrorType.connectTimeout:
              _errorMsg = "Connection request timeout";
              break;
            case DioErrorType.other:
              _errorMsg = "No internet connection";
              break;
            case DioErrorType.receiveTimeout:
              _errorMsg = "Send timeout in connection with API server";
              break;
            case DioErrorType.response:
              _errorMsg = handleResponse(error.response.statusCode);
              break;
            case DioErrorType.sendTimeout:
              _errorMsg = "Send timeout in connection with API server";
              break;
          }
        } else if (error is SocketException) {
          _errorMsg = "No internet connection";
        } else {
          _errorMsg = "Unexpected error occurred";
        }
        return _errorMsg;
      } on FormatException catch (e) {
        // Helper.printError(e.toString());
        return "Unexpected error occurred";
      } catch (_) {
        return "Unexpected error occurred";
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return "Unexpected error occurred";
      } else {
        return "Unexpected error occurred";
      }
    }
  }

  static String handleResponse(int statusCode) {
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return "Unauthorized request";
        break;
      case 404:
        return "Not found";
        break;
      case 409:
        return "Error due to a conflict";
        break;
      case 408:
        return "Connection request timeout";
        break;
      case 500:
        return "Internal Server Error";
        break;
      case 503:
        return "Service unavailable";
        break;
      default:
        return "Received invalid status code: $statusCode";
    }
  }
}
