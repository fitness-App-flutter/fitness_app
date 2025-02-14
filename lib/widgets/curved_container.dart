import 'package:flutter/material.dart';

class CurvedContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double heightFactor;

  const CurvedContainer({
    Key? key,
    required this.child,
    this.color = Colors.blueAccent,
    this.heightFactor = 0.4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: CurvedClipper(),
        child: Container(
          height: MediaQuery.of(context).size.height * heightFactor,
          color: color,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: child,
        ),
      ),
    );
  }
}

// Custom Clipper for Curved Effect
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.quadraticBezierTo(size.width * .3, size.height * .4, size.width, size.height * 0.2);
    path.quadraticBezierTo(size.width * .8, size.height * .1, size.width, size.height * 0.2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
