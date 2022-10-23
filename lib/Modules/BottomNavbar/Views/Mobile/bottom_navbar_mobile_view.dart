import 'package:flutter/material.dart';
import 'package:meem_app/Constants/app_assets.dart';
import 'package:meem_app/Constants/app_colors.dart';
import 'package:meem_app/Constants/app_fonts.dart';
import 'package:meem_app/Localization/app_localization.dart';
import 'package:meem_app/Modules/Cart/Views/my_cart_view.dart';
import 'package:meem_app/Modules/Home/Views/home_view.dart';
import 'package:meem_app/Modules/Profile/Views/profile_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../Cart/ViewModel/cart_view_model.dart';

class BottomNavbarMobileView extends StatefulWidget {
  const BottomNavbarMobileView({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavbarMobileView> createState() => _BottomNavbarMobileViewState();
}

class _BottomNavbarMobileViewState extends State<BottomNavbarMobileView> {
  int _selectedIndex = 0;
  late CartViewModel cartViewModel;

  List<Widget> get _navBarScreens => [
        const HomeView(),
        const MyCartView(),
        const ProfileView(),
      ];

  Color get _activeColor => AppColors.primary;

  Color get _inactiveColor => AppColors.primary;
  var _isLoading = true;

  @override
  void initState() {
    cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    super.initState();
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView(
      context,
      controller: _controller,
      onItemSelected: onItemSelected,
      screens: _navBarScreens,
      items: _navBarItems(),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      // decoration: NavBarDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(
      //         0.28,
      //       ),
      //       offset: const Offset(0, -1),
      //       blurRadius: 48,
      //     ),
      //   ],
      // ),
      navBarStyle: NavBarStyle.style6,
    ));
  }

  void onItemSelected(int pageIndex) async {
    setState(
      () {
        _selectedIndex = pageIndex;
      },
    );
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage(
            AppAssets.homeFilled,
          ),
        ),
        inactiveIcon: const ImageIcon(
          AssetImage(
            AppAssets.homeOutlined,
          ),
        ),

        title: getTranslated(context, "main"),
        textStyle: const TextStyle(
            fontFamily: AppFonts.cairoFontRegular, fontSize: 12, height: 0.2),
        //routeAndNavigatorSettings: routeSettings,
        activeColorPrimary: _activeColor,
        inactiveColorPrimary: _inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage(
            AppAssets.shoppingCartFilled,
          ),
        ),
        inactiveIcon: const ImageIcon(
          AssetImage(
            AppAssets.shoppingCartOutlined,
          ),
        ),
        title: getTranslated(context, "cart"),
        textStyle: const TextStyle(
            fontFamily: AppFonts.cairoFontRegular, fontSize: 12, height: 0.2),
        //routeAndNavigatorSettings: routeSettings,
        activeColorPrimary: _activeColor,
        inactiveColorPrimary: _inactiveColor,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage(
            AppAssets.profileFilled,
          ),
        ),
        inactiveIcon: const ImageIcon(
          AssetImage(
            AppAssets.profileOutlined,
          ),
        ),
        iconSize: 80,
        title: getTranslated(context, "my_profile"),
        textStyle: const TextStyle(
            fontFamily: AppFonts.cairoFontRegular, fontSize: 12, height: 0.2),
        //routeAndNavigatorSettings: routeSettings,
        activeColorPrimary: _activeColor,
        inactiveColorPrimary: _inactiveColor,
      ),
    ];
  }
}
