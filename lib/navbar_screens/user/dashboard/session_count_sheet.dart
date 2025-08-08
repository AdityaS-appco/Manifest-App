import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/helper/dummy_data.dart';
import 'package:manifest/helper/import.dart';

import '../../../../helper/icons_and_images_path.dart';

class SessionCountSheet extends StatefulWidget {
  const SessionCountSheet({Key? key}) : super(key: key);

  @override
  State<SessionCountSheet> createState() => _SessionCountSheetState();
}

class _SessionCountSheetState extends State<SessionCountSheet> {
  int? _sliding = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSize.height * 0.90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: appBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Image.asset(
                      AppImages.sessionCount,
                      fit: BoxFit.cover,
                      height: 80,
                      width: 80,
                    ),
                    title: Text(
                      'Session count',
                      style: secondaryWhiteTextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      'Week 18-25 Apr',
                      style: secondaryWhiteTextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.50)),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  20.height,
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl(
                        children: {
                          0: Text(
                            'Day',
                            style: secondaryWhiteTextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                          1: Text(
                            'Week',
                            style: secondaryWhiteTextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                          2: Text(
                            'Month',
                            style: secondaryWhiteTextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                          3: Text(
                            'Year',
                            style: secondaryWhiteTextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.w400),
                          ),
                        },
                        thumbColor: Colors.grey.shade700,
                        backgroundColor: dashboardCardBgColor,
                        groupValue: _sliding,
                        onValueChanged: (int? newValue) {
                          setState(() {
                            _sliding = newValue;
                            print('currentTab: $_sliding');
                          });
                        }),
                  ),
                  30.height,
                  Text(
                    '23 sessions',
                    style: secondaryWhiteTextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  20.height,
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                      color: dashboardCardBgColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '1 session •',
                              style: secondaryWhiteTextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '18 April',
                              style: secondaryWhiteTextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xffffffff)
                                      .withOpacity(0.40)),
                            ),
                          ],
                        ),
                        18.height,
                        Divider(
                            color: const Color(0xffEBEBF5).withOpacity(0.20)),
                        18.height,
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: min(DummyData.dummyData.length, 4),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var item = DummyData.dummyData[index];
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 60,
                                          width: 60,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  child: Image.network(
                                                    item.imageUrl,
                                                    fit: BoxFit.cover,
                                                    colorBlendMode:
                                                        BlendMode.darken,
                                                    color: Colors.black45,
                                                  )),
                                              Center(
                                                  child: Icon(
                                                Icons.play_arrow,
                                                color: kWhiteColor,
                                                size: 34.0,
                                              ))
                                            ],
                                          )),
                                      16.width,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '100 affirmations for self love',
                                            style: secondaryWhiteTextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          5.height,
                                          Text(
                                            '190 affirmations • 1h 30m',
                                            style: customTextStyle(
                                                color: const Color(0xffEBEBF5)
                                                    .withOpacity(0.60),
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  15.height,
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                      color: dashboardCardBgColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '2 session •',
                              style: secondaryWhiteTextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '19 April',
                              style: secondaryWhiteTextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xffffffff)
                                      .withOpacity(0.40)),
                            ),
                          ],
                        ),
                        18.height,
                        Divider(
                            color: const Color(0xffEBEBF5).withOpacity(0.20)),
                        18.height,
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: min(DummyData.dummyData.length, 4),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var item = DummyData.dummyData[index];
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 60,
                                          width: 60,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                  child: Image.network(
                                                    item.imageUrl,
                                                    fit: BoxFit.cover,
                                                    colorBlendMode:
                                                        BlendMode.darken,
                                                    color: Colors.black45,
                                                  )),
                                              Center(
                                                  child: Icon(
                                                Icons.play_arrow,
                                                color: kWhiteColor,
                                                size: 34.0,
                                              ))
                                            ],
                                          )),
                                      16.width,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'I am enough',
                                            style: secondaryWhiteTextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          5.height,
                                          Text(
                                            '190 affirmations • 1h 30m',
                                            style: customTextStyle(
                                                color: const Color(0xffEBEBF5)
                                                    .withOpacity(0.60),
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 36,
                height: 5,
                decoration: BoxDecoration(
                  color: mediumGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
