import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/helper/import.dart';

class XCircleButton extends SvgCircleButton {
  XCircleButton({required VoidCallback onPressed})
      : super(
          IconAllConstants.twitterx_2,
          buttonSize: 50,
          iconSize: 17.5,
          enabledColor: AppColors.light.withOpacity(0.1),
          padding: const EdgeInsets.all(10),
          onPressed: onPressed,
          iconColor: AppColors.light,
          iconBuilder: (svg) => Container(
            width: 30.r,
            height: 30.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.dark,
            ),
            child: Center(child: svg),
          ),
        );
}
