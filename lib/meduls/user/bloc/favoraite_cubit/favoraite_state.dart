part of 'favoraite_cubit.dart';

class FavoriteState extends Equatable {
  final RequestState? addFavState;
  final RequestState? deleteFavState;
  final RequestState? updateFavState;
  final RequestState? getFavState;
  final List<FavoriteResponse> favorites;

  const FavoriteState({
    this.addFavState,
    this.deleteFavState,
    this.updateFavState,
    this.getFavState,
    this.favorites=const []
  });

  FavoriteState copyWith({
    final RequestState? addFavState,
    final RequestState? deleteFavState,
    final RequestState? updateFavState,
    final RequestState? getFavState,
     final List<FavoriteResponse>? favorites
  }) =>
      FavoriteState(
        addFavState: addFavState ?? this.addFavState,
        deleteFavState: deleteFavState ?? this.deleteFavState,
        updateFavState: updateFavState ?? this.updateFavState,
        getFavState: getFavState ?? this.getFavState,
         favorites: favorites ?? this.favorites,
      );

  @override
  List<Object?> get props =>
      [updateFavState, addFavState, updateFavState, getFavState,favorites];
}
