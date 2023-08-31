part of 'app_cubit.dart';

class AppState extends Equatable {
  final String changLang;
  final String page;
  

  AppState({  this.changLang="",this.page=""});

  AppState copyWith({
    final String? page,
    final String? changLang,
    final int? selectedRadio,
      
  }) =>
      AppState(
        changLang: changLang ?? this.changLang,
        page: page ?? this.page,
        
       
      );
  @override
  List<Object?> get props => [changLang,page];
}
