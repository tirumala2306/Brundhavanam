import 'package:brundhavanam/features/registration/bloc/auth_bloc.dart';
import 'package:brundhavanam/features/registration/bloc/auth_event.dart';
import 'package:brundhavanam/features/registration/bloc/auth_states.dart';
import 'package:brundhavanam/widgets/unified_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatefulWidget {
  final String mobile;
  const OtpScreen({super.key, required this.mobile});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final int otpLength = 6;

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
  }

  bool get isOtpComplete => controllers.every((c) => c.text.isNotEmpty);

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < otpLength - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    }

    setState(() {});
  }

  void onBackspace(String value, int index) {
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = isOtpComplete;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is OtpVerifySuccess){
          context.go('/success');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
      
                /// Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
      
                const SizedBox(height: 20),
      
                /// Title
                const Center(
                  child: Text(
                    "Enter the OTP we’ve sent to",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
      
                const SizedBox(height: 8),
      
                Center(
                  child: Text(
                    "+91${widget.mobile}",
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
      
                const SizedBox(height: 40),
      
                /// OTP Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    otpLength,
                    (index) => SizedBox(
                      width: 55,
                      height: 55,
                      child: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.length > 1) {
                            controllers[index].text = value[value.length - 1];
                          }
                          onOtpChanged(value, index);
                        },
                        onSubmitted: (value) => onBackspace(value, index),
                      ),
                    ),
                  ),
                ),
      
                const SizedBox(height: 40),
      
                /// Verify Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: UnifiedButton(
                    onTap: isEnabled
                        ? () {
                            final otp = controllers.map((e) => e.text).join();
      
                            context.read<AuthBloc>().add(
                              VerifyOtpEvent(widget.mobile, otp),
                            );
                          }
                        : null,
      
                    child: const Text(
                      "VERIFY OTP",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
      
                const SizedBox(height: 16),
      
                /// Resend Text
                const Center(
                  child: Text(
                    "Didn’t receive OTP? Get it on Whatsapp 0:59",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
