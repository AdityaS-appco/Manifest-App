import 'package:manifest/features/playlist/by_you/widgets/common/transparent_svg_circle_button.dart';
import 'package:manifest/helper/import.dart';

class AppTextField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool readOnly;
  final String? prefixIconPath;
  final VoidCallback? onTextFieldTap;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final bool isPassword;
  final bool obscureText;
  final Color? titleColor;
  final bool hasPrefix;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final Function(String?)? onChanged;
  final int? maxLength;
  final int? maxLines;
  final bool hasCounter;
  final Color? borderColor;

  const AppTextField({
    super.key,
    this.title,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.controller,
    this.readOnly = false,
    this.prefixIconPath,
    this.onTextFieldTap,
    this.contentPadding,
    this.backgroundColor,
    this.isPassword = false,
    this.obscureText = false,
    this.titleColor,
    this.hasPrefix = true,
    this.textAlign,
    this.textStyle,
    this.onChanged,
    this.maxLength,
    this.maxLines = 1,
    this.hasCounter = false,
    this.borderColor,
  });

  factory AppTextField.email({
    Key? key,
    required TextEditingController controller,
    String? Function(String?)? validator,
    String? title,
    Color? titleColor,
    String? hintText,
    bool hasPrefix = true,
    Function(String?)? onChanged,
  }) {
    return AppTextField(
      key: key,
      title: title ?? "Email",
      titleColor: titleColor,
      hintText: hintText ?? "Enter your email",
      controller: controller,
      validator: validator ?? FormValidatorUtil.email,
      keyboardType: TextInputType.emailAddress,
      prefixIconPath: IconAllConstants.mail02,
      hasPrefix: hasPrefix,
      onChanged: onChanged,
    );
  }

  factory AppTextField.password({
    Key? key,
    required TextEditingController controller,
    String? Function(String?)? validator,
    String? title,
    Color? titleColor,
    String? hintText,
    bool hasPrefix = true,
    bool canToggleVisibility = true,
    Function(String?)? onChanged,
  }) {
    return AppTextField(
      key: key,
      title: title ?? "Password",
      titleColor: titleColor,
      hintText: hintText ?? "Enter your password",
      controller: controller,
      validator: validator ?? FormValidatorUtil.password,
      keyboardType: TextInputType.visiblePassword,
      prefixIconPath: IconAllConstants.lock01,
      isPassword: true,
      obscureText: true,
      hasPrefix: hasPrefix,
      onChanged: onChanged,
    );
  }

  /// * Multiline textfield with optional character counter
  factory AppTextField.multiline({
    Key? key,
    required TextEditingController controller,
    String? Function(String?)? validator,
    String? title,
    Color? titleColor,
    String? hintText,
    int maxLength = 200,
    int maxLines = 6,
    bool hasCounter = false,
    Function(String?)? onChanged,
  }) {
    return AppTextField(
      key: key,
      title: title,
      titleColor: titleColor,
      hintText: hintText,
      controller: controller,
      validator: validator,
      maxLength: maxLength,
      maxLines: maxLines,
      hasCounter: hasCounter,
      onChanged: onChanged,
    );
  }

  /// * Factory for search textfield
  /// * Shows search icon, hint text and handles search functionality
  factory AppTextField.search({
    Key? key,
    required TextEditingController controller,
    required Function(String?) onSearchChanged,
    String? hintText,
    bool autofocus = false,
    VoidCallback? onSearchTap,
  }) {
    return AppTextField(
      key: key,
      controller: controller,
      hintText: hintText ?? AppStrings.whatDoYouWantToListenTo,
      prefixIconPath: IconAllConstants.searchMd,
      hasPrefix: true,
      onChanged: onSearchChanged,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
      backgroundColor: Colors.white.withOpacity(0.1),
      onTextFieldTap: onSearchTap,
      textStyle: Get.appTextTheme.searchBarText,
      borderColor: Colors.transparent,
      readOnly: true,
    );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hasCounter) {
      return _OutlinedTextFieldContainer(
        focusNode: _focusNode,
        controller: widget.controller,
        maxLength: widget.maxLength ?? 200,
        counterText:
            "${widget.controller?.text.length ?? 0} / ${widget.maxLength ?? 200}",
        child: _buildTextField(
          context,
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          showCounter: false,
        ),
      );
    }
    return _buildTextField(context, borderColor: widget.borderColor);
  }

  Widget _buildTextField(
    BuildContext context, {
    Color? backgroundColor,
    Color? borderColor,
    bool showCounter = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null && widget.title!.isNotEmpty) ...[
          Text(
            widget.title!,
            style: Get.appTextTheme.textFieldTitle.copyWith(
              color: widget.titleColor,
            ),
          ),
          16.height,
        ],
        TextFormField(
          focusNode: _focusNode,
          onTap: () {
            if (widget.onTextFieldTap != null) widget.onTextFieldTap!.call();
          },
          controller: widget.controller,
          cursorColor: Colors.white,
          maxLines: widget.maxLines,
          style: widget.textStyle ?? Get.appTextTheme.textFieldText,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          readOnly: widget.readOnly,
          textAlign: widget.textAlign ?? TextAlign.start,
          obscureText: widget.isPassword ? _obscureText : false,
          maxLength: widget.hasCounter ? widget.maxLength : null,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            contentPadding: widget.contentPadding ?? const EdgeInsets.all(16.0),
            hintText: widget.hintText,
            hintStyle: Get.appTextTheme.textFieldHintText,
            errorStyle: helveticaPageTitleTextStyle(
              color: AppColors.error,
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              height: 1.67,
            ),
            filled: true,
            isDense: true,
            fillColor:
                backgroundColor ?? widget.backgroundColor ?? textFieldBgColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: borderColor ?? AppColors.light.withOpacity(0.1),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: borderColor ?? AppColors.light.withOpacity(0.1),
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: borderColor ?? AppColors.light.withOpacity(0.1),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: borderColor ?? const Color(0xFF814AFF).withOpacity(0.5),
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: borderColor ?? AppColors.error,
                width: 1.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: borderColor ?? AppColors.error,
                width: 1.0,
              ),
            ),
            prefixIcon: widget.hasPrefix
                ? (widget.prefixIconPath != null
                    ? TransparentSvgCircleButton(
                        widget.prefixIconPath!,
                        iconSize: 20,
                        iconColor: Colors.white.withOpacity(0.5),
                      )
                    : widget.prefixIcon)
                : null,
            suffixIcon: widget.isPassword
                ? TransparentSvgCircleButton(
                    _obscureText
                        ? IconAllConstants.eyeOn
                        : IconAllConstants.eyeOff,
                    iconSize: 20,
                    iconColor: Colors.white.withOpacity(0.5),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            counterText: showCounter
                ? (widget.hasCounter
                    ? "${widget.controller!.text.length} / ${widget.maxLength}"
                    : "")
                : "",
          ),
          validator: widget.validator,
          onChanged: (value) {
            widget.onChanged?.call(value);
            if (widget.hasCounter) setState(() {});
          },
        ),
      ],
    );
  }
}

/// * Outlined container for multiline textfield with counter
class _OutlinedTextFieldContainer extends StatefulWidget {
  final Widget child;
  final FocusNode focusNode;
  final TextEditingController? controller;
  final int maxLength;
  final String counterText;

  const _OutlinedTextFieldContainer({
    required this.child,
    required this.focusNode,
    required this.controller,
    required this.maxLength,
    required this.counterText,
  });

  @override
  State<_OutlinedTextFieldContainer> createState() =>
      _OutlinedTextFieldContainerState();
}

class _OutlinedTextFieldContainerState
    extends State<_OutlinedTextFieldContainer> {
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _hasFocus = widget.focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // You can further modularize border color logic if needed
    final borderColor = _hasFocus
        ? AppColors.textFieldFocusColor
        : AppColors.light.withOpacity(0.1);

    return Container(
      decoration: BoxDecoration(
        color: textFieldBgColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          widget.child,
          Positioned(
            right: 16,
            bottom: 8,
            child: Text(
              widget.counterText,
              style: Get.appTextTheme.textFieldHintText.copyWith(
                height: 1.31,
                color: const Color(0xFF686868),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
