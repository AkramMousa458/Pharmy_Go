import 'package:dio/dio.dart';
import 'package:pharmygo/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

// The ApiService class for making HTTP GET, POST, and DELETE requests
class ApiService {
  // Base URL for the Google Books API
  final _baseUrl = uri;

  String? token;
  // Dio instance used for making HTTP requests
  final Dio _dio;

  // Constructor to initialize the ApiService with a Dio instance
  ApiService(this._dio);

  // Asynchronous function to make a GET request to the API
  Future<Map<String, dynamic>> get({required String endPoint}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('auth-token') == null) {
      prefs.setString('auth-token', '');
    }
    token = prefs.getString('auth-token');

    // Send a GET request to the specified endPoint by combining it with the base URL
    var response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }),
    );

    // Return the response data as a map (dynamic) containing key-value pairs
    return response.data;
  }

  // Asynchronous function to make a POST request to the API
  Future<Map<String, dynamic>> post(
      {required String endPoint, required dynamic data}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getString('auth-token') == null) {
    //   prefs.setString('auth-token', '');
    // }
    // token = prefs.getString('auth-token');

    // Send a POST request to the specified endPoint by combining it with the base URL
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: data,
      // options: Options(
      //   headers: {"Content-Type": "application/json"},
      // validateStatus: (status) {
      //   return status! < 500; // Accept status codes less than 500
      // },
      // ),
    );

    // Return the response data as a map (dynamic) containing key-value pairs
    return response.data;
  }

  // Asynchronous function to make a DELETE request to the API
  Future<Map<String, dynamic>> delete({required String endPoint}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('auth-token') == null) {
      prefs.setString('auth-token', '');
    }
    token = prefs.getString('auth-token');

    // Send a DELETE request to the specified endPoint by combining it with the base URL
    var response = await _dio.delete(
      '$_baseUrl$endPoint',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }),
    );

    // Return the response data as a map (dynamic) containing key-value pairs
    return response.data;
}

  // Asynchronous function to make a POST request to the API
Future<Map<String, dynamic>> postUpdate({
  required String endPoint,
  required dynamic data,
  Map<String, dynamic>? queryParameters,
})  async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getInt('auth-id') == 0) {
    prefs.setInt('auth-id', 0);
  }

  // Combine the base URL and the endpoint, and create the full URL
  String url = '$_baseUrl$endPoint';

  // If there are query parameters, add them to the URL
  if (queryParameters != null && queryParameters.isNotEmpty) {
    url += '?${Uri(queryParameters: queryParameters).query}';
  }

  // Send a POST request to the specified URL
  var response = await _dio.post(
    url,
    data: data,
    options: Options(headers: {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ${prefs.getInt('auth-id')}'
    }),
  );

  // Return the response data as a map (dynamic) containing key-value pairs
  return response.data;
}


}