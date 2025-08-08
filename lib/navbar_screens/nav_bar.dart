// import 'dart:ui';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:manifest/controllers/explore_tab/explore_categories_controller.dart';
// // import 'package:manifest/features/explore/views/explore_main_screen.dart';
// import 'package:manifest/view/navbar_screens/home/home_page_new.dart';
//  import 'package:manifest/view/navbar_screens/user/user_dashboard.dart';
// import '../../helper/icons_and_images_path.dart';
// import 'playlist/playlist_main_page.dart';

// class NavBar extends StatefulWidget {
//   int currentIndex = 0;
//   NavBar({Key? key, this.currentIndex = 0}) : super(key: key);

//   @override
//   _NavBarState createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   int? _selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     /// ! already initialized in the dependency injection
//     // Get.put(ExploreCategoriesController());
//     _selectedIndex = widget.currentIndex;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       body: Stack(
//         children: [
//           IndexedStack(
//             index: _selectedIndex,
//             children: const [
//               // HomePage(),
//               HomePageByAlok(),
//               ExploreMainScreen(),
//               PlaylistPage(),
//               UserDashBoard(),
//             ],
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(14),
//                 topRight: Radius.circular(14),
//               ),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(
//                   sigmaX: 8.0,
//                   sigmaY: 8.0,
//                 ),
//                 child: BottomNavigationBar(
//                   backgroundColor: Colors.black38,
//                   showSelectedLabels: true,
//                   type: BottomNavigationBarType.fixed,
//                   elevation: 0.0,
//                   unselectedLabelStyle: customTextStyle(color: Colors.white70, fontSize: 10.0, fontWeight: FontWeight.w400),
//                   selectedLabelStyle: customTextStyle(color: lightGreyColor, fontSize: 10.0, fontWeight: FontWeight.w300),
//                   items: <BottomNavigationBarItem>[
//                     BottomNavigationBarItem(
//                       icon: Column(children: [
//                         _selectedIndex == 0
//                             ? SvgPicture.asset(AppIcons.bNaveSelectHome)
//                             : SvgPicture.asset(AppIcons.bNaveUnSelectHome),
//                         5.height,
//                       ],),
//                       label: AppStrings.home,
//                     ),
//                     BottomNavigationBarItem(
//                       icon: Column(children: [
//                         _selectedIndex == 1
//                             ? SvgPicture.asset(AppIcons.bNavSelectExplore)
//                             : SvgPicture.asset(AppIcons.bNavUnSelectExplore),
//                         5.height,
//                       ],),
//                       label: AppStrings.explore,
//                     ),
//                     BottomNavigationBarItem(
//                       icon: Column(children: [
//                         _selectedIndex == 2
//                             ? SvgPicture.asset(AppIcons.bNavSelectPlaylist)
//                             : SvgPicture.asset(AppIcons.bNavUnSelectPlaylist),
//                         5.height,
//                       ],),
//                       label: AppStrings.playlist,
//                     ),
//                     BottomNavigationBarItem(
//                       icon: Column(children: [
//                         _selectedIndex == 3 ? SvgPicture.asset(AppIcons.bNavSelectUser) : SvgPicture.asset(AppIcons.bNavUnSelectUser),
//                         5.height,
//                       ],),
//                       label: AppStrings.user,
//                     ),
//                   ],
//                   currentIndex: _selectedIndex!,
//                   onTap: (index) {
//                     setState(() {
//                       _selectedIndex = index;
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
