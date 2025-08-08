# App Icon Change Implementation Guide

## Overview

This guide details the implementation of app icon changing functionality in Flutter, allowing users to switch between different app icons dynamically.

## Prerequisites

1. Add the `flutter_dynamic_icons` package to `pubspec.yaml`:

```yaml
dependencies:
  flutter_dynamic_icons: ^latest_version
```

## Implementation Steps

### 1. Create App Icon Model

```dart
class AppIconModel {
  final String name;
  final String iconName;
  final String previewPath;
  final bool isSelected;

  const AppIconModel({
    required this.name,
    required this.iconName,
    required this.previewPath,
    this.isSelected = false,
  });
}
```

### 2. Create App Icon Controller

```dart
class AppIconController extends GetxController {
  final RxList<AppIconModel> appIcons = <AppIconModel>[].obs;
  final RxString currentIcon = ''.obs;

  static const String defaultIcon = 'default';

  final _icons = [
    AppIconModel(
      name: 'Default',
      iconName: defaultIcon,
      previewPath: 'assets/icons/default_preview.png'
    ),
    AppIconModel(
      name: 'Dreamy',
      iconName: 'dreamy',
      previewPath: 'assets/icons/dreamy_preview.png'
    ),
    AppIconModel(
      name: 'Thinker',
      iconName: 'thinker',
      previewPath: 'assets/icons/thinker_preview.png'
    ),
    AppIconModel(
      name: 'Mystic',
      iconName: 'mystic',
      previewPath: 'assets/icons/mystic_preview.png'
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _loadCurrentIcon();
    _initializeIcons();
  }

  Future<void> _loadCurrentIcon() async {
    final savedIcon = await Storage.getCurrentAppIcon();
    currentIcon.value = savedIcon ?? defaultIcon;
  }

  void _initializeIcons() {
    appIcons.value = _icons.map((icon) =>
      AppIconModel(
        name: icon.name,
        iconName: icon.iconName,
        previewPath: icon.previewPath,
        isSelected: icon.iconName == currentIcon.value
      )
    ).toList();
  }

  Future<void> changeAppIcon(String iconName) async {
    try {
      if (iconName == currentIcon.value) return;

      final success = await FlutterDynamicIcons.setAlternateIconName(
        iconName == defaultIcon ? null : iconName
      );

      if (success) {
        await Storage.saveCurrentAppIcon(iconName);
        currentIcon.value = iconName;
        _updateSelectedIcon(iconName);
        ToastUtil.success(
          'App icon changed successfully'
        );
      }
    } catch (e) {
      ToastUtil.error(
        'Failed to change app icon'
      );
      print('Error changing app icon: $e');
    }
  }

  void _updateSelectedIcon(String iconName) {
    final updatedIcons = appIcons.map((icon) =>
      AppIconModel(
        name: icon.name,
        iconName: icon.iconName,
        previewPath: icon.previewPath,
        isSelected: icon.iconName == iconName
      )
    ).toList();
    appIcons.value = updatedIcons;
  }
}
```

### 3. Update ChangeAppIcons Widget

```dart
class ChangeAppIcons extends GetView<AppIconController> {
  const ChangeAppIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kSize.width,
      decoration: BoxDecoration(
        color: dashboardCardBgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildIconGrid(),
          const Gap(40.0),
        ],
      ),
    );
  }

  Widget _buildIconGrid() {
    return Obx(() =>
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.appIcons.map((icon) =>
            AppIconTile(
              icon: icon,
              onTap: () => controller.changeAppIcon(icon.iconName),
            )
          ).toList(),
        ),
      )
    );
  }
}
```

### 4. Create AppIconTile Widget

```dart
class AppIconTile extends StatelessWidget {
  final AppIconModel icon;
  final VoidCallback onTap;

  const AppIconTile({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: icon.isSelected ?
                  AppColors.primary.withOpacity(0.5) :
                  Colors.blue.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12.0),
                border: icon.isSelected ?
                  Border.all(color: AppColors.primary, width: 2) :
                  null,
              ),
              child: Image.asset(icon.previewPath),
            ),
            const Gap(12.0),
            Text(
              icon.name,
              style: primaryWhiteTextStyle(
                color: kWhiteColor,
                fontWeight: icon.isSelected ?
                  FontWeight.w600 :
                  FontWeight.w400,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 5. Configure Platform-Specific Settings

#### iOS Configuration

1. Add alternate icons to `ios/Runner/Assets.xcassets/`
2. Update `Info.plist`:

```xml
<key>CFBundleIcons</key>
<dict>
    <key>CFBundleAlternateIcons</key>
    <dict>
        <key>dreamy</key>
        <dict>
            <key>CFBundleIconFiles</key>
            <array>
                <string>dreamy</string>
            </array>
        </dict>
        <!-- Add other alternate icons -->
    </dict>
</dict>
```

#### Android Configuration

1. Add alternate icons to `android/app/src/main/res/mipmap-{resolution}/`
2. Update `android/app/src/main/AndroidManifest.xml`:

```xml
<activity>
    <meta-data
        android:name="io.flutter.embedding.android.NormalTheme"
        android:resource="@style/NormalTheme"
    />
    <!-- Add alternate icons -->
    <meta-data
        android:name="dreamy_icon"
        android:resource="@mipmap/dreamy"
    />
</activity>
```

### 6. Storage Implementation

```dart
class Storage {
  static const String appIconKey = 'current_app_icon';

  static Future<String?> getCurrentAppIcon() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(appIconKey);
  }

  static Future<void> saveCurrentAppIcon(String iconName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(appIconKey, iconName);
  }
}
```

## Testing Checklist

1. Icon Change Functionality

   - [ ] All icons load correctly
   - [ ] Icon change works on both platforms
   - [ ] Selection state updates correctly
   - [ ] Error handling works properly

2. UI/UX

   - [ ] Smooth animations
   - [ ] Proper feedback on icon change
   - [ ] Correct icon previews
   - [ ] Proper selection indicators

3. Platform Specific
   - [ ] Icons work on iOS
   - [ ] Icons work on Android
   - [ ] Proper fallback behavior

## Error Handling

1. Platform Support

```dart
bool isPlatformSupported() {
  if (Platform.isAndroid || Platform.isIOS) {
    return true;
  }
  throw PlatformException(
    code: 'unsupported_platform',
    message: 'Icon changing is only supported on iOS and Android',
  );
}
```

2. Icon Change Failures

```dart
void handleIconChangeError(dynamic error) {
  ToastUtil.error(
    'Failed to change app icon: ${error.toString()}'
  );
}
```
