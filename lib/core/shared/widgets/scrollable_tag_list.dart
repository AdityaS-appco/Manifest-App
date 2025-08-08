import 'package:manifest/core/shared/widgets/blur_container.dart';
import 'package:manifest/helper/import.dart';

class TagListController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void updateSelected(int index) {
    selectedIndex.value = index;
  }
}

class ScrollableTagList extends StatelessWidget {
  ScrollableTagList({
    super.key,
    required this.tags,
    this.onTagSelected,
  });

  final List<String> tags;
  final Function(String)? onTagSelected;
  final TagListController controller = Get.put(TagListController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          ...List.generate(
            tags.length,
            (index) => Obx(
              () => Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 16 : 8,
                  right: index == tags.length - 1 ? 16 : 0,
                ),
                child: _buildTag(
                  tags[index].capitalize ?? '',
                  isSelected: controller.selectedIndex.value == index,
                  onTap: () {
                    controller.updateSelected(index);
                    onTagSelected?.call(tags[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(
    String text, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: BlurContainer(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
