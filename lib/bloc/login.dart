// import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// enum LoginStatus { initial, loading, success, failure }

// abstract class LoginEvent {}

// class LoginButtonPressed extends LoginEvent {
//   final String email;
//   final String password;

//   LoginButtonPressed({required this.email, required this.password});
// }

// class LoginState {
//   final LoginStatus status;
//   final String? error;

//   LoginState({required this.status, this.error});

//   factory LoginState.initial() {
//     return LoginState(status: LoginStatus.initial);
//   }

//   factory LoginState.loading() {
//     return LoginState(status: LoginStatus.loading);
//   }

//   factory LoginState.success() {
//     return LoginState(status: LoginStatus.success);
//   }

//   factory LoginState.failure(String error) {
//     return LoginState(status: LoginStatus.failure, error: error);
//   }
// }

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final FirebaseAuth _firebaseAuth;

//   LoginBloc({required FirebaseAuth firebaseAuth})
//       : _firebaseAuth = firebaseAuth,
//         super(LoginState.initial()) {
//     on<LoginButtonPressed>((event, emit) {
//       add(event);
//     });
//   }

//   @override
//   Stream<LoginState> mapEventToState(LoginEvent event) async* {
//     if (event is LoginButtonPressed) {
//       yield LoginState.loading();

//       try {
//         await _firebaseAuth.signInWithEmailAndPassword(
//             email: event.email, password: event.password);
//         yield LoginState.success();
//       } catch (e) {
//         yield LoginState.failure(e.toString());
//       }
//     }
//   }
// }
