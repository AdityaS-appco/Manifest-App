import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/helper/import.dart';

class InstagramCircleButton extends SvgCircleButton {
  InstagramCircleButton({required VoidCallback onPressed})
      : super(
          IconAllConstants.instagram,
          buttonSize: 50,
          iconSize: 18.5,
          enabledColor: AppColors.light.withOpacity(0.1),
          padding: const EdgeInsets.all(10),
          onPressed: onPressed,
          iconBuilder: (svg) => Container(
            width: 30.r,
            height: 30.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: AppColors.instagramGradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(child: svg),
          ),
        );
}
