part of 'auth_cubit.dart';

 class AuthState extends Equatable {
  // register
  final RequestState? registerUserState;
  final ResponseRegister? responseRegister;

  // login
  final UserResponse? userResponseModel;
  final RequestState? loginUserState;
  //check 
    final RequestState? checkUserState;


    const AuthState(
      {this.registerUserState,
      this.responseRegister,
      this.checkUserState, 
      this.userResponseModel,

      this.loginUserState
      });

       AuthState copyWith(
      {final registerUserState,
      final responseRegister,
     final userResponseModel,
    final  checkUserState,
    // final currentGender,
 final loginUserState
      }) {
    return AuthState(
     checkUserState: checkUserState ?? this.checkUserState,
      //   currentCountry: currentCountry ?? this.currentCountry,
        registerUserState: registerUserState ?? this.registerUserState,
        responseRegister: responseRegister ?? this.responseRegister,
        userResponseModel: userResponseModel ?? this.userResponseModel,
      loginUserState: loginUserState ?? this.loginUserState
        );
  }

  @override
  List<Object?> get props => [registerUserState, responseRegister,loginUserState,userResponseModel,checkUserState];
}


