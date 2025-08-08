import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

import '../../../../../../../helper/icons_and_images_path.dart';

class SuccessfulVerification extends StatelessWidget {
  final String? text;
  const SuccessfulVerification(
      {super.key, this.text = 'Email Changed Successfully'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: appBackgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                showSvgIconWidget(iconPath: AppImages.successFullMark),
                const Gap(27),
                Center(
                  child: Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: primaryWhiteHelveticaRoundedBoldTextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Gap(16),
                Text(
                  'Lorem ipsum dolor sit amet consectetur. Tortor dignissim vel dolor tellus in proin.',
                  textAlign: TextAlign.center,
                  style: customTextStyle(
                      fontSize: 15.0,
                      color: const Color(0xffEBEBF5).withOpacity(0.30),
                      fontWeight: FontWeight.w400),
                ),
                const Gap(32),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color.fromRGBO(112, 67, 241, 0.15)),
                    alignment: Alignment.center,
                    child: Text('Go back to account',
                        style: customTextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xffA28DF6))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
