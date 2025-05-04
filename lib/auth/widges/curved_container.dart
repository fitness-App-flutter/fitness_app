import 'package:fitness_app/core/utils/color_extension.dart';
import 'package:flutter/material.dart';

class CurvedContainer extends StatelessWidget {
  final Widget child;
  final double heightFactor;

  const CurvedContainer({
    super.key,
    required this.child,
    this.heightFactor = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: CurvedClipper(),
        child: Container(
          height: MediaQuery.of(context).size.height * heightFactor,
          color: MyColors.blue_register,
          padding: const EdgeInsets.only(left: 20,right: 20,top: 60),
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