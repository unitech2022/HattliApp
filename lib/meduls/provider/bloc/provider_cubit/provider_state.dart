part of 'provider_cubit.dart';

class ProviderState extends Equatable {
  final RequestState? createProviderState;
  final CategoryModel? categoryModel;
  final RequestState? imageLogoState;
  final String? imageLogo;

// *** change phone
  final ChangePhoneResponse? changePhoneResponse;
  final RequestState? changePhoneState;
  final RequestState? imagePassportState;
  final String? imagePassport;
  final AddressModel? addressProvider;
  //** detailsProvider */
  final RequestState? getDetailsProviderState;
  final DetailsProviderResponse? detailsProviderResponse;
  final int indexDetailsProvider;
 final bool isManualOrder;
  final bool isDisplay;
  //** providers by catId */
  final RequestState? getProvidersByCatIdState;
  final List<Provider> providers;
  final List<Product> products;
  final ProductsResponsePagination? productsResponse;

  final RequestState? getProvidersByProviderIdState;
  //** update provider */
  final RequestState? updateProviderState;
// ** area
  final double? area;

  const ProviderState({
    this.changePhoneResponse,
    this.changePhoneState,
    this.imageLogoState,
      this.isManualOrder=false,
    this.imageLogo,
    this.isDisplay = true,
    this.area,
    this.products = const [],
    this.getProvidersByProviderIdState,
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
    this.productsResponse,
    this.providers = const [],
  });

  ProviderState copyWith(
          {final RequestState? createProviderState,
          final RequestState? imageLogoState,
          final ChangePhoneResponse? changePhoneResponse,
          final RequestState? changePhoneState,
           final bool? isManualOrder,
          final String? imageLogo,
          final List<Product>? products,
          final int? indexDetailsProvider,
          final RequestState? imagePassportState,
          final CategoryModel? categoryModel,
          final AddressModel? addressProvider,
          final String? imagePassport,
          final RequestState? getDetailsProviderState,
          final DetailsProviderResponse? detailsProviderResponse,
          final RequestState? getProvidersByCatIdState,
          final List<Provider>? providers,
          final RequestState? updateProviderState,
          final double? area,
          final ProductsResponsePagination? productsResponse,
          final bool? isDisplay,
          final RequestState? getProvidersByProviderIdState}) =>
      ProviderState(
        getProvidersByProviderIdState:
            getProvidersByProviderIdState ?? this.getProvidersByProviderIdState,
        area: area ?? this.area,
          isManualOrder: isManualOrder ?? this.isManualOrder,
        isDisplay: isDisplay ?? this.isDisplay,
        changePhoneResponse: changePhoneResponse ?? this.changePhoneResponse,
        changePhoneState: changePhoneState ?? this.changePhoneState,
        products: products ?? this.products,
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
        productsResponse: productsResponse ?? this.productsResponse,
      );

  @override
  List<Object?> get props => [
        getProvidersByProviderIdState,
        createProviderState,
        categoryModel,
        products,
        isDisplay,
        changePhoneResponse,
        changePhoneState,
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
        updateProviderState,
        area,
        isManualOrder,
        productsResponse,
      ];
}
