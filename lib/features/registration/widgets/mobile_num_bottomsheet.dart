import 'package:brundhavanam/core/constants/string_constants.dart';
import 'package:brundhavanam/core/themes/app_colors.dart';
import 'package:brundhavanam/core/themes/app_typography.dart';
import 'package:brundhavanam/core/utils/screenutils.dart';
import 'package:brundhavanam/features/registration/bloc/auth_bloc.dart';
import 'package:brundhavanam/features/registration/bloc/auth_event.dart';
import 'package:brundhavanam/features/registration/bloc/auth_states.dart';
import 'package:brundhavanam/widgets/custom_text_field.dart';
import 'package:brundhavanam/widgets/unified_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MobileNumBottomSheet extends StatefulWidget {
  const MobileNumBottomSheet({super.key});

  @override
  State<MobileNumBottomSheet> createState() => _MobileNumBottomSheetState();
}

class _MobileNumBottomSheetState extends State<MobileNumBottomSheet> {
  final TextEditingController _mobileController = TextEditingController();

  void _getOTP() {
    final mobile = _mobileController.text.trim();

    if (mobile.length == 10) {
      context.read<AuthBloc>().add(SendOtpEvent(mobile));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpSentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(StringConstants.otpSentSuccessfully)),
          );
          Navigator.pop(context);
          context.push('/otp', extra: _mobileController.text);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Text(
              StringConstants.sacredCompanion,
              style: AppTypography.medium.copyWith(
                fontSize: ScreenUtil.buildFontSize(24),
              ),
            ),
            SizedBox(height: ScreenUtil.buildHeight(31)),
            Text(
              StringConstants.loginOrSignup,
              textAlign: TextAlign.center,
              style: AppTypography.semibold.copyWith(color: AppColors.grey),
            ),
            SizedBox(height: ScreenUtil.buildHeight(37)),
            CustomTextField(
              keyboardType: TextInputType.phone,
              isPhone: true,
              maxLength: 10,
              controller: _mobileController,
              hintText: StringConstants.mobileNumber,
              prefixIcon: Text(
                StringConstants.indiaCode,
                textAlign: TextAlign.center,
                style: AppTypography.semibold.copyWith(color: AppColors.grey),
              ),
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(height: ScreenUtil.buildHeight(24)),
            UnifiedButton(
              onTap: _getOTP,
              backgroundColor: AppColors.primary,
              child: Text(
                StringConstants.getOtp,
                style: AppTypography.semibold,
              ),
            ),
            SizedBox(height: ScreenUtil.buildHeight(12)),
            TextButton(
              onPressed: () {},
              child: Text(
                StringConstants.skip,
                style: AppTypography.regular.copyWith(
                  fontSize: ScreenUtil.buildFontSize(16),
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: ScreenUtil.buildHeight(12)),
            Text(
              StringConstants.consentText,
              style: AppTypography.medium.copyWith(
                fontSize: ScreenUtil.buildFontSize(12),
                color: AppColors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ScreenUtil.buildHeight(24)),
          ],
        ),
      ),
    );
  }
}
