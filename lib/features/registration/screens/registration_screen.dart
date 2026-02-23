import 'package:brundhavanam/core/constants/asset_constants.dart';
import 'package:brundhavanam/core/constants/string_constants.dart';
import 'package:brundhavanam/core/themes/app_colors.dart';
import 'package:brundhavanam/core/themes/app_typography.dart';
import 'package:brundhavanam/core/utils/screenutils.dart';
import 'package:brundhavanam/features/registration/bloc/auth_bloc.dart';
import 'package:brundhavanam/features/registration/widgets/mobile_num_bottomsheet.dart';
import 'package:brundhavanam/widgets/custom_bottom_sheet.dart';
import 'package:brundhavanam/widgets/unified_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<Map<String, dynamic>> pages = [
    {
      'image': AssetConstants.registerImage1,
      'title': 'Honor traditions the authentic way.',
      'points': [
        'Cow & calf rent for house-warming and sacred ceremonies.',
        'Pure, peaceful, and handled with care.',
      ],
    },
    {
      'image': AssetConstants.registerImage2,
      'title': 'From our goshala to your home.',
      'points': [
        'Fresh milk and traditional dairy products.',
        'Prepared with devotion and delivered with trust.',
      ],
    },
    {
      'image': AssetConstants.registerImage3,
      'title': 'Become part of a living tradition.',
      'points': [
        'Care for our cows, contribute with devotion.',
        'Stay connected to the goshala, wherever you are.',
      ],
    },
  ];

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
  }

  void _next() async {
    if (_index < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      await _finish();
    }
  }

  void _skip() {
    final lastIndex = pages.length - 1;

    _controller.animateToPage(
      lastIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );

    setState(() {
      _index = lastIndex;
    });
  }

  void _mobileScreen() {
    final authBloc = context.read<AuthBloc>();

    CustomBottomSheet.show(
      context: context,

      child: Builder(
        builder: (sheetContext) {
          return BlocProvider.value(
            value: authBloc,

            child: const MobileNumBottomSheet(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: _controller,
          itemCount: pages.length,
          onPageChanged: (i) => setState(() => _index = i),
          itemBuilder: (_, i) {
            final data = pages[i];
            final isLast = i == pages.length - 1;

            return Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(data['image'], fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: ScreenUtil.buildHeight(16),
                        right: ScreenUtil.buildHeight(16),
                        child: CircleAvatar(
                          radius: ScreenUtil.buildHeight(50),
                          backgroundColor: AppColors.white,
                          child: Image.asset(AssetConstants.logo, height: 150),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil.buildHeight(24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isLast)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Visibility(
                                visible: !isLast,
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                child: GestureDetector(
                                  onTap: _skip,
                                  child: const Text(
                                    StringConstants.skip,
                                    style: AppTypography.h1,
                                  ),
                                ),
                              ),
                            ),

                          SizedBox(height: ScreenUtil.buildHeight(10)),

                          Text(data['title'], style: AppTypography.h1),

                          const SizedBox(height: 16),

                          ...List.generate(
                            data['points'].length,
                            (idx) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: ScreenUtil.buildWidth(8)),
                                  Expanded(
                                    child: Text(
                                      data['points'][idx],
                                      style: AppTypography.body,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // LEFT ARROW
                              Visibility(
                                visible: _index > 0,
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                child: IconButton(
                                  onPressed: () {
                                    _controller.previousPage(
                                      duration: const Duration(
                                        milliseconds: 400,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),

                              // DOTS
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  pages.length,
                                  (dotIndex) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: _index == dotIndex
                                          ? AppColors.primary
                                          : AppColors.lightGrey,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),

                              // RIGHT ARROW
                              Visibility(
                                visible: _index < pages.length - 1,
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                child: IconButton(
                                  onPressed: _next,
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          Visibility(
                            visible: isLast,
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: UnifiedButton(
                                onTap: _mobileScreen,
                                child: Text(
                                  "Get Started",
                                  style: AppTypography.semibold.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
