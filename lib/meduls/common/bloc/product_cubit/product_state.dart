part of 'product_cubit.dart';

class ProductState extends Equatable {
  final RequestState? addProductsState;
  final RequestState? optionsState;
  final RequestState? uploadImageState;

  final List<String> images;
  final CategoryModel? categoryModel;
  final String? colors;
  final String? sizes;
  final String? marka;
  final bool discount;
  //** delete product */
  final RequestState? deleteProductState;
  final RequestState? updateProductState;
  final RequestState? getDataForUpdateState;
  final int currentPageSlider;
  //** search product */
  final RequestState? searchProductsState;
  final List<SearchProductResponse> searchProducts;

  //** get product */
  // final RequestState? getProductsByProviderIdState;

  //** rate product */
  final RequestState? addRateProductState;

  final RequestState? getRateProductState;
  final List<RateResponse> rates;

  const ProductState(
      {this.addProductsState,
      this.deleteProductState,
      this.getDataForUpdateState,
     
      this.getRateProductState, this.rates=const [], 
      this.updateProductState,
      this.currentPageSlider = 0,
      this.marka,
      this.uploadImageState,
      this.optionsState,
      this.discount = false,
      this.images = const [],
      this.categoryModel,
      this.colors,
      this.sizes,
      this.searchProductsState,
      this.searchProducts = const [],
      this.addRateProductState});

  ProductState copyWith(
          {final RequestState? addProductsState,
          final int? currentPageSlider,
          final List<String>? images,
          final String? marka,
          final bool? discount,
          final String? sizes,
          final RequestState? optionsState,
          final CategoryModel? categoryModel,
          final RequestState? uploadImageState,
          final RequestState? deleteProductState,
          final RequestState? updateProductState,
          final String? colors,
            final RequestState? getDataForUpdateState,
          final RequestState? searchProductsState,
          final List<SearchProductResponse>? searchProducts,
          final RequestState? addRateProductState,
            final RequestState? getRateProductState,
  final List<RateResponse>? rates,
    // final RequestState? getProductsByProviderIdState,
 
          }) =>
      ProductState(
        addProductsState: addProductsState ?? this.addProductsState,
        getDataForUpdateState: getDataForUpdateState ?? this.getDataForUpdateState,
        addRateProductState: addRateProductState ?? this.addRateProductState,
        updateProductState: updateProductState ?? this.updateProductState,
        images: images ?? this.images,
        sizes: sizes ?? this.sizes,
        marka: marka ?? this.marka,
        colors: colors ?? this.colors,
        discount: discount ?? this.discount,
        uploadImageState: uploadImageState ?? this.uploadImageState,
        optionsState: optionsState ?? this.optionsState,
        categoryModel: categoryModel ?? this.categoryModel,
        deleteProductState: deleteProductState ?? this.deleteProductState,
        currentPageSlider: currentPageSlider ?? this.currentPageSlider,
        searchProductsState: searchProductsState ?? this.searchProductsState,
        searchProducts: searchProducts ?? this.searchProducts,
        getRateProductState: getRateProductState ?? this.getRateProductState,
        rates: rates ?? this.rates,

          //  getProductsByProviderIdState: getProductsByProviderIdState ?? this.getProductsByProviderIdState,
     
      );

  @override
  List<Object?> get props => [
    getDataForUpdateState,
   
        currentPageSlider,
        addProductsState,
        images,
        sizes,
        discount,
        colors,
        categoryModel,
        marka,
        optionsState,
        uploadImageState,
        deleteProductState,
        updateProductState,
        searchProductsState,
        searchProducts,
        addRateProductState,
        rates,
        getRateProductState
      ];
}
