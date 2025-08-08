import 'package:manifest/helper/dummy_data.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/buttons_widget.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

import '../../../../../../helper/icons_and_images_path.dart';

class SoundScapeDetail extends StatelessWidget {
  const SoundScapeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSize.height * 0.90,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff1d2125),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 354,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(DummyData.dummyData.last.imageUrl),
                        fit: BoxFit.cover),
                  ),
                ),
                //Back Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        height: 34,
                        width: 34,
                        decoration: BoxDecoration(
                          border: Border.all(color: kWhiteColor, width: 0.8),
                          borderRadius: BorderRadius.circular(500),
                          color: const Color.fromRGBO(127, 127, 127, 0.4),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white, size: 20.0)),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Having a Good Life',
                          style: headingHelveticaRoundedBoldFontStyle(
                            color: kWhiteColor,
                            fontSize: 28.0,
                            fontWeight: FontWeight.w700,
                          )),
                      Text('by Manifest',
                          style: customTextStyle(
                            color: descriptionLightColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400,
                          )),
                      10.height,
                      Row(
                        children: [
                          Container(
                            height: 24.0,
                            width: 49.0,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(235, 235, 245, 0.16),
                            ),
                            child: Center(
                              child: Text('Focus',
                                  style: customTextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                  )),
                            ),
                          ),
                          10.width,
                          Container(
                            height: 24.0,
                            width: 49.0,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(235, 235, 245, 0.16),
                            ),
                            child: Center(
                              child: Text('Lifestyle',
                                  style: customTextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                  )),
                            ),
                          ),
                          10.width,
                          Container(
                            height: 24.0,
                            width: 49.0,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(235, 235, 245, 0.16),
                            ),
                            child: Center(
                              child: Text('Relax',
                                  style: customTextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 10.0,
                  bottom: 70.0,
                  child: Column(
                    children: [
                      Container(
                          height: 34,
                          width: 34,
                          decoration: BoxDecoration(
                            border: Border.all(color: kWhiteColor, width: 0.8),
                            borderRadius: BorderRadius.circular(500),
                            color: const Color.fromRGBO(127, 127, 127, 0.4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                showSvgIconWidget(iconPath: AppIcons.addMusic),
                          )),
                      15.height,
                      Container(
                          height: 34,
                          width: 34,
                          decoration: BoxDecoration(
                            border: Border.all(color: kWhiteColor, width: 0.8),
                            borderRadius: BorderRadius.circular(500),
                            color: const Color.fromRGBO(127, 127, 127, 0.4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: showSvgIconWidget(iconPath: AppIcons.share),
                          )),
                      10.height,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: 36,
                      height: 5,
                      decoration: BoxDecoration(
                        color: mediumGrey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            10.height,
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: kDefaultMargin / 2),
                    child: Text(
                        'Lorem ipsum dolor sit amet consectetur.Euismod ultricies convallis risus viverra tellus urna. dbdhejjejjfjjfnnnnnfnbbbbbbnnn',
                        textAlign: TextAlign.left,
                        style: primaryTextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w400)
                            .copyWith(
                                color: lightGreyColor,
                                fontStyle: FontStyle.italic)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('- Lorem ipsum',
                        textAlign: TextAlign.right,
                        style: primaryTextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w400)
                            .copyWith(
                                color: descriptionLightColor,
                                fontStyle: FontStyle.italic)),
                  ),
                  30.height,
                  kPrimaryButton(
                    text: 'Play',
                    fontWeight: FontWeight.w500,
                    textSize: 17.0,
                  ),
                  30.height,
                  Text('Similar Sounds;',
                      style: customTextStyle(
                        color: descriptionLightColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      )),
                  10.height,
                  SizedBox(
                    height: kSize.height * 0.14,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        //color: Colors.amber
                      ),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: DummyData.dummyData.length,
                          itemBuilder: (BuildContext context, int index) {
                            DummyData.dummyData.shuffle();
                            var item = DummyData.dummyData[index];
                            return Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 95,
                              width: 78,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(127, 127, 127, 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(item.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  10.height,
                                  Text(
                                    item.title,
                                    style: secondaryWhiteTextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w400,
                                      color: descriptionLightColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
