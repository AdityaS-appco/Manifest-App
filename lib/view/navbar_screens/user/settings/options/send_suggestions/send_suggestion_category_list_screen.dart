import 'package:manifest/core/shared/widgets/common_auth_form_scaffold.dart';
import 'package:manifest/core/shared/widgets/divider_section.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/send_suggestions/send_suggestion.dart';
import 'package:manifest/view/navbar_screens/user/settings/options/send_suggestions/suggestion_option_model.dart';

class SendSuggestionsCategoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SendSuggestionsCategoryListController());

    return CommonAuthFormScaffold(
      title: "Send Suggestion",
      subtitle:
          "All feedback is heard, and we consistently enhance the app based on your input.",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...controller.suggestionOptions
              .map(
                (option) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0).r,
                  child: DividerSection.containeredForSetting(
                    children: [
                      AppListTile.dropdown(
                        text: option.label,
                        leadingIcon: option.iconPath,
                        onTap: () {
                          Get.to(
                            SendSuggestionsScreen(
                              selectedOption: option,
                            ),
                          );
                        },
                        gradientColors: option.gradientColors,
                        gradientBegin:
                            option == controller.suggestionOptions.last
                                ? Alignment.topCenter
                                : Alignment.centerLeft,
                        gradientEnd: option == controller.suggestionOptions.last
                            ? Alignment.bottomCenter
                            : Alignment.centerRight,
                        hasRightArrow: false,
                      )
                    ],
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}

class SendSuggestionsCategoryListController extends GetxController {
  final List<SuggestionOption> suggestionOptions = <SuggestionOption>[
    SuggestionOption(
      label: "Suggest an affirmation",
      iconPath: IconAllConstants.lightbulb02,
      gradientColors: AppColors.orangeHighlightGradientColors,
    ),
    SuggestionOption(
      label: "Propose a track or playlist idea",
      iconPath: IconAllConstants.headphones02,
      gradientColors: AppColors.purpleHighlightGradientColors, // purple/blue
    ),
    SuggestionOption(
      label: "Request a feature",
      iconPath: IconAllConstants.coinsStacked02,
      gradientColors: AppColors.cyanHighlightGradientColors, // teal/blue
    ),
    SuggestionOption(
      label: "Report a bug",
      iconPath: IconAllConstants.messageAlertCircle,
      gradientColors: AppColors.yellowHighlightGradientColors, // yellow/orange
    ),
    SuggestionOption(
      label: "Just wanted to say hello",
      iconPath: IconAllConstants.messageChatCircle,
      gradientColors: AppColors.greenHighlightGradientColors, // green/teal
    ),
    SuggestionOption(
      label: "Other",
      iconPath: IconAllConstants.menuVerticalDots1,
      gradientColors:
          AppColors.purpleLightHighlightGradientColors, // purple/blue
    )
  ];
}
