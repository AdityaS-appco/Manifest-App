import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';

import '../../helper/icons_and_images_path.dart';

class PremiumSheet extends StatefulWidget {
  const PremiumSheet({super.key});

  @override
  State<PremiumSheet> createState() => _PremiumSheetState();
}

class _PremiumSheetState extends State<PremiumSheet> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    setState(() {
      _currentPageIndex = _pageController.page?.round() ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSize.height,
      width: kSize.width,
      decoration: const BoxDecoration(
        color: Color(0xff1d2125),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          /// horizontal list of cards
          SizedBox(
            height: kSize.height * 0.45,
            child: Stack(
              children: [
                AnimatedBackground(
                    key: ValueKey<int>(_currentPageIndex),
                    index: _currentPageIndex),
                Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Column(
                    children: [
                      Gap(kSize.height * 0.06),

                      /// title and back button
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 20.0,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: kWhiteColor,
                                ),
                                onPressed: () {
                                  // Get.offAll(() => const SurveyPage());
                                  Get.back();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text('Premium',
                                  style: headingHelveticaRoundedBoldFontStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                      Gap(kSize.height * 0.015),
                      SizedBox(
                        height: kSize.height * 0.25,
                        child: PageView.builder(
                          itemCount: 4,
                          controller: _pageController,
                          itemBuilder: (context, index) {
                            return GlassmorphicContainer(
                                margin: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                width: double.infinity,
                                height: kSize.height * 0.25,
                                borderRadius: 12,
                                blur: 20,
                                alignment: Alignment.bottomCenter,
                                border: 1,
                                linearGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFFffffff).withOpacity(0.1),
                                    const Color(0xFFFFFFFF).withOpacity(0.05),
                                  ],
                                  stops: const [0.1, 1],
                                ),
                                borderGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFFffffff).withOpacity(0.5),
                                    const Color((0xFFFFFFFF)).withOpacity(0.5),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(kDefaultPadding),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          showSvgIconWidget(
                                              iconPath: AppIcons
                                                  .premiumBottomSheetCardHeadPhone),
                                          showSvgIconWidget(
                                              iconPath: AppIcons
                                                  .premiumBottomSheetCardPremiumTextIcon),
                                        ],
                                      ),
                                      Container(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            index == 0
                                                ? '100+ Affirmation and Subliminal \nmessages,'
                                                : 'Leo',
                                            style: secondaryWhiteTextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            index == 0
                                                ? 'Designed to relieve anxiety, stress and more.'
                                                : 'Subscribe for premium',
                                            style: primaryWhiteTextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xffEBEBF5)
                                                    .withOpacity(0.60)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                      20.height,
                      // Indicator
                      CustomIndicator(
                        itemCount: 4,
                        currentIndex: _currentPageIndex,
                        color: const Color(0xffC2C2C2).withOpacity(0.50),
                        activeColor: Colors.white,
                      ),
                      20.height,
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                20.height,
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffA28DF6).withOpacity(0.18),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'First 7 days  trial to unlock all practices',
                          style: secondaryWhiteTextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffC6B3F9)),
                        ),
                      ),
                    )),
                20.height,

                /// LIST OF Price Plans (Annual, Monthly, Weekly)
                const PricePlanList(),

                /// Price Plan
                10.height,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Save 40%, prev \$89,900, now \$49,900 Billed yearly.\nCancel anytime.',
                    style: secondaryWhiteTextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xffEBEBF5).withOpacity(0.30)),
                  ),
                ),
                30.height,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Unlock Manifest Premium',
                    style: secondaryWhiteTextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xffEBEBF5).withOpacity(0.30)),
                  ),
                ),
                10.height,
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: showSvgIconWidget(
                              iconPath: AppIcons.premiumBottomSheetHeadphone),
                          title: Text(
                            '28,000+ Affirmations',
                            style: secondaryWhiteTextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            'Designed to help you become your best self and manifest all the good things you desire.',
                            style: primaryWhiteTextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color(0xffEBEBF5).withOpacity(0.30)),
                          ),
                        ),
                        18.height,
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: showSvgIconWidget(
                              iconPath: AppIcons.premiumBottomSheetMusic),
                          title: Text(
                            '100+ Background Sounds & Scenes',
                            style: secondaryWhiteTextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            'Exclusive nature sounds, soothing music, binaural beats for better sleep and relaxation.',
                            style: primaryWhiteTextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color(0xffEBEBF5).withOpacity(0.30)),
                          ),
                        ),
                        18.height,
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: showSvgIconWidget(
                              iconPath: AppIcons.premiumBottomSheetVideo),
                          title: Text(
                            'Unlock all the Premium Features',
                            style: secondaryWhiteTextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            'Access to all the premium features such as Mind Movies, Custom Background Audio, Custom Affirmations, Infinity Loops, Timers, etc.',
                            style: primaryWhiteTextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color(0xffEBEBF5).withOpacity(0.30)),
                          ),
                        ),
                        18.height,
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: showSvgIconWidget(
                              iconPath: AppIcons.premiumBottomSheetBooster),
                          title: Text(
                            'Manifestation Booster',
                            style: secondaryWhiteTextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            'Reprogram your subconscious mind faster with our extremely potent proprietary booster.',
                            style: primaryWhiteTextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color(0xffEBEBF5).withOpacity(0.30)),
                          ),
                        ),
                        32.height,
                        Align(
                          alignment: Alignment.center,
                          child: MaterialButton(
                              onPressed: () {},
                              height: 50.0,
                              elevation: 0.0,
                              color: const Color(0xff797680).withOpacity(0.24),
                              highlightElevation: 8.0,
                              padding: EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Text('I have a promo code',
                                  style: customTextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffEBEBF5)
                                          .withOpacity(0.30)))),
                        ),
                        32.height,
                        Align(
                          alignment: Alignment.center,
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Restore Purchase',
                                  style: customTextStyle(
                                      color: const Color(0xffEBEBF5)
                                          .withOpacity(0.60),
                                      fontSize: 11),
                                ),
                                const VerticalDivider(
                                    color: Colors.grey, thickness: 1.0),
                                Text(
                                  'Privacy',
                                  style: customTextStyle(
                                      color: const Color(0xffEBEBF5)
                                          .withOpacity(0.60),
                                      fontSize: 11),
                                ),
                                const VerticalDivider(
                                    color: Colors.grey, thickness: 1.0),
                                Text(
                                  'Agreement',
                                  style: customTextStyle(
                                      color: const Color(0xffEBEBF5)
                                          .withOpacity(0.60),
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ),
                        60.height,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// FAQ, Resume Purchase
          Container(
            width: double.infinity,
            color: const Color(0xff3A3A3C),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'FAQ',
                    style: secondaryWhiteTextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: kWhiteColor),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididu?',
                    style: secondaryWhiteTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffEBEBF5).withOpacity(0.30)),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing tempor incididu?',
                    style: secondaryWhiteTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffEBEBF5).withOpacity(0.30)),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Lorem ipsum dolor sit amet, consectetur sed do eiusmod tempor incididu?',
                    style: secondaryWhiteTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffEBEBF5).withOpacity(0.30)),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20.0,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Resume purchase',
                    style: secondaryWhiteTextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: kWhiteColor),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20.0,
                  ),
                ),
                50.height,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xffA28DF6),
                            Color(0xff5B4A9F)
                          ], // Change colors as needed
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Try Free & Subscribe',
                              style: customTextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xffffffff))),
                          5.height,
                          Text('Charge after trial, \$49,900/year',
                              style: customTextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffFFFFFF)
                                      .withOpacity(0.60))),
                        ],
                      ),
                    ),
                  ),
                ),
                30.height,
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class AnimatedBackground extends StatefulWidget {
  int index;
  AnimatedBackground({super.key, this.index = 0});
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Decoration?> _decorationAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);
    _decorationAnimation = DecorationTween(
      begin: BoxDecoration(
        gradient: _buildGradient(widget.index),
      ),
      end: BoxDecoration(
        gradient: _buildGradient(widget.index == 3 ? 0 : widget.index + 1),
      ),
    ).animate(_controller);
  }

  LinearGradient _buildGradient(int index) {
    switch (index) {
      case 0:
        return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFFFFFF99).withOpacity(0.90),
            const Color(0xFFADEAF7).withOpacity(0.70),
          ],
        );
      case 1:
        return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFFADEAF7).withOpacity(0.80),
            const Color(0xFFDE7AF3),
          ],
        );
      case 2:
        return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFF82B1BD).withOpacity(0.80),
            const Color(0xFF494949).withOpacity(0.80),
          ],
        );
      case 3:
        return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFF764AF5).withOpacity(0.80),
            const Color(0xFFADEAF7).withOpacity(0.80),
          ],
        );
      default:
        return const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.black,
            Colors.black,
          ],
        );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: _decorationAnimation.value,
        );
      },
    );
  }
}

class CustomIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Color color;
  final Color activeColor;

  const CustomIndicator({
    Key? key,
    required this.itemCount,
    required this.currentIndex,
    required this.color,
    required this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex ? activeColor : color,
          ),
        ),
      ),
    );
  }
}

class PricePlan {
  final String name;
  final String price;
  final String discountPrice;

  PricePlan(this.name, this.price, this.discountPrice);
}

class PricePlanList extends StatefulWidget {
  const PricePlanList({Key? key}) : super(key: key);

  @override
  _PricePlanListState createState() => _PricePlanListState();
}

class _PricePlanListState extends State<PricePlanList> {
  int selectedIndex = 0;

  final List<PricePlan> plans = [
    PricePlan('Annual', '\$59,900', '\$49,900'),
    PricePlan('Monthly', '\$30,000', '\$25,800'),
    PricePlan('Weekly', '\$100.99', '\$100,00'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kSize.height * 0.17,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: plans.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Stack(
              fit: StackFit.loose,
              children: [
                SizedBox(
                  height: kSize.height * 0.19,
                  child: PricePlanCard(
                    plan: plans[index],
                    isSelected: selectedIndex == index,
                  ),
                ),
                if (selectedIndex == index)
                  Positioned(
                      top: 0,
                      left: 15,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                            color: const Color(0xffA28DF6),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Popular',
                                style: primaryWhiteTextStyle(
                                    fontSize: 10, color: kWhiteColor)),
                          ),
                        ),
                      ))
              ],
            ),
          );
        },
      ),
    );
  }
}

class PricePlanCard extends StatelessWidget {
  final PricePlan plan;
  final bool isSelected;

  const PricePlanCard({Key? key, required this.plan, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? const Color(0xffA28DF6)
                : const Color(0xffEBEBF5).withOpacity(0.30),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plan.name,
                        style: secondaryWhiteTextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: kWhiteColor)),
                    Text('12 months',
                        style: secondaryWhiteTextStyle(
                            color: const Color(0xffEBEBF5).withOpacity(0.30),
                            fontSize: 11)),
                  ],
                ),
                20.width,
                Text(plan.price,
                    style: TextStyle(
                        fontFamily: AppFonts.helvetica.name,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffEBEBF5).withOpacity(0.30),
                        decoration: TextDecoration.lineThrough,
                        decorationColor:
                            const Color(0xffEBEBF5).withOpacity(0.30))),
              ],
            ),
            20.height,
            Text(plan.discountPrice,
                style: customTextStyle(
                    fontSize: 28,
                    color: const Color(0xffA28DF6),
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
