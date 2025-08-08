import 'package:manifest/features/search/search_screen.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/core/shared/widgets/app_textfield.dart';

class CustomSearchWidget extends StatelessWidget {
  final Function(String)? onSearchChanged;
  final String? hintText;
  final TextEditingController? controller;
  final bool autofocus;

  const CustomSearchWidget({
    Key? key,
    this.onSearchChanged,
    this.hintText,
    this.controller,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField.search(
      controller: controller ?? TextEditingController(),
      onSearchChanged: (query) => onSearchChanged,
      hintText: hintText ?? 'What do you want to listen to?',
      onSearchTap: () {
        Get.to(SearchScreen());
      },
    );
  }
}
