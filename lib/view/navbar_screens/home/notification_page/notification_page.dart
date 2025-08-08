import 'package:manifest/helper/icons_and_images_path.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'notification_detail_page.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBackgroundColor,
        appBar: AppBar(
          backgroundColor: appBackgroundColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(255, 255, 255, 1),
              size: 16.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(AppStrings.notifications),
          titleTextStyle: appBarTitleTextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            fontSize: 17.0,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
          iconTheme: IconThemeData(color: kWhiteColor),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 26.0,
            right: 18,
          ),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    Get.to(() => const NotificationDetailPage());
                  },
                  leading: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(500),
                        color: const Color.fromRGBO(122, 120, 128, 0.36),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: showSvgIconWidget(
                            iconPath: AppIcons.notificationUnRead),
                      )),
                  title: Text(
                    'Lorem ipsum dolor sit amet consectetur..',
                    style: secondaryWhiteTextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 255, 255, 1)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    'Lorem ipsum dolor sit amet consectetur',
                    style: primaryWhiteTextStyle(
                        color: descriptionLightColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '11/14',
                        style: primaryWhiteTextStyle(color: greyColor),
                      ),
                      10.height,
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: primaryColor,
                      ),
                    ],
                  ));
            },
          ),
        ));
  }
}
