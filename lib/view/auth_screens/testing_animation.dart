
import 'package:flutter/material.dart';



// class ShiningOnLogoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           title: Text('Shining Effect on Logo'),
//         ),
//         body: Center(
//           child: ShiningLogo(
//             image: AssetImage('assets/images/splash_logo.png'),
//             gradient: LinearGradient(
//               colors: [
//                 Colors.white.withOpacity(0.2),
//                 Color(0xFFFFFFFF),
//                 Color(0xFFFFFFFF)
//               ],
//               begin: Alignment.topRight,
//               end: Alignment.topLeft,
//               // You can adjust other properties like tileMode, stops, etc. if needed
//             ),
//             duration: Duration(seconds: 2), // Adjust the duration of the animation
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ShiningLogo extends StatefulWidget {
//   final ImageProvider image;
//   final Gradient gradient;
//   final Duration duration;
//
//   ShiningLogo({
//     required this.image,
//     required this.gradient,
//     required this.duration,
//   });
//
//   @override
//   _ShiningLogoState createState() => _ShiningLogoState();
// }
//
// class _ShiningLogoState extends State<ShiningLogo> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this, duration: widget.duration);
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       });
//
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (Rect bounds) {
//         return LinearGradient(
//           colors: [
//             widget.gradient.colors.last, // Animated opacity
//             widget.gradient.colors.first.withOpacity(_animation.value),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ).createShader(bounds);
//       },
//       child: Image(
//         image: widget.image,
//       ),
//     );
//   }
// }
//
//
// class AnimatedGradientInsideImage extends StatefulWidget {
//   final ImageProvider image;
//   final RadialGradient gradient;
//   final Duration duration;
//
//   AnimatedGradientInsideImage({
//     required this.image,
//     required this.gradient,
//     required this.duration,
//   });
//
//   @override
//   _AnimatedGradientInsideImageState createState() =>
//       _AnimatedGradientInsideImageState();
// }
//
// class _AnimatedGradientInsideImageState
//     extends State<AnimatedGradientInsideImage>
//     with SingleTickerProviderStateMixin {
//
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: widget.duration,
//     );
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _controller.reverse();
//         }
//       });
//     _controller.forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (BuildContext context, Widget? child) {
//         // Update the gradient's radius with the animation value
//         RadialGradient animatedGradient = RadialGradient(
//           colors: widget.gradient.colors,
//           center: widget.gradient.center,
//           radius: _animation.value,
//         );
//         return ClipRect(
//           child: ShaderMask(
//             shaderCallback: (Rect bounds) {
//               return animatedGradient.createShader(bounds);
//             },
//             blendMode: BlendMode.srcIn,
//             child: Image(
//               image: widget.image,
//               fit: BoxFit.cover,
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }




