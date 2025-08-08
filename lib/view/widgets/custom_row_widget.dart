
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/view/widgets/dots_wave_loading.dart';
import 'package:manifest/helper/import.dart';

Widget customRowWidget({Function()? onPressed, required String title, String? trailingText, Widget? trailingIcon, double? textSize, FontWeight? fontWeight}) {
  return GestureDetector(
    onTap: onPressed,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: secondaryWhiteTextStyle(fontSize: textSize ?? 14.0, fontWeight: fontWeight ?? FontWeight.w400),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(trailingText !=null)
            Text(trailingText.toString(), style: customTextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: const Color(0x0fffffff).withOpacity(0.3)
            )),
            10.width,
            if(trailingIcon !=null)
              trailingIcon,
          ],
        )
      ],
    ),
  );
}

// for playlist Tab
class CustomRowItem extends StatelessWidget {
  final String image;
  final String title;
  final List<dynamic>? data;
  final String Function(List<dynamic>?) dataFormatter;
  final Widget destinationPage;
  final bool? isForwardArrow;
  final bool? isFavoriteAffirmation;
  final bool? isLikedTrack;
  final bool? isMyCollection;

  const CustomRowItem({
    Key? key,
    required this.image,
    required this.title,
    required this.data,
    this.isLikedTrack,
    this.isFavoriteAffirmation,
    this.isMyCollection,
    required this.dataFormatter,
    required this.destinationPage,
    this.isForwardArrow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.to(() => destinationPage);
        },
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: secondaryWhiteTextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  data != null
                      ? Text(
                    dataFormatter(data),
                    style: customTextStyle(color: descriptionLightColor, fontSize: 12, fontWeight: FontWeight.w400))
                      : Text(
                    isFavoriteAffirmation == true
                        ? '0 affirmations • 00:00'
                        : isLikedTrack == true
                        ? '0 tracks'
                        : isMyCollection == true
                        ? '0 collections'
                        : 'No data available',
                    style: customTextStyle(
                      color: const Color.fromRGBO(235, 235, 245, 0.6), // Replace with your custom `descriptionLightColor`
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            if(isForwardArrow == true)
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: lightGreyColor,
            ),
          ],
        ),
      ),
    );
  }
}