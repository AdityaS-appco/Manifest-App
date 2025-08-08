import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/helper/import.dart';

class FacebookCircleButton extends SvgCircleButton {
  FacebookCircleButton({required VoidCallback onPressed})
      : super(
          IconAllConstants.facebookButton,
          buttonSize: 50,
          iconSize: 50,
          enabledColor: AppColors.light.withOpacity(0.1),
          padding: const EdgeInsets.all(0),
          onPressed: onPressed,
        );
}
