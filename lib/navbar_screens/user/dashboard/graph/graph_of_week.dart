// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
//
// class tabbarexample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Sliding Segmented Control Example'),
//         ),
//         body: Center(
//           child: SlidingSegmentedControlExample(),
//         ),
//       ),
//     );
//   }
// }
//
// class SlidingSegmentedControlExample extends StatefulWidget {
//   @override
//   _SlidingSegmentedControlExampleState createState() =>
//       _SlidingSegmentedControlExampleState();
// }
//
// class _SlidingSegmentedControlExampleState
//     extends State<SlidingSegmentedControlExample> {
//   int _sliding = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CupertinoSlidingSegmentedControl(
//           children: {
//             0: Text('Day',
//                 style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.w100,
//                     color: _sliding == 0 ? Colors.white : Colors.grey)),
//             1: Text('Week',
//                 style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.w100,
//                     color: _sliding == 1 ? Colors.white : Colors.grey)),
//             2: Text('Month',
//                 style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.w100,
//                     color: _sliding == 2 ? Colors.white : Colors.grey)),
//             3: Text('Year',
//                 style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.w100,
//                     color: _sliding == 3 ? Colors.white : Colors.grey)),
//           },
//           thumbColor: Colors.grey.shade700,
//           backgroundColor: Colors.grey.shade800,
//           groupValue: _sliding,
//           onValueChanged: (int? newValue) {
//             setState(() {
//               _sliding = newValue!;
//             });
//           },
//         ),
//         SizedBox(height: 20),
//         _sliding == 0
//             ? Container(
//           color: Colors.blue,
//           height: 100,
//           width: 200,
//           child: Center(child: Text('Day Container')),
//         )
//             : _sliding == 1
//             ? Container(
//           color: Colors.green,
//           height: 100,
//           width: 200,
//           child: Center(child: Text('Week Container')),
//         )
//             : _sliding == 2
//             ? Container(
//           color: Colors.orange,
//           height: 100,
//           width: 200,
//           child: Center(child: Text('Month Container')),
//         )
//             : Container(
//           color: Colors.red,
//           height: 100,
//           width: 200,
//           child: Center(child: Text('Year Container')),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:manifest/helper/constant.dart';
//
// class coustomscroll extends StatelessWidget {
//   int _sliding = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Custom ScrollView Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CustomScrollViewExample(),
//     );
//   }
// }
//
// class CustomScrollViewExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             title: Text('Custom Scroll View'),
//             expandedHeight: 200.0,
//             floating: false,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Image.network(
//                 'https://via.placeholder.com/500',
//                 fit: BoxFit.cover,
//               ),
//             ),
//
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 color: Colors.green,
//                 width: kSize.width,
//                 height: 400,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 color: Colors.green,
//                 width: kSize.width,
//                 height: 400,
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 color: Colors.green,
//                 width: kSize.width,
//                 height: 400,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


