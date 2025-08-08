import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/features/splash/star_splash_screen.dart';
import 'package:manifest/helper/import.dart';

class LogoAsTitleScreen extends StatelessWidget {
  const LogoAsTitleScreen({
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: StarSplashScreen(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (59 + 16).height,
                SvgPicture.asset(
                  'assets/logo/manifest_full_logo.svg',
                  width: 25.w,
                  height: 22.h,
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
