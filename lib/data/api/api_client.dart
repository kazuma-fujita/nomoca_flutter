import 'dart:io';
import 'package:http/http.dart' as http;

abstract class ApiClient {
  Future<String> get(
    String endpoint, {
    required Map<String, String> headers,
  });

  Future<String> post(
    String endpoint, {
    required Map<String, String> headers,
    required String body,
  });

  Future<String> put(
    String endpoint, {
    required Map<String, String> headers,
    required String body,
  });

  Future<String> delete(
    String endpoint, {
    required Map<String, String> headers,
  });
}

class ApiClientImpl implements ApiClient {
  // factory コンストラクタは instanceを生成せず常にキャッシュを返す(singleton)
  factory ApiClientImpl({required String baseUrl}) {
    return _instance ??= ApiClientImpl._internal(baseUrl);
  }
  // クラス生成時に instance を生成する class コンストラクタ
  ApiClientImpl._internal(this.baseUrl);
  // singleton にする為の instance キャッシュ
  static ApiClientImpl? _instance;
  // APIの基底Url
  final String baseUrl;

  static const headers = <String, String>{'content-type': 'application/json'};

  Future<String> _safeApiCall(Function() callback) async {
    try {
      final response = await callback() as http.Response;
      return _parseResponse(response.statusCode, response.body);
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }

  @override
  Future<String> get(
    String endpoint, {
    required Map<String, String> headers,
  }) async {
    return _safeApiCall(() async => http.get(
          Uri.parse('$baseUrl$endpoint'),
          headers: headers,
        ));
  }

  @override
  Future<String> post(
    String endpoint, {
    required Map<String, String> headers,
    required String body,
  }) async {
    return _safeApiCall(() async => http.post(
          Uri.parse('$baseUrl$endpoint'),
          headers: headers,
          body: body,
        ));
  }

  @override
  Future<String> put(
    String endpoint, {
    required Map<String, String> headers,
    required String body,
  }) async {
    return _safeApiCall(() async => http.put(
          Uri.parse('$baseUrl$endpoint'),
          headers: headers,
          body: body,
        ));
  }

  @override
  Future<String> delete(
    String endpoint, {
    required Map<String, String> headers,
  }) async {
    return _safeApiCall(() async => http.delete(
          Uri.parse('$baseUrl$endpoint'),
          headers: headers,
        ));
  }

  String _parseResponse(int httpStatus, String responseBody) {
    switch (httpStatus) {
      case 200:
      case 201:
      case 204:
        return responseBody;
      case 400:
        throw Exception('400 Bad Request');
      case 401:
        throw Exception('401 Unauthorized');
      case 402:
        throw Exception('402 Payment Required');
      case 403:
        throw Exception('403 Forbidden');
      case 404:
        throw Exception('404 Not Found');
      case 405:
        throw Exception('405 Method Not Allowed');
      case 406:
        throw Exception('406 Not Acceptable');
      case 407:
        throw Exception('407 Proxy Authentication Required');
      case 408:
        throw Exception('408 Request Timeout');
      case 409:
        throw Exception('409 Conflict');
      case 410:
        throw Exception('410 Gone');
      case 411:
        throw Exception('411 Length Required');
      case 412:
        throw Exception('412 Precondition Failed');
      case 413:
        throw Exception('413 Payload Too Large');
      case 414:
        throw Exception('414 URI Too Long');
      case 415:
        throw Exception('415 Unsupported Media Type');
      case 416:
        throw Exception('416 Range Not Satisfiable');
      case 417:
        throw Exception('417 Expectation Failed');
      case 418:
        throw Exception('418 I am a teapot');
      case 422:
        throw Exception('422 Unprocessable Entity');
      case 425:
        throw Exception('425 Too Early');
      case 426:
        throw Exception('426 Upgrade Required');
      case 428:
        throw Exception('428 Precondition Required');
      case 429:
        throw Exception('429 Too Many Requests');
      case 431:
        throw Exception('431 Request Header Fields Too Large');
      case 451:
        throw Exception('451 Unavailable For Legal Reasons');
      case 500:
        throw Exception('500 Internal Server Error');
      case 501:
        throw Exception('501 Not Implemented');
      case 502:
        throw Exception('502 Bad Gateway');
      case 503:
        throw Exception('503 Service Unavailable');
      case 504:
        throw Exception('504 Gateway Timeout');
      case 505:
        throw Exception('505 HTTP Version Not Supported');
      case 506:
        throw Exception('506 Variant Also Negotiates');
      case 507:
        throw Exception('507 Insufficient Storage');
      case 508:
        throw Exception('508 Loop Detected');
      case 510:
        throw Exception('510 Not Extended');
      case 511:
        throw Exception('511 Network Authentication Required');
      default:
        throw Exception('Http status $httpStatus unknown error.');
    }
  }
}
