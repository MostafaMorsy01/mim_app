import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Address/ViewModel/address_view_model.dart';
import 'package:meem_app/Modules/Authentication/Views/forget_password_view.dart';
import 'package:meem_app/Modules/Authentication/Views/login_view.dart';
import 'package:meem_app/Modules/Authentication/Views/phone_verification_view.dart';
import 'package:meem_app/Modules/Authentication/Views/reset_password_view.dart';
import 'package:meem_app/Modules/BottomNavbar/Views/bottom_navbar_view.dart';
import 'package:meem_app/Modules/Cart/ViewModel/add_to_cart_view_model.dart';
import 'package:meem_app/Modules/Cart/ViewModel/cart_view_model.dart';
import 'package:meem_app/Modules/Cart/ViewModel/delete_cart_item_view_model.dart';
import 'package:meem_app/Modules/Cart/ViewModel/update_cart_view_model.dart';
import 'package:meem_app/Modules/Favourite/ViewModel/list_favourite_view_model.dart';
import 'package:meem_app/Modules/Home/ViewModel/home_view_model.dart';
import 'package:meem_app/Modules/Home/Views/home_view.dart';
import 'package:meem_app/Modules/ListOrder/ViewModel/order_list_view_model.dart';
import 'package:meem_app/Modules/Products/ViewModel/product_detail_view_model.dart';
import 'package:meem_app/Modules/Products/ViewModel/product_favourite_view_model.dart';
import 'package:meem_app/Modules/Profile/Complaint/ViewModel/complaint_view_model.dart';
import 'package:meem_app/Modules/Profile/ProfileEdit/ViewModel/profile_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Authentication/Views/signup_view.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/ViewModel/payment_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Profile/ViewModel/shipping_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/ViewModel/categories_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/ViewModel/sp_add_product_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/ViewModel/sp_my_products_view_model.dart';
import 'package:meem_app/Modules/Service%20Provider/Sp_Products/Views/add_product_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../Constants/app_colors.dart';
import '../Constants/app_constants.dart';
import '../Services/version_check_service.dart';
import 'Modules/Authentication/Views/signup_view.dart.dart';
import 'Modules/Authentication/authentication_view_model.dart';
import 'Modules/Order/ViewModel/order_view_model.dart';
import 'Modules/Products/ViewModel/product_view_model.dart';
import 'Modules/Products/Views/products_list_view.dart';
import 'Modules/Service Provider/Authentication/sp_authentication_view_model.dart';
import 'Modules/Service Provider/Profile/Views/customer_reviews_view.dart';
import 'Modules/Service Provider/Sp_Products/ViewModel/specification_view_model.dart';
import 'Modules/Service Provider/Sp_Products/Views/my_products_view.dart';
import 'Modules/Service Provider/Profile/Views/payment_options_view.dart';
import 'Modules/Service Provider/Profile/Views/profile_view.dart';
import 'Modules/Service Provider/Profile/Views/shipping_options_view.dart';
import 'Modules/Service Provider/Profile/Views/subscription_view.dart';

class MeemApp extends StatefulWidget {
  static BuildContext? contexts;

  const MeemApp({Key? key}) : super(key: key);

  @override
  State<MeemApp> createState() => _MeemAppState();
}

class _MeemAppState extends State<MeemApp> {
  GlobalKey<NavigatorState>? navigatorKey = GlobalKey();

  AuthenticationViewModel authenticationViewModel = AuthenticationViewModel();
  SpAuthenticationViewModel spAuthenticationViewModel =
      SpAuthenticationViewModel();
  HomeViewModel homeViewModel = HomeViewModel();
  SpProductsViewModel sp_productsViewModel = SpProductsViewModel();
  CartViewModel cartViewModel = CartViewModel();
  ProductsViewModel productsViewModel = ProductsViewModel();
  ProductsDetailsViewModel productsDetailsViewModel =
      ProductsDetailsViewModel();
  AddToCartViewModel addToCartViewModel = AddToCartViewModel();
  AddToFavouriteViewModel addToFavouriteViewModel = AddToFavouriteViewModel();
  DeleteItemCartViewModel deleteItemCartViewModel = DeleteItemCartViewModel();
  UpdateCartViewModel updateCartViewModel = UpdateCartViewModel();
  SpecificationViewModel specificationViewModel = SpecificationViewModel();
  CategoriesViewModel categoriesViewModel = CategoriesViewModel();
  VersionCheckService versionCheckService = VersionCheckService();
  SpAddProductViewModel addProductViewModel = SpAddProductViewModel();
  ListFavouriteViewModel listFavouriteViewModel = ListFavouriteViewModel();
  AddressViewModel addressViewModel = AddressViewModel();
  OrderViewModel orderViewModel = OrderViewModel();
  ProfileViewModel profileViewModel = ProfileViewModel();
  ComplaintViewModel complaintViewModel = ComplaintViewModel();
  OrderListViewModel orderListViewModel = OrderListViewModel();
  PaymentViewModel paymentViewModel = PaymentViewModel();
  ShippingMethodViewModel shippingMethodViewModel = ShippingMethodViewModel();

