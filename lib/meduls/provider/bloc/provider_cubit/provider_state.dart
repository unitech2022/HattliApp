part of 'provider_cubit.dart';

class ProviderState extends Equatable {
  final RequestState? createProviderState;
  final CategoryModel? categoryModel;
  final RequestState? imageLogoState;
  final String? imageLogo;

  final RequestState? imagePassportState;
  final String? imagePassport;
  final AddressModel? addressProvider;
  //** detailsProvider */
  final RequestState? getDetailsProviderState;
  final DetailsProviderResponse? detailsProviderResponse;
  final int indexDetailsProvider;
  //** providers by catId */
  final RequestState? getProvidersByCatIdState;
  final List<Provider> providers;

  //** update provider */
  final RequestState? updateProviderState;


  const ProviderState({
    this.imageLogoState,
    this.imageLogo,
    this.updateProviderState,
    this.indexDetailsProvider = 0,
    this.createProviderState,
    this.imagePassportState,
    this.imagePassport,
    this.categoryModel,
    this.addressProvider,
    this.getDetailsProviderState,
    this.detailsProviderResponse,
    this.getProvidersByCatIdState,
    this.providers = const [],
    
  });

  ProviderState copyWith(
          {final RequestState? createProviderState,
          final RequestState? imageLogoState,
          final String? imageLogo,
          final int? indexDetailsProvider,
          final RequestState? imagePassportState,
          final CategoryModel? categoryModel,
          final AddressModel? addressProvider,
          final String? imagePassport,
          final RequestState? getDetailsProviderState,
          final DetailsProviderResponse? detailsProviderResponse,
          final RequestState? getProvidersByCatIdState,
          final List<Provider>? providers
          
          , final RequestState? updateProviderState
          }) =>
      ProviderState(
        indexDetailsProvider: indexDetailsProvider ?? this.indexDetailsProvider,
        categoryModel: categoryModel ?? this.categoryModel,
        createProviderState: createProviderState ?? this.createProviderState,
        imageLogoState: imageLogoState ?? this.imageLogoState,
        imageLogo: imageLogo ?? this.imageLogo,
        imagePassportState: imagePassportState ?? this.imagePassportState,
        imagePassport: imagePassport ?? this.imagePassport,
        addressProvider: addressProvider ?? this.addressProvider,
        getDetailsProviderState:
            getDetailsProviderState ?? this.getDetailsProviderState,
        detailsProviderResponse:
            detailsProviderResponse ?? this.detailsProviderResponse,
        getProvidersByCatIdState:
            getProvidersByCatIdState ?? this.getProvidersByCatIdState,
        providers: providers ?? this.providers,
         updateProviderState: updateProviderState ?? this.updateProviderState,
      );

  @override
  List<Object?> get props => [
        createProviderState,
        categoryModel,
        imageLogo,
        imageLogoState,
        imagePassport,
        imagePassportState,
        categoryModel,
        indexDetailsProvider,
        addressProvider,
        detailsProviderResponse,
        getDetailsProviderState,
        getProvidersByCatIdState,
        providers,
        updateProviderState
      ];
}
