part of 'app_cubit.dart';

class AppState extends Equatable {
  final String changLang;
  final String page;
   final RequestState? movMapState;

  AppState({  this.changLang="",this.page="",this.movMapState});

  AppState copyWith({
    final String? page,
    final String? changLang,
    final int? selectedRadio,
     final RequestState? movMapState
  }) =>
      AppState(
        changLang: changLang ?? this.changLang,
        page: page ?? this.page,
          movMapState: movMapState ?? this.movMapState,
       
      );
  @override
  List<Object?> get props => [changLang,page,movMapState];
}