// class ShiningOnLogoApp extends StatefulWidget {
//   const ShiningOnLogoApp({super.key});
//
//   @override
//   State<ShiningOnLogoApp> createState() => _ShiningOnLogoAppState();
// }
//
// class _ShiningOnLogoAppState extends State<ShiningOnLogoApp> with SingleTickerProviderStateMixin{
//
//   late AnimationController _controller;
//   late Animation<Alignment> _topALignmentAnimation;
//   late Animation<Alignment> _bottomALigmentAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this,duration: Duration(seconds: 4));
//     _topALignmentAnimation = TweenSequence<Alignment>(
//       [
//         TweenSequenceItem<Alignment>(
//             tween: Tween<Alignment>(begin: Alignment.topLeft,end: Alignment.topRight),
//             weight: 1,
//         ),
//         TweenSequenceItem<Alignment>(
//           tween: Tween<Alignment>(begin: Alignment.topRight,end: Alignment.bottomRight),
//           weight: 1,
//         ),
//         TweenSequenceItem<Alignment>(
//           tween: Tween<Alignment>(begin: Alignment.bottomRight,end: Alignment.bottomLeft),
//           weight: 1,
//         ),
//         TweenSequenceItem<Alignment>(
//           tween: Tween<Alignment>(begin: Alignment.bottomLeft,end: Alignment.topLeft),
//           weight: 1,
//         ),
//       ],
//     ).animate(_controller);
//
//     _bottomALigmentAnimation = TweenSequence<Alignment>(
//       [
//         TweenSequenceItem<Alignment>(
//           tween: Tween<Alignment>(begin: Alignment.bottomRight,end: Alignment.bottomLeft),
//           weight: 1,
//         ),
//         TweenSequenceItem<Alignment>(
//           tween: Tween<Alignment>(begin: Alignment.bottomLeft,end: Alignment.topLeft),
//           weight: 1,
//         ),
//         TweenSequenceItem<Alignment>(
//           tween: Tween<Alignment>(begin: Alignment.topLeft,end: Alignment.topRight),
//           weight: 1,
//         ),
//         TweenSequenceItem<Alignment>(
//           tween: Tween<Alignment>(begin: Alignment.topRight,end: Alignment.bottomRight),
//           weight: 1,
//         ),
//       ],
//     ).animate(_controller);
//
//     _controller.repeat();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade800,
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (context,_) {
//             return Container(
//               height: 200,
//               width: 200,
//               decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   const Color(0xFF7A2CFA).withOpacity(0.78),
//                   const Color(0xFF6EDCFF),
//                   const Color(0xFF6D8DFF),
//                   const Color(0xFF6EDCFF)
//                 ],
//                 begin: _topALignmentAnimation.value,
//                 end: _bottomALigmentAnimation.value,
//               )
//               ),
//             );
//           }
//         ),
//       ),
//     );
//   }
// }






// class ShiningOnLogoApp extends StatelessWidget {
//   const ShiningOnLogoApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Stack(
//           children: [
//             GradientAnimation(),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class GradientAnimation extends StatefulWidget {
//   @override
//   _GradientAnimationState createState() => _GradientAnimationState();
// }
//
// class _GradientAnimationState extends State<GradientAnimation> with TickerProviderStateMixin {
//   // Declare _controller here, but initialize in initState
//   late AnimationController _controller;
//   List<Color> _colors = [
//     const Color(0xff33267C),
//     const Color(0xFF6EDCFF),// Slightly lighter blue
//     const Color(0xFF6EDCFF),
//     const Color(0xff33267C)
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(duration: Duration(seconds: 2), vsync: this);
//     _controller.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         final animationValue = _controller.value; // 0.0 to 1.0
//         final blendFactor = animationValue.clamp(0.0, 1.0); // Clamp to avoid exceeding range
//
//         final beginColor = ColorTween(begin: _colors[0], end: _colors[1]).lerp(blendFactor);
//         final endColor = ColorTween(begin: _colors[1], end: _colors[2]).lerp(blendFactor);
//
//         return Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [beginColor!, endColor!], // Use evaluated colors
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


// import 'dart:ui';
// import 'package:flutter/material.dart';


// class GradientAnimation extends StatelessWidget {
//   const GradientAnimation({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
//       home: const GradientAnimation2(),
//     );
//   }
// }
//
// class GradientAnimation2 extends StatefulWidget {
//   const GradientAnimation2({Key? key,}) : super(key: key);
//   @override
//   State<GradientAnimation2> createState() => _GradientAnimation2State();
// }
//
// class _GradientAnimation2State extends State<GradientAnimation2> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: BackgroundWidget()
//     );
//   }
// }



// class BackgroundWidget extends StatefulWidget {
//   @override
//   State<BackgroundWidget> createState() => _BackgroundWidgetState();
// }
//
// class _BackgroundWidgetState extends State<BackgroundWidget>
//     with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     _controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 6));
//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
//     _controller.repeat(reverse: true);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.removeStatusListener((status) {});
//     _controller.dispose();
//
//     super.dispose();
//   }
//
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Stack(
//         children: [
//           AnimatedBuilder(
//               animation: _animation,
//               builder: (context, child) {
//                 return CustomPaint(
//                   painter: BackgroundPainter(
//                     _animation,
//                   ),
//                   child: Container(),
//                 );
//               }),
//           BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
//               child: Container(
//                 color: Colors.black.withOpacity(0.1),
//               )),
//           //widget.child,
//         ],
//       ),
//     );
//   }
// }
//
// class BackgroundPainter extends CustomPainter {
//   final Animation<double> animation;
//
//   BackgroundPainter(this.animation);
//   Offset getOffset(Path path) {
//     final pms = path.computeMetrics(forceClosed: false).elementAt(0);
//     final length = pms.length;
//     final offset = pms.getTangentForOffset(length * animation.value)!.position;
//     return offset;
//   }
//
//   // Offset getOffset(Path path) {
//   //   final pms = path.computeMetrics(forceClosed: false).elementAt(0);
//   //   final length = pms.length;
//   //   final offset = pms.getTangentForOffset(length * animation.value)!.position;
//   //   return offset;
//   // }
//
//   void drawSquare(Canvas canvas, Size size) {
//     final paint1 = Paint();
//     paint1.color = const Color(0xFF6D8DFF);
//     paint1.maskFilter = MaskFilter.blur(BlurStyle.normal, 100);
//     paint1.style = PaintingStyle.fill;
//     canvas.drawRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromCenter(
//             center: Offset(size.width * 0.75, 100),
//             width: 300,
//             height: 300,
//           ),
//           Radius.circular(20),
//         ),
//         paint1);
//   }
//
//   void drawEllipse(Canvas canvas, Size size, Paint paint) {
//     final path = Path();
//     paint.color = Color(0xFF6EDCFF);
//     paint.style = PaintingStyle.stroke;
//     path.moveTo(size.width * 0.4, -100);
//     path.quadraticBezierTo(size.width * 0.8, size.height * 0.6,
//         size.width * 1.2, size.height * 0.4);
//     // canvas.drawPath(path, paint);
//
//     paint.style = PaintingStyle.fill;
//     canvas.drawOval(
//         Rect.fromCenter(
//           center: getOffset(path),
//           width: 450,
//           height: 250,
//         ),
//         paint);
//   }
//
//   void drawTriangle(Canvas canvas, Size size, paint) {
//     paint.color = Color(0xFF7A2CFA).withOpacity(0.78);
//     final path = Path();
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 10.0;
//     path.moveTo(-100.0, size.height * 0.5);
//     path.quadraticBezierTo(
//         300, size.height * 0.7, size.width, size.height * 1.2);
//     // canvas.drawPath(path, paint);
//     paint.style = PaintingStyle.fill;
//
//     // draw triangle
//     final offset = getOffset(path);
//     canvas.drawPath(
//         Path()
//           ..moveTo(offset.dx, offset.dy)
//           ..lineTo(offset.dx + 450, offset.dy + 150)
//           ..lineTo(offset.dx + 250, offset.dy - 500)
//           ..close(),
//         paint);
//   }
//
//   void drawCircle(Canvas canvas, Size size, Paint paint) {
//     paint.color = Color(0xFF814AFF);
//     Path path = Path();
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 10.0;
//     path.moveTo(size.width * 1.1, size.height / 4);
//     path.quadraticBezierTo(
//         size.width / 2, size.height * 1.0, -100, size.height / 4);
//     // canvas.drawPath((path), paint);
//     paint.style = PaintingStyle.fill;
//     final offset = getOffset(path);
//     canvas.drawCircle(offset, 150, paint);
//   }
//
//   void drawAbstractShapes(Canvas canvas, Size size) {
//     Path path = Path();
//     final paint = Paint();
//     path.moveTo(size.width * 1.2, 0);
//     path.quadraticBezierTo(
//         size.width * 1.2, 300, size.width * 0.4, size.height * 0.6);
//     path.quadraticBezierTo(
//         size.width * 0.1, size.height * 0.7, -100, size.height * 1.2);
//     path.lineTo(-50, -50);
//     path.close();
//     paint.maskFilter = MaskFilter.blur(BlurStyle.normal, 100);
//     canvas.drawPath(
//         path,
//         paint
//           ..color = Color(0xFF814AFF)
//           ..style = PaintingStyle.fill);
//     drawSquare(canvas, size);
//   }
//
//   void drawContrastingBlobs(Canvas canvas, Size size, Paint paint) {
//     paint.maskFilter = MaskFilter.blur(BlurStyle.normal, 30);
//     paint.blendMode = BlendMode.overlay;
//     drawCircle(canvas, size, paint);
//     drawTriangle(canvas, size, paint);
//     drawEllipse(canvas, size, paint);
//   }
//
//   void paintBackground(Canvas canvas, Size size) {
//     canvas.drawRect(
//         Rect.fromCenter(
//           center: Offset(size.width * 0.5, size.height * 0.5),
//           width: size.width,
//           height: size.height,
//         ),
//         Paint()..color = Color(0xFF6EDCFF));
//   }
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     paintBackground(canvas, size);
//     drawAbstractShapes(canvas, size);
//     final paint = Paint();
//     drawContrastingBlobs(canvas, size, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return oldDelegate != this;
//   }
// }

// class ShiningOnLogoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Gradient Text Animation'),
//         ),
//         body: Center(
//           child: GradientTextAnimation1(text: 'Hamid',textStyle: TextStyle(
//             fontSize: 40.0,
//             fontWeight: FontWeight.bold,
//           ),textAlign: TextAlign.center),
//         ),
//       ),
//     );
//   }
// }
//
// class GradientTextAnimation1 extends StatefulWidget {
//   final String text;
//   final TextStyle textStyle;
//   final TextAlign textAlign;
//
//   const GradientTextAnimation1({
//     Key? key,
//     required this.text,
//     required this.textStyle,
//     required this.textAlign,
//   }) : super(key: key);
//
//   @override
//   _GradientTextAnimation1State createState() => _GradientTextAnimation1State();
// }
//
// class _GradientTextAnimation1State extends State<GradientTextAnimation1>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 16),
//     )..repeat();
//     _animation = Tween<double>(begin: 0.0, end: 2.0 * 3.14159).animate(_controller);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return ShaderMask(
//           blendMode: BlendMode.srcIn,
//           shaderCallback: (Rect bounds) {
//             return LinearGradient(
//               colors: [
//                 const Color(0xFFFFFFFF),
//                 const Color(0xFFFFFFFF),
//                 const Color(0xFF6EDCFF),
//                 //const Color(0xFF814AFF)
//               ],
//               tileMode: TileMode.mirror,
//               transform: GradientRotation(_animation.value),
//             ).createShader(bounds);
//           },
//           child: Text(
//             widget.text,
//             style: widget.textStyle,
//             textAlign: widget.textAlign,
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }


// import 'dart:ui';
// import 'dart:math';
// import 'package:flutter/material.dart';
//
// class ShiningOnLogoApp extends StatefulWidget {
//   @override
//   State<ShiningOnLogoApp> createState() =>
//       _ShiningOnLogoAppState();
// }
//
// class _ShiningOnLogoAppState extends State<ShiningOnLogoApp>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     _controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 3));
//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
//     _controller.repeat(reverse: true);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Offset getOffset(Path path, double random) {
//     final pms = path.computeMetrics(forceClosed: false).elementAt(0);
//     final length = pms.length;
//     final offset =
//         pms.getTangentForOffset(length * _animation.value + random)!.position;
//     return offset;
//   }
//
//   void drawAbstractShapes(Canvas canvas, Size size, Random random) {
//     final path = Path();
//     final paint = Paint();
//     path.moveTo(size.width * 1.2, 0);
//     path.quadraticBezierTo(
//         size.width * 1.2, 300, size.width * 0.4, size.height * 0.6);
//     path.quadraticBezierTo(
//         size.width * 0.1, size.height * 0.7, -100, size.height * 1.2);
//     path.lineTo(-50, -50);
//     path.close();
//     paint.maskFilter = MaskFilter.blur(BlurStyle.normal, 100);
//     canvas.drawPath(
//         path,
//         paint
//           ..color = Color(0xFF814AFF)
//           ..style = PaintingStyle.fill);
//     drawSquare(canvas, size);
//   }
//
//   void drawContrastingBlobs(Canvas canvas, Size size, Paint paint) {
//     final random = Random();
//     paint.maskFilter = MaskFilter.blur(BlurStyle.normal, 30);
//     paint.blendMode = BlendMode.overlay;
//     drawCircle(canvas, size, paint, random.nextDouble());
//     drawTriangle(canvas, size, paint, random.nextDouble());
//     drawEllipse(canvas, size, paint, random.nextDouble());
//   }
//
//   void drawCircle(Canvas canvas, Size size, Paint paint, double random) {
//     final path = Path();
//     paint.color = Color(0xFF6EDCFF);
//     path.moveTo(size.width * 1.1, size.height / 4);
//     path.quadraticBezierTo(
//         size.width / 2, size.height * 1.0, -100, size.height / 4);
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 10.0;
//     final offset = getOffset(path, random);
//     canvas.drawCircle(offset, 150, paint);
//   }
//
//   void drawTriangle(Canvas canvas, Size size, Paint paint, double random) {
//     paint.color = Color(0xFF6EDCFF).withOpacity(0.78);
//     final path = Path();
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 10.0;
//     path.moveTo(-100.0, size.height * 0.5);
//     path.quadraticBezierTo(
//         300, size.height * 0.7, size.width, size.height * 1.2);
//     paint.style = PaintingStyle.fill;
//     final offset = getOffset(path, random);
//     canvas.drawPath(
//         Path()
//           ..moveTo(offset.dx, offset.dy)
//           ..lineTo(offset.dx + 450, offset.dy + 150)
//           ..lineTo(offset.dx + 250, offset.dy - 500)
//           ..close(),
//         paint);
//   }
//
//   void drawEllipse(Canvas canvas, Size size, Paint paint, double random) {
//     final path = Path();
//     paint.color = Color(0xFF6EDCFF);
//     paint.style = PaintingStyle.stroke;
//     path.moveTo(size.width * 0.4, -100);
//     path.quadraticBezierTo(size.width * 0.8, size.height * 0.6,
//         size.width * 1.2, size.height * 0.4);
//     paint.style = PaintingStyle.fill;
//     final offset = getOffset(path, random);
//     canvas.drawOval(
//         Rect.fromCenter(
//           center: offset,
//           width: 450,
//           height: 250,
//         ),
//         paint);
//   }
//
//   void drawSquare(Canvas canvas, Size size) {
//     final paint1 = Paint();
//     paint1.color = const Color(0xFF6EDCFF);
//     paint1.maskFilter = MaskFilter.blur(BlurStyle.normal, 100);
//     paint1.style = PaintingStyle.fill;
//     canvas.drawRRect(
//         RRect.fromRectAndRadius(
//           Rect.fromCenter(
//             center: Offset(size.width * 0.75, 100),
//             width: 300,
//             height: 300,
//           ),
//           Radius.circular(40),
//         ),
//         paint1);
//   }
//
//   void paintBackground(Canvas canvas, Size size) {
//     canvas.drawRect(
//         Rect.fromCenter(
//           center: Offset(size.width * 0.5, size.height * 0.5),
//           width: size.width,
//           height: size.height,
//         ),
//         Paint()..color = Color(0xFF6EDCFF));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Stack(
//         children: [
//           AnimatedBuilder(
//               animation: _animation,
//               builder: (context, child) {
//                 return CustomPaint(
//                   painter: BackgroundPainter(
//                     _animation,
//                   ),
//                   child: Container(),
//                 );
//               }),
//           BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
//               child: Container(
//                 color: Colors.black.withOpacity(0.1),
//               )),
//         ],
//       ),
//     );
//   }
// }
//
// class BackgroundPainter extends CustomPainter {
//   final Animation<double> animation;
//
//   BackgroundPainter(this.animation);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Your paint logic here
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return oldDelegate != this;
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: ShiningOnLogoApp(),
//     ),
//   ));
// }

// class ShiningOnLogoApp extends StatelessWidget {
//   const ShiningOnLogoApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       color: Colors.black,
//       title: 'Glass Bottom Navigation Bar',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const Scaffold(
//         backgroundColor: Colors.black,
//           body: Center(child: GlassBottomNavigationBar(text: 'aaaaa', style: TextStyle(),))),
//     );
//   }
// }
//
// class GlassBottomNavigationBar extends StatelessWidget {
//   final String text;
//   final TextStyle style;
//   final Color glowColor; // Optional for colored glow
//
//   const GlassBottomNavigationBar({super.key,
//     required this.text,
//     required this.style,
//     this.glowColor = Colors.white,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: GlowingTextPainter(text: text, style: style, glowColor: glowColor),
//     );
//   }
// }
//
// class GlowingTextPainter extends CustomPainter {
//   final String text;
//   final TextStyle style;
//   final Color glowColor;
//
//   GlowingTextPainter({
//     required this.text,
//     required this.style,
//     required this.glowColor,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     TextPainter textPainter = TextPainter(
//       text: TextSpan(
//         text: text,
//         style: style,
//       ),
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout(minWidth: 0, maxWidth: size.width);
//     textPainter.paint(canvas, const Offset(0, 0));
//
//     // Draw glow effect
//     Paint paint = Paint()
//       ..color = glowColor.withOpacity(0.5) // Adjust opacity for glow intensity
//       ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 10.0); // Adjust blurRadius
//
//    // canvas.drawPath(textPainter.path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
//
// class textEffect extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           title: Text('Text Effect Example'),
//         ),
//         body: Center(
//           child: Text(
//             'Hello, World!',
//             style: TextStyle(
//               fontSize: 54.0,
//               color: Colors.white, // Text color
//               shadows: [
//                 Shadow(
//                   color: Colors.grey.shade200,
//                   blurRadius: 8.0,// Shadow color
//                   offset: Offset(5.0, 4.0), // 0.0 offset
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


class AnimatedGradient extends StatefulWidget {
  const AnimatedGradient({super.key});

  @override
  _AnimatedGradientState createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {
  List<Color> colorList = [
    const Color(0xFF814AFF),
    const Color(0xFF6D8DFF),
    const Color(0xFF6EDCFF),
    const Color(0xFF7A2CFA).withOpacity(0.78),
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = const Color(0xFF814AFF);
  Color topColor = const Color(0xFF6D8DFF);
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              onEnd: () {
                setState(() {
                  index = index + 1;
                  // animate the color
                  bottomColor = colorList[index % colorList.length];
                  topColor = colorList[(index + 1) % colorList.length];

                  //// animate the alignment
                  // begin = alignmentList[index % alignmentList.length];
                  // end = alignmentList[(index + 2) % alignmentList.length];
                });
              },
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: begin, end: end, colors: [bottomColor, topColor])),
            ),
            Positioned.fill(
              child: IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    bottomColor = Colors.blue;
                  });
                },
              ),
            )
          ],
        ));
  }
}









