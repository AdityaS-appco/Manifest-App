import 'package:gap/gap.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/core/utils/form_validator_util.dart';


class CreateNewCollection extends StatelessWidget {
  const CreateNewCollection({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    PlaylistTabController c = Get.find<PlaylistTabController>();
    return Container(
      height: kSize.height * 0.90,
      width: kSize.width,
      decoration: const BoxDecoration(
        color: Color(0xff1d2125),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.giveYourCollectionName,
                style: customTextStyle(
                    color: kWhiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4
                ),
              ),
              50.height,
              Form(
                key: formKey,
                child: TextFormField(
                  focusNode: c.focusNode,
                  controller: c.newCollectionName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: AppStrings.newCollectionName,
                    hintStyle: customTextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w400,
                        color: greyColor),
                  ),
                  validator: FormValidatorUtil.playlistName,
                ),
              ),
              const Gap(32),
              OutlinedButton(
                onPressed: () async {
                  if(formKey.currentState!.validate()){
                    await c.createOrUpdateNewCollection(isEditing: false);
                    c.focusNode.unfocus();
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.transparent),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xffA28DF6), Color(0xff5B4A9F)], // Change colors as needed
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    border: Border.all(color: Colors.transparent),
                    // Ensure border is transparent
                    borderRadius: BorderRadius.circular(
                        24), // You can adjust the radius as needed
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 28),
                    child: Text(
                      AppStrings.create,
                      style: customTextStyle(
                          color: kWhiteColor,
                          letterSpacing: 0.4,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 21.0,top: 14.0),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(127, 127, 127, 0.4),
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: Center(
                    child: Icon(
                      size: 16.0,
                      Icons.close,
                      color: kWhiteColor,
                    ),
                  ),
                ),
              ),
            )
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: 36,
              height: 5,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(127, 127, 127, 0.4),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ]), //Padding
    );
  }
}