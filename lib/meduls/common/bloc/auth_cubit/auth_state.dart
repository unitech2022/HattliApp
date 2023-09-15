part of 'auth_cubit.dart';

class AuthState extends Equatable {
  // register
  final RequestState? registerUserState;
  final RequestState? deleteAccountState;
  final ResponseRegister? responseRegister;

  // login
  final UserResponse? userResponseModel;
  final RequestState? loginUserState;
  //check
  final RequestState? checkUserState;
   final RequestState? resendCodeState;
  final int roleUser;



  // upload image
  final RequestState? imageState;
  final String? image;
  final String? errorImageMessage;

  //** provider
    final RequestState? createProviderState;
    final RequestState? imageLogoState;
  final String? imageLogo;
    final RequestState? imagePassState;
  final String? imagePass;
  final int  timerCount;

  const AuthState(
      {this.registerUserState,
      this.responseRegister,
        this.deleteAccountState,
      this.checkUserState,
      this.userResponseModel,
      this.errorImageMessage,
      this.image,
      this.timerCount=60,
      this.imageState,
      this.roleUser = 0,
      this.loginUserState
      ,this.createProviderState
       ,this.resendCodeState,
      this.imageLogoState,
      this.imageLogo ,
      this.imagePassState,
       this.imagePass
      
      });

  AuthState copyWith(
      {final registerUserState,
      final responseRegister,
      final userResponseModel,
      final checkUserState,
      final int? roleUser,
        final RequestState? deleteAccountState,
      final errorImageMessage,
      final image,
      final imageState,
      final int?  timerCount,
         final RequestState? resendCodeState,
      final loginUserState
      , final RequestState? createProviderState,
    final RequestState? imageLogoState,
  final String? imageLogo,
    final RequestState? imagePassState,
  final String? imagePass
      
      }) {
    return AuthState(
        deleteAccountState: deleteAccountState ?? this.deleteAccountState,
        checkUserState: checkUserState ?? this.checkUserState,
        resendCodeState: resendCodeState ?? this.resendCodeState,
         timerCount: timerCount ?? this.timerCount,
        registerUserState: registerUserState ?? this.registerUserState,
        responseRegister: responseRegister ?? this.responseRegister,
        userResponseModel: userResponseModel ?? this.userResponseModel,
        loginUserState: loginUserState ?? this.loginUserState,
        roleUser: roleUser ?? this.roleUser,
        errorImageMessage: errorImageMessage ?? this.errorImageMessage,
        image: image ?? this.image,
        imageState: imageState ?? this.imageState,
        createProviderState: createProviderState ?? this.createProviderState,
        imageLogoState: imageLogoState ?? this.imageLogoState,
        imageLogo: imageLogo ?? this.imageLogo,
        imagePassState: imagePassState ?? this.imagePassState,
        imagePass: imagePass ?? this.imagePass
        
        
        );
  }

  @override
  List<Object?> get props => [
    deleteAccountState,
    timerCount,
    resendCodeState,
        registerUserState,
        responseRegister,
        loginUserState,
        userResponseModel,
        checkUserState,
        roleUser,
        errorImageMessage,
        imageState,
        image,
        createProviderState,
      imageLogoState,
      imageLogo ,
      imagePassState,
       imagePass
      ];
}
