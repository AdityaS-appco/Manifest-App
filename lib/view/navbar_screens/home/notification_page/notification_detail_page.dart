import 'package:manifest/helper/import.dart';


class NotificationDetailPage extends StatelessWidget {
  const NotificationDetailPage({super.key});

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
            size: 16.0,),
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
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '[Insert notification title]',
              style: secondaryWhiteTextStyle(fontSize: 22.0, fontWeight: FontWeight.w700,),
            ),
            16.height,
            Text(
              '2024/11/30',
              style: customTextStyle(
                  color: descriptionLightColor,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2
              ),
            ),
            16.height,
            Text(
              "Lorem ipsum dolor sit amet consectetur. Risus euismod porttitor accumsan bibendum sit vulputate molestie sollicitudin cras. Nisl auctor eget mi nunc orci tempus feugiat bibendum. Sit maecenas proin est massa. Ac pretium tellus enim facilisi lectus at et suspendisse nec. Metus amet mi aliquet in nunc diam. Nibh tellus eu volutpat turpis vitae feugiat est. At amet lacus tristique iaculis dignissim ut elit ut. Suspendisse lacus congue lacus in sed adipiscing.",
              style: customTextStyle(
                  color: lightGreyColor,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4,
                  height: 1.5,
                  wordSpacing: 1.5
              ),
            ),
          ],
        ),
      ),
    );
  }
}