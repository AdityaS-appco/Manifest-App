import 'dart:ui';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/view/navbar_screens/playlist/tabs/by_you/recorded_affirmations_in_by_you_by_id.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import 'package:manifest/helper/import.dart';

import '../../../../../../helper/icons_and_images_path.dart';

class ByYouOptions extends StatelessWidget {
  final String? currentID;
  final String? byYouName;
  final String? totalDurationOrAffirmation;
  const ByYouOptions(
      {this.currentID,
      this.byYouName,
      this.totalDurationOrAffirmation,
      super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    PlaylistTabController c = Get.find<PlaylistTabController>();
    return Scaffold(
      //backgroundColor: Colors.grey.shade900,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 60),
        child: Container(
          color: Colors.black26.withOpacity(0.9),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(kSize.height * 0.02),
                  Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Gap(kSize.height * 0.03),
                          Image.asset(
                            AppImages.recordingRed,
                            height: 150.0,
                            width: 150.0,
                          ),
                          12.height,
                          Text(
                            byYouName.toString(),
                            style: customTextStyle(
                              color: kWhiteColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                            ),
                          ),
                          8.height,
                          Text(
                            totalDurationOrAffirmation.toString(),
                            style: customTextStyle(
                                fontSize: 15.0,
                                color: descriptionColor,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )),
                  37.height,
                  Padding(
                    padding: EdgeInsets.only(left: kDefaultPadding),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            c.setEditValue(value: true);
                            Get.to(() => const RecordedAffirmations());
                            // c.getListOfRecordedVoicesByID(idOfList: currentID.toString());
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.edit_note,
                            color: Colors.white60,
                            size: 25.0,
                          ),
                          title: Text(
                            'Edit',
                            style: customTextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17.0,
                                letterSpacing: 0.4,
                                color: kWhiteColor),
                          ),
                        ),
                        Obx(() => c.isRename == false
                            ? ListTile(
                                onTap: () {
                                  c.setRenameValue(value: true);
                                },
                                contentPadding: EdgeInsets.zero,
                                leading:
                                    showSvgIconWidget(iconPath: AppIcons.edit),
                                title: Text(
                                  'Rename Recording',
                                  style: customTextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.0,
                                      letterSpacing: 0.4,
                                      color: kWhiteColor),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Form(
                                  key: formKey,
                                  child: TextFormField(
                                    autocorrect: true,
                                    cursorColor: Colors.white60,
                                    style: customTextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.0,
                                      letterSpacing: 0.2,
                                    ),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white60)),
                                    ),
                                    textInputAction: TextInputAction
                                        .done, // Set the action button to 'done'
                                    onFieldSubmitted: (String value) {
                                      if (formKey.currentState!.validate()) {
                                        LogUtil.v('User submitted: $value');
                                        c.setRenameValue(value: false);
                                        c.renameAffirmationOrByYou(
                                          isByYou: true,
                                          name: value.toString(),
                                          byYouId: currentID.toString(),
                                        );
                                      }
                                    },
                                    validator: FormValidatorUtil.playlistName,
                                  ),
                                ),
                              )),
                        ListTile(
                          onTap: () {
                            c.removeAffirmationOrByYou(
                              isByYou: true,
                              byYouID: currentID.toString(),
                            );
                          },
                          contentPadding: EdgeInsets.zero,
                          leading:
                              showSvgIconWidget(iconPath: AppIcons.deleteBin),
                          title: Text(
                            'Delete Recording',
                            style: customTextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17.0,
                                letterSpacing: 0.4,
                                color: kWhiteColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(kSize.height * 0.2),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      c.setRenameValue(value: false);
                      c.setEditValue(value: false);
                    },
                    child: Text(
                      'Close',
                      style: customTextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17.0,
                          letterSpacing: 0.4,
                          color: kWhiteColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
