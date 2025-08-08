import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

import '../../../../../../helper/icons_and_images_path.dart';

class HomeMediaPlayerShare extends StatelessWidget {
  const HomeMediaPlayerShare({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kSize.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(40, 17, 126, 1),
            Color.fromRGBO(92, 12, 138, 1),
            Color.fromRGBO(0, 0, 0, 1),
            Color.fromRGBO(0, 0, 0, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      // image Share and Save image Buttons
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          10.height,
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 36,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xff3E3C43).withOpacity(0.60),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: CircleAvatar(
                backgroundColor: const Color.fromRGBO(127, 127, 127, 0.4),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: kWhiteColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: kSize.height * 0.42,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff7184FF),
                              Color(0xff784CF6),
                              Color.fromRGBO(222, 122, 243, 1),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomRight,
                          )),
                      child: Padding(
                        padding: EdgeInsets.all(kDefaultPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/images/shareCup.png'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Duration',
                                        style: primaryWhiteTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: descriptionLightColor,
                                        )),
                                    Text('30 Minutes',
                                        style: primaryWhiteTextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        )),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Streak Kept',
                                        style: primaryWhiteTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: descriptionLightColor,
                                        )),
                                    Text('Day 15',
                                        style: primaryWhiteTextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        )),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Date',
                                        style: primaryWhiteTextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: descriptionLightColor,
                                        )),
                                    Text('Oct 26',
                                        style: primaryWhiteTextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 10,
                        left: 10,
                        child: SizedBox(
                            height: 30,
                            child: Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  showSvgIconWidget(
                                      iconPath: AppIcons.manifestTextLogo),
                                ],
                              ),
                            )))),
                  ],
                ),
                10.height,
                Column(
                  children: [
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          // SwitcherButton(
                          //   value: true,
                          //   onChange: (value) {
                          //     print(value);
                          //   },
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 32,
                              width: kSize.width * 0.55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    const Color.fromRGBO(255, 255, 255, 0.30),
                              ),
                              child: TabBar(
                                labelStyle: primaryWhiteTextStyle(
                                    letterSpacing: 0.08,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600),
                                unselectedLabelStyle: primaryWhiteTextStyle(
                                    letterSpacing: 0.08,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                                unselectedLabelColor: descriptionLightColor,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                labelColor: Colors.black,
                                dividerColor: Colors.black,
                                tabs: const [
                                  Tab(
                                    text: "Fullscreen",
                                  ),
                                  Tab(
                                    text: "Square",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: kSize.height * 0.08,
                    ),
                    Column(
                      children: [
                        Text('Share with your friends and family',
                            style: primaryWhiteTextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            )),
                        10.height,
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(left: 12),
                            itemCount: imageDataList.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 12),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            119, 116, 128, 0.18),
                                        borderRadius:
                                            BorderRadius.circular(500),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(kSize.width / 2),
                                        child: showSvgIconWidget(
                                            iconPath:
                                                imageDataList[index].imagePath),
                                      ),
                                    ),
                                    Text(
                                      imageDataList[index].description,
                                      style: primaryWhiteTextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w400,
                                        color: descriptionLightColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageData {
  final String imagePath;
  final String description;

  ImageData({required this.imagePath, required this.description});
}

List<ImageData> imageDataList = [
  ImageData(
      imagePath: 'assets/images/socialMediaLogo/copyLink.svg',
      description: 'Copy link'),
  ImageData(
      imagePath: 'assets/images/socialMediaLogo/save_Download.svg',
      description: 'Save image'),
  ImageData(
      imagePath: 'assets/images/socialMediaLogo/twiterLogo.svg',
      description: 'X'),
  ImageData(
      imagePath: 'assets/images/socialMediaLogo/instagramLogo.svg',
      description: 'Instagram'),
  ImageData(
      imagePath: 'assets/images/socialMediaLogo/facebookLogo.svg',
      description: 'Facebook'),
  ImageData(
      imagePath: 'assets/images/socialMediaLogo/facebookLogo.svg',
      description: 'Facebook'),
  ImageData(
      imagePath: 'assets/images/socialMediaLogo/facebookLogo.svg',
      description: 'Facebook'),
];

class MyTabOne extends StatelessWidget {
  const MyTabOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      "This is Tab One",
      style: TextStyle(fontSize: 20),
    ));
  }
}

class MyTabTwo extends StatelessWidget {
  const MyTabTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // SwitcherButton(
          //   value: true,
          //   onChange: (value) {
          //     print(value);
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: TabBar(
                indicator: BoxDecoration(
                  color: Colors.red[800],
                  borderRadius: BorderRadius.circular(20),
                ),
                labelColor: Colors.black,
                dividerColor: Colors.black,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  const Tab(
                    text: "Live",
                  ),
                  const Tab(
                    text: "Result",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(
            // ignore: prefer_const_literals_to_create_immutables
            child: TabBarView(children: [
              // MyLivePage(),
              // MyResultPage(),
            ]),
          ),
        ],
      ),
    );
  }
}
