class ApiConstants {
  // static const googleKey = "AIzaSyCHcAKXFZuQ8WhkAvW1zv3MTVibHU9EuF0";

static const apiGoogleMapKey ="AIzaSyD6khcrjnt6bBk5TXIfbESW6GoprKc_knE";
 // static const baseUrl = "https://3b67-197-38-50-204.ngrok-free.app";

   static const baseUrl = "https://hatli.sa";
  static const baseUrlImages = "$baseUrl/images/";
  static const checkUserPath = "$baseUrl/check-username";
 static const  deleteAccount = "$baseUrl/delete-account";
  static const loginPath = "$baseUrl/user-login";
  static const signUpPath = "$baseUrl/signup";
  static const uploadImagesPath = "$baseUrl/image/upload/image";
  static const changeStatusTripPath = "$baseUrl/trips/change_status_trip";
  static const getCarTypesPath = "$baseUrl/carTypes/get_car_types";
  static const getHistoriesPath = "$baseUrl/trips/histories-user";
  static const addTripPath = "$baseUrl/trips/add-trip";
  static const getNotificationsPath =
      "$baseUrl/notification/get-notifications?UserId=";
  static const updateDeviceTokenPath = "$baseUrl/update-device-token";
  static const homeTripsPath = "$baseUrl/trips/home_user";
  static const getUserPath = "$baseUrl/get-user";
  static const updateUserPath = "$baseUrl/update-user";
  static const addRatePath = "$baseUrl/rates/add-rate";
  static const getTripsPath = "$baseUrl/trips/add-trip";
  static const addNewAddress = "$baseUrl/address/add-address";
   static const getProductsByProviderId = "$baseUrl//product/get-Products-By-providerId-page?";
  static const getFavoritesPath = "$baseUrl/Favorite/get-favorites?";
  static String imageUrl(path) => baseUrlImages + path;

  // local Storage constants
  static const langKey = "lang";
  static const tokenKey = "token";
  static const phoneKey = "phone";
  static const userIdKey = "id";
  static const emailKey = "email";
  static const roleKey = "role";
  static const imageKey = "image";
  static const nameKey = "name";
}
