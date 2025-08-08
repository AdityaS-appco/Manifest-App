import 'package:flutter/cupertino.dart';
import 'package:manifest/core/shared/controllers/profile_controller.dart';
import 'package:manifest/controllers/playList_tab/playlist_tab_controller.dart';
import 'package:manifest/view/widgets/show_svg_icon_widget.dart';
import '../../../../../../helper/icons_and_images_path.dart';
import 'add_tracks_to_playlist.dart';
import 'package:manifest/helper/import.dart';

class PlaylistMusicOptions extends StatelessWidget {
  const PlaylistMusicOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    PlaylistTabController c = Get.find<PlaylistTabController>();
    ProfileController profileController = Get.find<ProfileController>();
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Column(
              children: [
                40.height,
                SizedBox(
                  height: 170.0.h,
                  width: 170.0.w,
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(7.0),
                          child: Image.network(
                            height: 160.0.h,
                            width: 160.0.w,
                            c.playlistByID.data!.image.toString(),
                            fit: BoxFit.cover,
                            colorBlendMode: BlendMode.darken,
                            color: Colors.black45,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 160.0.h,
                                width: 160.0.w,
                                color: Colors.white70,
                                child: Center(
                                  child: Icon(Icons.error,
                                      color: Colors.grey.shade600),
                                ),
                              );
                            },
                          )),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromRGBO(44, 44, 46, 1),
                              child:
                                  showSvgIconWidget(iconPath: AppIcons.camera)),
                          onPressed: () async {
                            showModalBottomSheet(
                              backgroundColor: descriptionLightColor,
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      horizontalTitleGap: 5,
                                      leading: Icon(Icons.photo_library,
                                          size: 18, color: kWhiteColor),
                                      title: Text(
                                        'Gallery',
                                        style:
                                            customTextStyle(color: kWhiteColor),
                                      ),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        profileController
                                            .pickAndUpdateProfileImage();
                                      },
                                    ),
                                    ListTile(
                                      horizontalTitleGap: 5,
                                      leading: Icon(Icons.camera_alt,
                                          size: 18, color: kWhiteColor),
                                      title: Text(
                                        'Camera',
                                        style:
                                            customTextStyle(color: kWhiteColor),
                                      ),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        profileController
                                            .pickAndUpdateProfileImage();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                20.height,
                Text(
                  c.playlistByID.data!.name.toString(),
                  style: customTextStyle(
                      color: kWhiteColor,
                      letterSpacing: 0.4,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
                4.height,
                Text(
                  '${c.playlistByID.data!.tracksCount.toString()} tracks | ${c.playlistByID.data!.tracksTotalDuration.toString()}',
                  style: customTextStyle(
                      color: kWhiteColor,
                      letterSpacing: 0.4,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400),
                ),
              ],
            )),
            44.height,
            Column(
              children: [
                ListTile(
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: showSvgIconWidget(iconPath: AppIcons.shareLight)),
                  title: Text(
                    'Share',
                    style: customTextStyle(
                      color: kWhiteColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    c.getListOfTracks(needLoading: false);
                    Get.bottomSheet(
                      AddTracksToPlaylist(
                          playlistID: c.playlistByID.data!.id.toString()),
                      isScrollControlled: true,
                      enableDrag: true,
                      enterBottomSheetDuration:
                          const Duration(milliseconds: 500),
                    );
                  },
                  leading: const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(
                        Icons.add_circle_outline,
                        color: Color.fromRGBO(235, 235, 245, 0.6),
                      )),
                  title: Text(
                    'Add track to playlist',
                    style: customTextStyle(
                      color: kWhiteColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: showSvgIconWidget(iconPath: AppIcons.downloads)),
                  title: Text(
                    'Download',
                    style: customTextStyle(
                      color: kWhiteColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                Obx(() => c.isRename == false
                    ? ListTile(
                        leading: SizedBox(
                            height: 20,
                            width: 20,
                            child: showSvgIconWidget(
                                iconPath: AppIcons.editCollectionOrPlaylist)),
                        title: GestureDetector(
                          onTap: () {
                            c.setRenameValue(value: true);
                          },
                          child: Text(
                            'Rename playlist',
                            style: customTextStyle(
                              color: kWhiteColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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
                            decoration: InputDecoration(
                              hintText: 'Enter new name',
                              hintStyle: customTextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500),
                              contentPadding: EdgeInsets.zero,
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white60)),
                            ),
                            textInputAction: TextInputAction
                                .done, // Set the action button to 'done'
                            onFieldSubmitted: (String value) {
                              if (formKey.currentState!.validate()) {
                                LogUtil.v('User submitted: $value');
                                c.setRenameValue(value: false);
                                c.createOrUpdateNewPlaylist(
                                    name: value.toString(),
                                    playlistID:
                                        c.playlistByID.data!.id.toString(),
                                    isEditing: true);
                              }
                            },
                            validator: FormValidatorUtil.playlistName,
                          ),
                        ),
                      )),
                ListTile(
                  onTap: () async {
                    await c.deleteCreatedPlaylist(
                        id: c.playlistByID.data!.id.toString());
                  },
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: showSvgIconWidget(iconPath: AppIcons.deleteBin)),
                  title: Text(
                    'Delete playlist',
                    style: customTextStyle(
                      color: kWhiteColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
            Gap(kSize.height * 0.10),
            GestureDetector(
              onTap: () {
                Get.back();
                c.setRenameValue(value: false);
              },
              child: Text(
                'Close',
                style: secondaryWhiteTextStyle(
                    fontSize: 17.0, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
