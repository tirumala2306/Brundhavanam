import 'package:brundhavanam/core/themes/app_typography.dart';
import 'package:brundhavanam/core/utils/screenutils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhone = false,
    this.maxLength,
    this.maxLines = 1,
    this.readOnly = false,
    this.labelText,
    this.textCapitalization = TextCapitalization.none,
    this.borderRadius = 4.0,
    this.focusNode,
    this.autofocus = false,
    this.hasError = false,
    this.errorText,
    this.floatingLabelBehavior,
    this.lineHeight,
    this.isRequired = false,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    this.floatingLabelColor,
    this.contentPadding,
    this.onTapOutside = true,
    super.key,
  });

  factory CustomTextField.email({
    required TextEditingController controller,
    String? Function(String?)? validator,
    String? labelText,
    bool hasError = false,
    void Function(String)? onChanged,
    String? errorText,
    bool isRequired = false,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? focusedErrorBorderColor,
    Color? floatingLabelColor,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return CustomTextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      isEmail: true,
      validator: validator,
      labelText: labelText,
      hasError: hasError,
      onChanged: onChanged,
      errorText: errorText,
      isRequired: isRequired,
      enabledBorderColor: enabledBorderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      focusedErrorBorderColor: focusedErrorBorderColor,
      floatingLabelColor: floatingLabelColor,
      inputFormatters: inputFormatters,
    );
  }

  factory CustomTextField.password({
    required TextEditingController controller,
    required String labelText,
    FocusNode? focusNode,
    bool autofocus = false,
    String? Function(String?)? validator,
    bool hasError = false,
    void Function(String)? onChanged,
    String? errorText,
    bool isRequired = false,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? focusedErrorBorderColor,
    Color? floatingLabelColor,
  }) {
    return CustomTextField(
      controller: controller,
      labelText: labelText,
      isPassword: true,
      obscureText: true,
      validator: validator,
      focusNode: focusNode,
      autofocus: autofocus,
      hasError: hasError,
      onChanged: onChanged,
      errorText: errorText,
      maxLength: 20,
      isRequired: isRequired,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')), // Prevent spaces
      ],
      enabledBorderColor: enabledBorderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      focusedErrorBorderColor: focusedErrorBorderColor,
      floatingLabelColor: floatingLabelColor,
    );
  }

  factory CustomTextField.phone({
    required TextEditingController controller,
    String? hintText,
    String? Function(String?)? validator,
    bool hasError = false,
    void Function(String)? onChanged,
    String? errorText,
    bool isRequired = false,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? focusedErrorBorderColor,
    Color? floatingLabelColor, required Text prefixIcon,
  }) {
    return CustomTextField(
      controller: controller,
      hintText: hintText ?? 'Phone',
      keyboardType: TextInputType.phone,
      isPhone: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: validator,
      prefixIcon: const Icon(Icons.phone_outlined),
      hasError: hasError,
      onChanged: onChanged,
      errorText: errorText,
      isRequired: isRequired,
      enabledBorderColor: enabledBorderColor,
      focusedBorderColor: focusedBorderColor,
      errorBorderColor: errorBorderColor,
      focusedErrorBorderColor: focusedErrorBorderColor,
      floatingLabelColor: floatingLabelColor,
    );
  }

  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final bool isEmail;
  final bool isPhone;
  final int? maxLength;
  final int maxLines;
  final bool readOnly;
  final String? labelText;
  final TextCapitalization textCapitalization;
  final double borderRadius;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool hasError;
  final String? errorText;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final double? lineHeight;
  final bool isRequired;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;
  final Color? floatingLabelColor;
  final EdgeInsets? contentPadding;
  final bool onTapOutside;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode()
      ..addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    // Use post-frame callback to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isFocused = _focusNode.hasFocus;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.lineHeight != null
        ? AppTypography.semibold.copyWith(height: widget.lineHeight)
        : AppTypography.semibold;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, child) {
        return TextFormField(
          controller: _controller,
          obscureText: _obscureText,
          obscuringCharacter: '●',
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          textCapitalization: widget.textCapitalization,
          keyboardAppearance: Brightness.dark,
          cursorColor: Theme.of(context).colorScheme.onSurface,
          cursorWidth: ScreenUtil.buildWidth(1),
          cursorHeight: ScreenUtil.buildHeight(16),
          autofocus: widget.autofocus,
          focusNode: _focusNode,
          style: textStyle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            contentPadding: widget.contentPadding,
            hintText: widget.hintText,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            errorText: widget.hasError ? widget.errorText : null,
            prefixIcon: widget.prefixIcon,
            suffixIcon:
                widget.isPassword && (_isFocused || value.text.isNotEmpty)
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_rounded
                          : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: () {
                      // Use post-frame callback to avoid setState during build
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        }
                      });
                    },
                  )
                : widget.suffixIcon,
            hintStyle: AppTypography.semibold,
            label: widget.labelText != null
                ? Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil.buildHeight(6)),
                    child: RichText(
                      text: TextSpan(
                        text: widget.labelText,
                        style: textStyle.copyWith(
                          color: widget.hasError
                              ? Theme.of(context).colorScheme.error
                              : _isFocused
                              ? widget.floatingLabelColor ??
                                    Theme.of(context).colorScheme.primary
                              : Colors.black
                        ),
                        children: widget.isRequired
                            ? [
                                TextSpan(
                                  text: '*',
                                  style: textStyle.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ]
                            : [],
                      ),
                    ),
                  )
                : null,
            labelStyle: textStyle.copyWith(
              color: widget.hasError
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            floatingLabelStyle: textStyle.copyWith(
              color: widget.hasError
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            errorStyle: AppTypography.semibold.copyWith(
              color: Theme.of(context).colorScheme.error,
              height: 1.2,
              fontSize: ScreenUtil.buildFontSize(12),
            ),
            errorMaxLines: 2,
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ScreenUtil.buildWidth(widget.borderRadius),
              ),
              borderSide: BorderSide(
                color: widget.hasError
                    ? (widget.errorBorderColor ??
                          Theme.of(context).colorScheme.error)
                    : (widget.enabledBorderColor ??
                          Theme.of(context).colorScheme.outlineVariant),
                width: ScreenUtil.buildWidth(1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ScreenUtil.buildWidth(widget.borderRadius),
              ),
              borderSide: BorderSide(
                color: widget.hasError
                    ? (widget.focusedErrorBorderColor ??
                          Theme.of(context).colorScheme.error)
                    : (widget.focusedBorderColor ??
                          Theme.of(context).colorScheme.primary),
                width: ScreenUtil.buildWidth(2),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ScreenUtil.buildWidth(widget.borderRadius),
              ),
              borderSide: BorderSide(
                color:
                    widget.errorBorderColor ??
                    Theme.of(context).colorScheme.error,
                width: ScreenUtil.buildWidth(1),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ScreenUtil.buildWidth(widget.borderRadius),
              ),
              borderSide: BorderSide(
                color:
                    widget.focusedErrorBorderColor ??
                    Theme.of(context).colorScheme.error,
                width: ScreenUtil.buildWidth(2),
              ),
            ),
            counterText: '',
          ),
          onTapOutside: widget.onTapOutside
              ? (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              : null,
          // onTapOutside: (event) {
          // FocusManager.instance.primaryFocus?.unfocus();
          // },
        );
      },
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode
        ..removeListener(_handleFocusChange)
        ..dispose();
    }
    super.dispose();
  }
}
