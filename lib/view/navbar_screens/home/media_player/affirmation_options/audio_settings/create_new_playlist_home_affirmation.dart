import 'package:manifest/controllers/home_media_player_controller.dart';
import 'package:manifest/core/services/playlist_service.dart';
import 'package:manifest/helper/import.dart';

class CreateNewPlayList extends StatelessWidget {
  const CreateNewPlayList({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    HomeMediaPlayerController c = Get.find<HomeMediaPlayerController>();

    /// * Initialize playlist service
    final playlistService = Get.find<PlaylistService>();
    final _playlistNameController = TextEditingController();

    return Form(
      key: formKey,
      child: Container(
        height: kSize.height * 0.86,
        width: kSize.width,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(140, 140, 140, 1),
              offset: Offset(0, 50), // horizontal and vertical offsets
              blurRadius: 100.0,
            ),
          ],
          color: Color.fromRGBO(37, 37, 37, 10),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 8.0),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // GestureDetector(
                //   onTap: () async{
                //     showModalBottomSheet(
                //       backgroundColor: descriptionLightColor,
                //       context: context,
                //       builder: (BuildContext context) {
                //         return Column(
                //           mainAxisSize: MainAxisSize.min,
                //           children: <Widget>[
                //             ListTile(
                //               horizontalTitleGap: 5,
                //               leading: Icon(Icons.photo_library, size: 18,color: kWhiteColor),
                //               title:  Text('Gallery',style: customTextStyle(color: kWhiteColor),),
                //               onTap: () async {
                //                 Navigator.pop(context);
                //
                //               },
                //             ),
                //             ListTile(
                //               horizontalTitleGap: 5,
                //               leading:  Icon(Icons.camera_alt, size: 18,color: kWhiteColor),
                //               title: Text('Camera', style: customTextStyle(color: kWhiteColor),),
                //               onTap: () async {
                //                 Navigator.pop(context);
                //                 // await c.pikImage(context: context, imageSource: ImageSource.camera);
                //               },
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                //   child: Container(
                //     height: 25.h,
                //     width: 25.w,
                //     decoration: BoxDecoration(
                //       color: Colors.grey.shade700,
                //       borderRadius: BorderRadius.all(Radius.circular(12.0)),),
                //     child:  Icon(Icons.photo_library, size: 18,color: kWhiteColor),
                //   ),
                // ),
                Text(
                  'Give your playlist a name',
                  style: secondaryWhiteTextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
                32.height,
                TextFormField(
                    controller: _playlistNameController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter playlist name',
                      hintStyle:
                          customTextStyle(fontSize: 16.0, color: greyColor),
                    ),
                    validator: FormValidatorUtil.playlistName),
                32.height,
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      /// * create new playlist
                      playlistService.createPlaylist(
                          name: _playlistNameController.text.trim());

                      /// * clear the controller
                      _playlistNameController.clear();

                      /// * close the sheet
                      Get.back();
                    } else {
                      ToastUtil.error('Something else');
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 50.0,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
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
                    child: Text('Create',
                        style: customTextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: kWhiteColor)),
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
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
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 36,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(194, 194, 194, 0.5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ]), //singleChildScroll
        ), //Padding
      ),
    );
  }
}
