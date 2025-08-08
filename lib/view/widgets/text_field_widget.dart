import 'package:flutter_svg/flutter_svg.dart';
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
  });

  factory AppTextField.email({
    Key? key,
    required TextEditingController controller,
    String? Function(String?)? validator,
    String? title,
    String? hintText,
  }) {
    return AppTextField(
      key: key,
      title: title ?? "Email",
      hintText: hintText ?? "Enter your email",
      controller: controller,
      validator: validator ?? FormValidatorUtil.email,
      keyboardType: TextInputType.emailAddress,
      prefixIconPath: IconAllConstants.mail02,
    );
  }

  factory AppTextField.password({
    Key? key,
    required TextEditingController controller,
    String? Function(String?)? validator,
    String? title,
    String? hintText,
  }) {
    return AppTextField(
      key: key,
      title: title ?? "Password",
      hintText: hintText ?? "Enter your password",
      controller: controller,
      validator: validator ?? FormValidatorUtil.password,
      keyboardType: TextInputType.visiblePassword,
      prefixIconPath: IconAllConstants.lock01,
      isPassword: true,
      obscureText: true,
    );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null && widget.title!.isNotEmpty) ...[
          Text(widget.title!,
              style: customTextStyle(color: Colors.white, fontSize: 16.0)),
          16.height,
        ],
        TextFormField(
          onTap: () {
            if (widget.onTextFieldTap != null) widget.onTextFieldTap!.call();
          },
          controller: widget.controller,
          cursorColor: Colors.white,
          maxLines: 1,
          style: customTextStyle(color: Colors.white, fontSize: 16.0),
          keyboardType: widget.keyboardType ?? TextInputType.text,
          readOnly: widget.readOnly,
          obscureText: widget.isPassword ? _obscureText : false,
          decoration: InputDecoration(
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 15, vertical: 16).r,
            hintText: widget.hintText,
            hintStyle:
                customTextStyle(color: descriptionLightColor, fontSize: 14.0),
            errorStyle: customTextStyle(color: Colors.red, fontSize: 12.0),
            filled: true,
            isDense: true,
            fillColor: widget.backgroundColor ?? textFieldBgColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: AppColors.light.withOpacity(0.1),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: AppColors.light.withOpacity(0.1),
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: AppColors.light.withOpacity(0.1),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: const Color(0xFF814AFF).withOpacity(0.5),
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
            ),
            prefixIconConstraints: _getIconConstraints(20),
            prefixIcon: widget.prefixIconPath != null
                ? Container(
                    padding: EdgeInsets.only(left: 10.r),
                    constraints: _getIconConstraints(20),
                  child: Center(
                    child: SvgPicture.asset(widget.prefixIconPath!,
                        color: Colors.white.withOpacity(0.5),
                        width: 20.r,
                        height: 20.r,
                      ),
                  ),
                )
                : widget.prefixIcon,
            suffixIconConstraints: _getIconConstraints(20),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.light.withOpacity(0.5),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
          validator: widget.validator,
        ),
      ],
    );
  }

  BoxConstraints _getIconConstraints(double size) {
    return BoxConstraints(
      minWidth: size.r,
      maxWidth: size.r,
      minHeight: size.r,
      maxHeight: size.r,
    );
  }
}
