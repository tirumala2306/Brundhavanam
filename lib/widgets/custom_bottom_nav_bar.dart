import 'package:flutter/material.dart';
import 'package:brundhavanam/core/themes/app_typography.dart';
import 'package:brundhavanam/core/utils/screenutils.dart';
import 'package:brundhavanam/core/constants/asset_constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
    this.selectedColor = Colors.green,
    this.unselectedColor = Colors.grey,
    super.key,
  });

  final int selectedIndex;
  final void Function(int) onItemTapped;
  final Color selectedColor;
  final Color unselectedColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(width: 2)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color.fromRGBO(178, 232, 192, 0.8),
            Color.fromRGBO(70, 158, 99, 0.9),
          ],
          stops: [0.0567, 0.6595, 1],
        ),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (states) => states.contains(WidgetState.selected)
                ? AppTypography.h1.copyWith(
                    fontWeight: FontWeight.w700,
                    color: selectedColor,
                  )
                : AppTypography.h1.copyWith(
                    fontSize: ScreenUtil.buildFontSize(14),
                    color: unselectedColor,
                  ),
          ),
        ),
        child: NavigationBar(
          indicatorColor: Colors.transparent,
          height: ScreenUtil.buildHeight(64),
          selectedIndex: selectedIndex,
          onDestinationSelected: onItemTapped,
          destinations: [
            _navItem(AssetConstants.homeIcon, "Home", 0),
            _navItem(AssetConstants.rentCowIcon, "Rent Cow", 1),
            _navItem(AssetConstants.productIcon, "Products", 2),
            _navItem(AssetConstants.cartIcon, "Cart", 3),
            _navItem(AssetConstants.profileIcon, "Profile", 4),
          ],
        ),
      ),
    );
  }

  NavigationDestination _navItem(String asset, String label, int index) {
    return NavigationDestination(
      icon: Image.asset(
        asset,
        height: ScreenUtil.buildHeight(24),
        color: unselectedColor,
      ),
      selectedIcon: Image.asset(
        asset,
        height: ScreenUtil.buildHeight(24),
        color: selectedColor,
      ),
      label: label,
    );
  }
}
