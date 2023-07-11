import '../../common/models/category.dart';
import '../../common/models/product.dart';
import '../../common/models/provider.dart';
import '../../common/models/user_response.dart';

class DetailsProviderResponse {
  List<Product>? products;
  List<CategoryModel>? categories;
  Provider? provider;
  UserModel? user;

  DetailsProviderResponse({
    this.products,
    this.categories,
    this.provider,
    this.user,
  });

  DetailsProviderResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(CategoryModel.fromJson(v));
      });
    }

    provider =
        json['provider'] != null ? Provider.fromJson(json['provider']) : null;
    user = json['userDetail'] != null
        ? UserModel.fromJson(json['userDetail'])
        : null;
  }
}
