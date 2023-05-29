import 'package:equatable/equatable.dart';

enum AppStates {
  initiale,
  loading,
  noConnection,
  updating,
  loaded,
  failed,
  empty,
}


enum RequestState {
  loading ,
  loaded,
  error,
  pagination 
}

class GetDataFlow extends Equatable {
  const GetDataFlow({
    required this.appStates,
    required this.errorMessage,
  });
  final AppStates appStates;
  final String errorMessage;

  @override
  List<Object?> get props => [
        appStates,
        errorMessage,
      ];
}
