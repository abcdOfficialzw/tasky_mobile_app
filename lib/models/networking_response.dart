class NetworkingResponse {
  final int statusCode;
  final Map<String, dynamic> data;
  final String? reasonPhrase;
  NetworkingResponse(this.reasonPhrase,
      {required this.statusCode, required this.data});
}
