import 'package:flutter/material.dart';
import 'package:brundhavanam/core/themes/app_colors.dart';

class CustomBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isScrollControlled = true,
    bool showDragIndicator = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (_) => _BottomSheetContainer(
        title: title,
        showDragIndicator: showDragIndicator,
        child: child,
      ),
    );
  }
}

class _BottomSheetContainer extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool showDragIndicator;

const _BottomSheetContainer({
  required this.child,
  this.title,
  required this.showDragIndicator,
});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: mediaQuery.viewInsets.bottom, // Handles keyboard
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: mediaQuery.size.height * 0.9, // Prevent overflow
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjust height by content
          children: [
            /// Optional Drag Indicator UI (only visual)
            if (showDragIndicator) ...[
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],

            /// Optional Title
            if (title != null) ...[
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
            ],

            /// Scrollable only when needed
            Flexible(
              child: SingleChildScrollView(
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}