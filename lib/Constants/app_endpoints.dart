class EndPoints {
  // ignore: unused_field
  static const String _productionUrl = 'PROD'; //LIVE

  // ignore: unused_field
  static const String _devUrl = 'http://164.92.185.162/public/api';

  static const String baseUrl = _devUrl;
  static const String store = '/store';
  static const String register = '/register';
  static const String list = '/list';
  static const String data = '/data';
  static const String verify = '/verify';
  static const String registration = '/registration';
  static const String code = '/code';
  static const String codes = '/codes';
  static const String resend = '/resend';
  static const String forgot = '/forgot';
  static const String password = '/password';
  static const String reset = '/reset';
  static const String home = '/home';
  static const String store_products = '/store/product';
  static const String store_categories = '/store/categories';
  static const String store_add_products = '/store/product';
  static const String delete_product = '/store/product/destroy';
  static const String update_product = '/store/product/update';
  static const String get_products = '/store/products';
  static const String get_specification = '/store/specifications';
  static const String get_products_details = '/product';
  static const String add_favourite = '/favorite/toggle';
  static const String list_favourite = '/favorite';
  static const String list_address = '/address';
  static const String add_address = '/address';
  static const String delete_address = '/address/destroy';
  static const String search = '/search';

  static const String list_payment = "/store/payments";
  static const String add_payment = "/store/add/payment";
  static const String list_shipping = "/store/shippingCompanies";
  static const String add_shipping = "/store/add/shipping";

  // order end points
  static const String place_order = '/order/place';
  static const String order_summary = '/order';
  static const String payment_method = '/store/payments';
  static const String order_list = '/order/orders';
  static const String sp_order_list = '/store/order';
  static const String sp_order_status = '/store/order/change/status';






  // cart end points
  static const String add_cart = '/cart/add/product';
  static const String update_cart = '/cart/update/item';
  static const String view_cart = '/cart';
  static const String delete_item_cart = '/cart/destroy/item';

  static const String auth = '/auth';
  static const String signUp = '/signUp';
  static const String login = '/login';
  static const String changePassword = '/changePassword';
  static const String makeComplaint = '/complain';

  static const String checkResetPasswordCode = '/checkResetPasswordCode';
  static const String logout = '/logout';
  static const String continueWithFB = '/continueWithFacebook';
  static const String continueWithGoogle = '/continueWithGoogle';
  static const String continueWithApple = '/continueWithApple';
  static const String profile = '/profile';
  static const String sp_profile = '/store/profile';

  static const String version = '/version';
  static const String iOS = '/ios';
  static const String android = '/android';
  static const String continueAsGuest = '/continueAsAGuest';
}