  late Future myFuture;

  @override
  void initState() {
    // myFuture = authenticationViewModel.getProfile(context);
    AppConstants.navigatorKey = navigatorKey;
    super.initState();
  }

  @override
  void dispose() {
    authenticationViewModel = AuthenticationViewModel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: authenticationViewModel,
        ),
        ChangeNotifierProvider.value(
          value: versionCheckService,
        ),
        ChangeNotifierProvider.value(
          value: spAuthenticationViewModel,
        ),
        ChangeNotifierProvider.value(
          value: homeViewModel,
        ),
        ChangeNotifierProvider.value(
          value: sp_productsViewModel,
        ),
        ChangeNotifierProvider.value(
          value: productsViewModel,
        ),
        ChangeNotifierProvider.value(
          value: productsDetailsViewModel,
        ),
        ChangeNotifierProvider.value(
          value: cartViewModel,
        ),
        ChangeNotifierProvider.value(
          value: addToCartViewModel,
        ),
        ChangeNotifierProvider.value(
          value: specificationViewModel,
        ),
        ChangeNotifierProvider.value(
          value: categoriesViewModel,
        ),
        ChangeNotifierProvider.value(
          value: addProductViewModel,
        ),
        ChangeNotifierProvider.value(
          value: addToFavouriteViewModel,
        ),
        ChangeNotifierProvider.value(
          value: deleteItemCartViewModel,
        ),
        ChangeNotifierProvider.value(
          value: updateCartViewModel,
        ),
        ChangeNotifierProvider.value(
          value: listFavouriteViewModel,
        ),
        ChangeNotifierProvider.value(
          value: addressViewModel,
        ),
        ChangeNotifierProvider.value(
          value: orderViewModel,
        ),
        ChangeNotifierProvider.value(
            value: profileViewModel
        ),
        ChangeNotifierProvider.value(
            value: complaintViewModel
        ),
        ChangeNotifierProvider.value(
            value: orderListViewModel
        ),
        ChangeNotifierProvider.value(
            value: paymentViewModel
        ),
        ChangeNotifierProvider.value(
            value: shippingMethodViewModel
        ),
      ],
      child: Consumer<AuthenticationViewModel>(
        builder: (ctx, auth, _) => MaterialApp(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          title: "Meem",
          locale: const Locale("ar"),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English, no country code
            Locale('ar'), // Arabic, no country code
          ],
          theme: ThemeData(
            primarySwatch: mainMaterialColor,
            canvasColor: Colors.white,
          ),
          // home: const LoginView(),
          home: auth.authenticated
              ? auth.isUserSelected
                  ? const BottomNavbarView()
                  : const SpProfileView()
              : const LoginView(),
          // : FutureBuilder(
          //     future: myFuture,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         return const LoginView();
          //       } else {
          //         return const SplachScreen();
          //       }
          //     },
          // ),
          navigatorKey: navigatorKey,
          routes: {
            HomeView.routeName: (ctx) => const HomeView(),
            SpSignupView.routeName: (ctx) => const SpSignupView(),
            SpProfileView.routeName: (ctx) => const SpProfileView(),
            SpCustomerReviewsView.routeName: (ctx) =>
                const SpCustomerReviewsView(),
            SpPaymentOptionsView.routeName: (ctx) =>
                const SpPaymentOptionsView(),
            SpSubscriptionView.routeName: (ctx) => const SpSubscriptionView(),
            SpShippingOptionsView.routeName: (ctx) =>
                const SpShippingOptionsView(),
            SpMyProductsView.routeName: (ctx) => const SpMyProductsView(),
            SignupView.routeName: (ctx) => const SignupView(),
            PhoneVerificationView.routeName: (ctx) =>
                const PhoneVerificationView(),
            LoginView.routeName: (ctx) => const LoginView(),
            ForgetPasswordView.routeName: (ctx) => const ForgetPasswordView(),
            ResetPasswordView.routeName: (ctx) => const ResetPasswordView(),
            // AddProductView.routeName: (ctx) => const AddProductView(),
            // ProductsListView.routeName: (ctx) => const ProductsListView(),
          },
        ),
      ),
    );
  }
}

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  late VersionCheckService versionCheckService;

  @override
  void initState() {
    versionCheckService =
        Provider.of<VersionCheckService>(context, listen: false);
    Future.microtask(() async {
      //await versionCheckService.checkVersion(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          width: deviceSize.width * 0.4,
        ),
      ),
    );
  }
}
