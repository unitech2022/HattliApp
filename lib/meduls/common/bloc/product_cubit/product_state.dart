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
  //** delete product */
  final RequestState? deleteProductState;
  final RequestState? updateProductState;
  final int currentPageSlider;
  //** search product */
 final RequestState? searchProductsState;
  final List<SearchProductResponse> searchProducts;
  const ProductState(
      {this.addProductsState,
      this.deleteProductState,
      this.updateProductState,
      this.currentPageSlider = 0,
      this.marka,
      this.uploadImageState,
      this.optionsState,
      this.images = const [],
      this.categoryModel,
      this.colors,
      this.sizes
      , this.searchProductsState,
      this.searchProducts=const []
      });

  ProductState copyWith(
          {final RequestState? addProductsState,
          final int? currentPageSlider,
          final List<String>? images,
          final String? marka,
          final String? sizes,
          final RequestState? optionsState,
          final CategoryModel? categoryModel,
          final RequestState? uploadImageState,
          final RequestState? deleteProductState,
          final RequestState? updateProductState,
          final String? colors,
           final RequestState? searchProductsState,
  final List<SearchProductResponse>? searchProducts
          }) =>
      ProductState(
        addProductsState: addProductsState ?? this.addProductsState,
        updateProductState: updateProductState ?? this.updateProductState,
        images: images ?? this.images,
        sizes: sizes ?? this.sizes,
        marka: marka ?? this.marka,
        colors: colors ?? this.colors,
        uploadImageState: uploadImageState ?? this.uploadImageState,
        optionsState: optionsState ?? this.optionsState,
        categoryModel: categoryModel ?? this.categoryModel,
        deleteProductState: deleteProductState ?? this.deleteProductState,
        currentPageSlider: currentPageSlider ?? this.currentPageSlider,
          searchProductsState: searchProductsState ?? this.searchProductsState,
        searchProducts: searchProducts ?? this.searchProducts,
      );

  @override
  List<Object?> get props => [
        currentPageSlider,
        addProductsState,
        images,
        sizes,
        colors,
        categoryModel,
        marka,
        optionsState,
        uploadImageState,
        deleteProductState,
        updateProductState,
        searchProductsState,
        searchProducts
      ];
}
