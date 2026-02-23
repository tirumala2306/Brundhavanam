import 'package:brundhavanam/core/themes/app_colors.dart';
import 'package:brundhavanam/core/utils/screenutils.dart';
import 'package:flutter/material.dart';

enum ButtonVariant { filled, outlined }

class UnifiedButton extends StatelessWidget {
  const UnifiedButton({
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.isEnabled = true,
    this.borderRadius = 8,
    this.variant = ButtonVariant.filled,
    this.splashFactory,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final bool isEnabled;
  final double borderRadius;
  final ButtonVariant variant;
  final InteractiveInkFeatureFactory? splashFactory;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(ScreenUtil.buildWidth(borderRadius));

    final buttonHeight = height ?? ScreenUtil.buildHeight(42);

    if (variant == ButtonVariant.outlined) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          splashFactory: splashFactory ?? NoSplash.splashFactory,
          borderRadius: radius,
          onTap: isEnabled ? onTap : null,
          child: Container(
            width: width, // 🔑 no forced width
            height: buttonHeight,
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil.buildWidth(16),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor ?? Theme.of(context).colorScheme.primary,
              ),
              borderRadius: radius,
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      );
    }

    return Material(
      color: backgroundColor ?? AppColors.primary,
      borderRadius: radius,
      child: InkWell(
        splashFactory: splashFactory,
        borderRadius: radius,
        onTap: isEnabled ? onTap : null,
        child: Container(
          width: width, // 🔑 no forced width
          height: buttonHeight,
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil.buildWidth(16)),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
