enum NetworkingMethods {
  POST,
  GET,
  PUT,
  DELETE,
}

class AppUrls {
  static const String BASE_URL = "http://localhost:7111";
  static const Auth auth = Auth();
}

class Auth {
  const Auth();
  final String signIn = "/auth/signin";
  final String signUp = "/auth/signup";
  final String me = "/users/profile";
}
