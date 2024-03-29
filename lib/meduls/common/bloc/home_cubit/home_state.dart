part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int currentNavIndex;
  final String indexHomeSide;
  final int currentIndexTap;
  //** user */
  final HomeUserResponse? homeUserResponse;
  final RequestState getHomeUserState;
  final List<Marker> markers;
  final UserModel? userModel;
  final List<Provider> providers;
  final RequestState? updateUserState;
//** provider */
  final HomeResponseProvider? homeResponseProvider;
  final RequestState? getHomeProviderState;
  final int currentPageSlider;

  final List<OrderResponse> orders;

  final RequestState? updateDeviceTokenState;

  //** sort providers */
  final CategoryModel? modelSort;

// *** editProfile
   final RequestState? imageProfileUserState;
  final String? imageLogo;

  const HomeState(
      {this.updateUserState,
      this.currentNavIndex = 0,
         this.modelSort,
      this.currentPageSlider = 0,
      this.orders = const [],
      this.providers = const [],
      this.markers = const [],
      this.currentIndexTap = 0,
      this.indexHomeSide = "الرئيسية",
      this.homeResponseProvider,
      this.getHomeProviderState,
      this.homeUserResponse,
      this.getHomeUserState = RequestState.loading,
      this.userModel,
      this.updateDeviceTokenState,
        this.imageProfileUserState,
      this.imageLogo,
     
      });

  HomeState copyWith({
      final CategoryModel? modelSort,
    final int? currentNavIndex,
    final String? indexHomeSide,
    final int? currentPageSlider,
    final int? currentIndexTap,
    final RequestState? getHomeProviderState,
    final HomeResponseProvider? homeResponseProvider,
    final HomeUserResponse? homeUserResponse,
    final RequestState? getHomeUserState,
    final List<Marker>? markers,
    final List<OrderResponse>? orders,
    final UserModel? userModel,
    final RequestState? updateUserState,
    final RequestState? updateDeviceTokenState,
    final List<Provider>? providers,
       final RequestState? imageProfileUserState,
  final String? imageLogo
  }) =>
      HomeState(
          markers: markers ?? this.markers,
            modelSort: modelSort ?? this.modelSort,
          providers: providers ?? this.providers,
          currentNavIndex: currentNavIndex ?? this.currentNavIndex,
          indexHomeSide: indexHomeSide ?? this.indexHomeSide,
          currentIndexTap: currentIndexTap ?? this.currentIndexTap,
          getHomeProviderState:
              getHomeProviderState ?? this.getHomeProviderState,
          homeResponseProvider:
              homeResponseProvider ?? this.homeResponseProvider,
          currentPageSlider: currentPageSlider ?? this.currentPageSlider,
          homeUserResponse: homeUserResponse ?? this.homeUserResponse,
          getHomeUserState: getHomeUserState ?? this.getHomeUserState,
          orders: orders ?? this.orders,
          userModel: userModel ?? this.userModel,
          updateUserState: updateUserState ?? this.updateUserState,
          updateDeviceTokenState:
              updateDeviceTokenState ?? this.updateDeviceTokenState,
              
              imageProfileUserState: imageProfileUserState ?? this.imageProfileUserState,
          imageLogo: imageLogo ?? this.imageLogo,
              );

  @override
  List<Object?> get props => [
        currentNavIndex,
        indexHomeSide,
        homeResponseProvider,
        getHomeProviderState,
        currentPageSlider,
        homeUserResponse,
        getHomeUserState,
        markers,
        currentIndexTap,
        orders,
        userModel,
        updateUserState,
        updateDeviceTokenState,
        providers,modelSort,
        imageLogo,
        imageProfileUserState

      ];
}
