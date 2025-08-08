// ! author: @alok_singh

class AssetConstants {
  static const String _logoPath = "assets/logos/";
  static const String _iconPath = "assets/icons/";
  static const String _iconAllPath = "assets/icons_all/";
  static const String _imagePath = "assets/images/";
  static const String _lottiePath = "assets/lottie/";
  static const String _audioPath = "assets/audios/";
  static const String _fontPath = "assets/fonts/";
  static const String _lineIconPath = "assets/line_icons/";

  static String getLogoPath(String logoName) => "$_logoPath$logoName";
  static String getIconPath(String iconName) => "$_iconPath$iconName";
  static String getIconAllPath(String iconName) => "$_iconAllPath$iconName";
  static String getImagePath(String imageName) => "$_imagePath$imageName";
  static String getLottiePath(String lottieName) => "$_lottiePath$lottieName";
  static String getAudioPath(String audioName) => "$_audioPath$audioName";
  static String getFontPath(String fontName) => "$_fontPath$fontName";
  static String getLineIconPath(String lineIconName) =>
      "$_lineIconPath$lineIconName";
}
