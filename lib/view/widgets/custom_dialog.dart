import 'package:flutter/cupertino.dart';
import 'package:manifest/view/widgets/buttons_widget.dart';
import 'package:manifest/helper/import.dart';

Widget customDialog() {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    elevation: 0.0,
    backgroundColor: dashboardCardBgColor,
    title: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Text(
              'I am in the right place at the right time, doing the right thing',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: secondaryWhiteTextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              )),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Divider(
                color: Colors.grey,
                thickness: 0.3,
                height: 5,
              ),
              10.height,
              Text('Are you sure you want to remove from “Liked” affirmations?',
                  textAlign: TextAlign.center,
                  style: secondaryWhiteTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffEBEBF5))),
              20.height,
              // Button Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: kPrimaryButton(
                          color: const Color(0xff797680),
                          text: 'Cancel',
                          height: 40,
                          textColor: Colors.white,
                          textSize: 15.0,
                          fontWeight: FontWeight.w400)),
                  20.width,
                  Expanded(
                      child: kGradientPrimaryColorButton(
                          text: 'Yes', height: 40.0))
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget cupertinoDeleteDialog() {
  return Theme(
    data: ThemeData(brightness: Brightness.dark),
    child: CupertinoAlertDialog(
      title: Column(
        children: [
          Text('Delete Soundscape',
              style: secondaryWhiteTextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              )),
          10.height,
          Text('Downloaded soundscapes will be \n deleted',
              style: secondaryWhiteTextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              )),
        ],
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(Get.context!).pop();
          },
          child: Text(
            'Cancel',
            style: secondaryWhiteTextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: const Color(0xff0A84FF)),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(Get.context!).pop();
          },
          child: Text(
            'Ok',
            style: secondaryWhiteTextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: const Color(0xff0A84FF)),
          ),
        ),
      ],
    ),
  );
}

class DialogOfRating extends StatefulWidget {
  const DialogOfRating({super.key});

  @override
  DialogOfRatingState createState() => DialogOfRatingState();
}

class DialogOfRatingState extends State<DialogOfRating> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 0.0,
      backgroundColor: dashboardCardBgColor,
      title: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(AppStrings.rateThisApp,
                style: secondaryWhiteTextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                )),
            6.height,
            Text(AppStrings.rateThisApp,
                style: secondaryWhiteTextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                )),
            20.height,
            const Divider(
              color: Colors.grey,
              thickness: 0.3,
              height: 5,
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  margin: const EdgeInsets.only(right: 6),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    child: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      size: 35,
                      color: const Color(0xff0A84FF), // Change star color here
                    ),
                  ),
                );
              }),
            ),
            10.height,
            const Divider(
              color: Colors.grey,
              thickness: 0.3,
              height: 5,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.notNow,
                  style: secondaryWhiteTextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff0A84FF)),
                )),
          ],
        ),
      ),
    );
  }
}

// Future<void> simpleDialog(
//   BuildContext context,
//   List<TypesOfVoices> typesOfVoices,
//   Affirmations affirmations,
// ) {
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical: kSize.height * 0.28),
//         child: AlertDialog(
//             backgroundColor: appBackgroundColor,
//             content: AffirmationVoiceChange(
//               voiceType: typesOfVoices,
//             )),
//       );
//     },
//   );
// }

Widget alertDialog({
  required String title,
  required String content,
  required String cancelButtonText,
  required String continueButtonText,
  required Color cancelButtonColor,
  required Color continueButtonColor,
}) {
  return Theme(
    data: ThemeData(brightness: Brightness.dark),
    child: CupertinoAlertDialog(
      title: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white), // Customize title style
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.white), // Customize content style
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(Get.context!).pop();
          },
          child: Text(
            cancelButtonText,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color:
                    cancelButtonColor), // Customize cancel button text and color
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(Get.context!).pop();
          },
          child: Text(
            continueButtonText,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color:
                    continueButtonColor), // Customize continue button text and color
          ),
        ),
      ],
    ),
  );
}
