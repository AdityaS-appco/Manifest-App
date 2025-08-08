import 'package:manifest/helper/import.dart';

Widget kPrimaryButton(
    {Color? color,
    Function()? onPressed,
    String? text,
    Widget? widget,
    Color? textColor,
    double? height,
    double? elevation,
    double? textSize,
    FontWeight? fontWeight,
    double? letterSpacing}) {
  return MaterialButton(
      onPressed: () {
        if (onPressed != null) onPressed();
      },
      minWidth: double.infinity,
      height: height ?? 50.0,
      elevation: 0.0,
      color: color ?? kWhiteColor,
      highlightElevation: 8.0,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      child: widget ??
          Text(text!,
              style: customTextStyle(
                  fontSize: textSize ?? 16.0,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  color: textColor ?? blackColor,
                  letterSpacing: letterSpacing)));
}

Widget kGradientButton(
    {Function()? onPressed,
    String? text,
    Widget? widget,
    Color? textColor,
    double? height}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: double.infinity,
      height: height ?? 50.0,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xffCFD1FF)], // Change colors as needed
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      alignment: Alignment.center,
      child: widget ??
          Text(text!,
              style: customTextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? blackColor)),
    ),
  );
}

Widget kGradientPrimaryColorButton({
  Function()? onPressed,
  String? text,
  Widget? widget,
  Color? textColor,
  double? height,
  double? radius,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: double.infinity,
      // height: height ?? 50.0,
      padding:
          EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius ?? 50.0,
        ),
        gradient: const LinearGradient(
          colors: [
            Color(0xffA28DF6),
            Color(0xff5B4A9F)
          ], // Change colors as needed
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      alignment: Alignment.center,
      child: widget ??
          Text(text!,
              style: customTextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: textColor ?? kWhiteColor,
              )),
    ),
  );
}

Widget kPrimaryOutlineButton(
    {Color? color,
    Function()? onPressed,
    String? text,
    Widget? widget,
    Color? textColor,
    double? height,
    double? elevation}) {
  return OutlinedButton(
    onPressed: () {
      if (onPressed != null) onPressed();
    },
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: color ?? kWhiteColor), // Define the border color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
    ),
    child: Container(
      width: double.infinity,
      height: height ?? 50.0,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      alignment: Alignment.center,
      child: widget ??
          Text(
            text!,
            style: customTextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: textColor ?? blackColor,
            ),
          ),
    ),
  );
}

Widget switchButton({required bool onOffValue, required Function() onPressed}) {
  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check);
      }
      return Icon(
        Icons.lock,
        color: blackColor,
      );
    },
  );
  return Switch(
    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    inactiveTrackColor: const Color.fromRGBO(122, 120, 128, 0.32),
    thumbColor: WidgetStateProperty.all(Colors.white),
    thumbIcon: thumbIcon,
    value: onOffValue,
    onChanged: (_) => onPressed(),
  );
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light0 = true;
  bool light1 = true;

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Switch(
        //   value: light0,
        //   onChanged: (bool value) {
        //     setState(() {
        //       light0 = value;
        //     });
        //   },
        // ),
        Switch(
          thumbIcon: thumbIcon,
          value: light1,
          onChanged: (bool value) {
            setState(() {
              light1 = value;
            });
          },
        ),
      ],
    );
  }
}
