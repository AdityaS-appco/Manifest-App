import 'package:manifest/helper/import.dart';

class ChangeAppIcons extends StatelessWidget {
  const ChangeAppIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: kSize.height * 0.38,
      width: kSize.width,
      decoration: BoxDecoration(
        color: dashboardCardBgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: mediumGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
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
              )),
          const Gap(20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(AppStrings.changeAppIcon,
                style: primaryWhiteHelveticaRoundedBoldTextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 22.0)),
          ),
          const Gap(28.0),
          //Icons Container
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Text(AppStrings.appIcon,
                              style: secondaryWhiteTextStyle(
                                  color: kWhiteColor,
                                  // fontWeight: FontWeight.w700,
                                  fontSize: 16.0)),
                        ),
                      ),
                      const Gap(12.0),
                      //Icons Names
                      Text(AppStrings.dreamy,
                          style: primaryWhiteTextStyle(
                              color: kWhiteColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0)),
                    ],
                  ),
                ),
                const Gap(20),
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(AppStrings.appIcon,
                            style: secondaryWhiteTextStyle(
                                color: kWhiteColor,
                                // fontWeight: FontWeight.w700,
                                fontSize: 16.0)),
                      ),
                    ),
                    const Gap(12.0),
                    //Icons Names
                    Text(AppStrings.thinker,
                        style: primaryWhiteTextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0)),
                  ],
                ),
                const Gap(20),
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Text(AppStrings.appIcon,
                            style: secondaryWhiteTextStyle(
                                color: kWhiteColor,
                                // fontWeight: FontWeight.w700,
                                fontSize: 16.0)),
                      ),
                    ),
                    const Gap(12.0),
                    //Icons Names
                    Text(AppStrings.mystic,
                        style: primaryWhiteTextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0)),
                  ],
                ),
              ],
            ),
          ),
          const Gap(40.0),
        ],
      ),
    );
  }
}
