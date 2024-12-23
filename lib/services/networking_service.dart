import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/networking_response.dart';

class NetworkingService {
  Future<NetworkingResponse> makeHttpCall({
    headers,
    required String method,
    required String url,
    required Map<String, dynamic>? body,
  }) async {
    var headers0 = headers ??
        {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
          "Access-Control-Allow-Credentials": "true",
        };
    var request = http.Request(method, Uri.parse(url));

    log("Making Http Request");

    request.headers.addAll(headers0);
    request.body = json.encode(body);
    print(request.url);

    log("Url: ${request.url}");
    log("Headers: ${request.headers}");
    log("Body: ${request.body}");
    return await buildResponse(request);
  }

  Future<NetworkingResponse> buildResponse(request) async {
    try {
      http.StreamedResponse response = await request.send();
      //if connection to the server is successful
      String responseString = await response.stream.bytesToString();
      log("Response String: $responseString");
      log("Status code: ${response.statusCode}");
      Map<String, dynamic> data = {};
      if (responseString.isNotEmpty) {
        try {
          data = json.decode(responseString);
        } catch (e) {
          return NetworkingResponse(response.reasonPhrase,
              statusCode: response.statusCode, data: {});
        }
      }

      return NetworkingResponse(response.reasonPhrase,
          statusCode: response.statusCode, data: data);
    } catch (e) {
      throw e.toString();
    }
  }
}
