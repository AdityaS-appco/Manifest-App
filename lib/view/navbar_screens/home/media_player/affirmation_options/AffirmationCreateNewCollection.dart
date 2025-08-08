import 'package:manifest/core/services/collection_service.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/helper/import.dart';

class AffirmationCreateNewCollectionScreen extends StatelessWidget
    with ProfileControllerMixin {
  AffirmationCreateNewCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _collectionNameController =
        TextEditingController();

    return Container(
      height: kSize.height * 0.88,
      width: kSize.width,
      decoration: const BoxDecoration(
        color: Color(0xff1d2125),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Give your collection a name',
                style: secondaryWhiteTextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              32.height,
              TextField(
                controller: _collectionNameController,
                textAlign: TextAlign.center,
                style: customTextStyle(fontSize: 16.0, color: AppColors.light),
                decoration: InputDecoration(
                  hintText: 'Collection Name',
                  hintStyle: customTextStyle(fontSize: 16.0, color: greyColor),
                ),
              ),
              32.height,
              OutlinedButton(
                onPressed: () {
                  /// * create new collection
                  Get.find<CollectionService>().createCollection(
                    name: _collectionNameController.text,
                    userId: profile.id?.toString() ?? '',
                  );

                  /// * reset the textfield
                  _collectionNameController.clear();

                  /// * close the bottomsheet
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                  // Ensure the button has transparent border color
                  side: const BorderSide(color: Colors.transparent),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: AlignmentDirectional.topEnd,
                      colors: [
                        Color(0xFFA28DF6),
                        Color(0xFF5B4A9F)
                      ], // Example gradient colors
                    ),
                    border: Border.all(color: Colors.transparent),
                    // Ensure border is transparent
                    borderRadius: BorderRadius.circular(
                        24), // You can adjust the radius as needed
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: const Color(0xff394239),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: kWhiteColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: mediumGrey,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ]), //singleChildScroll
      ), //Padding
    );
  }
}
