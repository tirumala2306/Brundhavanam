import 'package:brundhavanam/features/cart/screens/cart_screen.dart';
import 'package:brundhavanam/features/home/screens/home_screen.dart';
import 'package:brundhavanam/features/products/screens/products_screen.dart';
import 'package:brundhavanam/features/profile/screens/profile_screen.dart';
import 'package:brundhavanam/features/registration/screens/otp_screen.dart';
import 'package:brundhavanam/features/registration/screens/registration_screen.dart';
import 'package:brundhavanam/features/registration/screens/success.dart';
import 'package:brundhavanam/features/rent_cow/screens/rent_cow_screen.dart';
import 'package:brundhavanam/widgets/custom_bottom_nav_bar.dart';
import 'package:brundhavanam/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';

class AppRouter {
  /// Navigator Keys
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,

    routes: [
      /// Splash / Initial Screen
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),

      GoRoute(path: AppRoutes.home, builder: (_, _) => const HomeScreen()),

      GoRoute(
        path: AppRoutes.register,
        builder: (_, _) => const RegistrationScreen(),
      ),

      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final mobile = state.extra as String;

          return OtpScreen(mobile: mobile);
        },
      ),

      GoRoute(
        path: AppRoutes.success,
        builder: (_, _) => const SuccessScreen(),
      ),

      /// Bottom Navigation Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithBottomNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (_, _) => const HomeScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.product,
                builder: (_, _) => const ProductScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.cart,
                builder: (_, _) => const CartScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (_, _) => const ProfileScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.rentCow,
                builder: (_, _) => const RentCowScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class ScaffoldWithBottomNavigation extends StatefulWidget {
  const ScaffoldWithBottomNavigation({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithBottomNavigation> createState() =>
      _ScaffoldWithBottomNavigationState();
}

class _ScaffoldWithBottomNavigationState
    extends State<ScaffoldWithBottomNavigation>
    with WidgetsBindingObserver {
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (!mounted) return;

    final bottomInset = View.of(context).viewInsets.bottom;
    final isKeyboardVisible = bottomInset > 0;

    if (_isKeyboardVisible != isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = isKeyboardVisible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: widget.navigationShell),
      bottomNavigationBar: _isKeyboardVisible
          ? null
          : CustomBottomNavBar(
              selectedIndex: widget.navigationShell.currentIndex,
              onItemTapped: (index) =>
                  widget.navigationShell.goBranch(index, initialLocation: true),
              selectedColor: Theme.of(context).colorScheme.primary,
              unselectedColor: Colors.black,
            ),
    );
  }
}
