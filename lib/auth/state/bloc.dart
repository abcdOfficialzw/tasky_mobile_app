import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/auth/models/data/signin_response_model.dart';
import 'package:tasky/models/networking_response.dart';
import 'package:tasky/services/networking_service.dart';
import 'package:tasky/utils/constants/app_urls.dart';
import '../../services/secure_storage.dart';
import 'event.dart';
import 'state.dart';
import 'package:logging/logging.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Logger log = Logger('Sign in BLoC');
  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(_onLogin);
    on<SignupEvent>(_onSignup);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      log.info("Starting signin process🔄");
      final headers = {
        'accept': '*/*',
        'Content-Type': 'application/json',
      };

      final Map<String, String> bodyParams = {
        'username': event.username,
        'password': event.password,
      };

      NetworkingResponse networkingResponse = await NetworkingService()
          .makeHttpCall(
              method: NetworkingMethods.POST.name,
              url: AppUrls.BASE_URL + AppUrls.auth.signIn,
              body: bodyParams);

      if (networkingResponse.statusCode == 200) {
        log.info("Authentication succeeded✅");

        SignInResponseModel signInResponseModel =
            SignInResponseModel.fromJson(networkingResponse.data);

        /// save preferences in secure storage
        SecureStorage secureStorage = SecureStorage();
        secureStorage.saveToken(signInResponseModel.token!);

        log.info("Fetching user profile🔁");
      } else {
        throw Exception(networkingResponse.reasonPhrase);
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {} catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
