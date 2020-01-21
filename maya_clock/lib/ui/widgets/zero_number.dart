import 'package:maya_clock/ui/widgets/inner_shadow_container.dart';
import 'package:flutter/material.dart';

class ZeroMayaNumber extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  const ZeroMayaNumber({this.width, this.height, this.color, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InnerShadowContainer(
      darkShadowColor: Color(0x66ffffff),
      backgroundShadowColor: Color(0xff335399),
      child: AnimatedContainer(
        duration: Duration(seconds: 2),
        width: width,
        height: height,
        child: CustomPaint(
          painter:
              _CustomZeroPainter(width: width, height: height, color: color),
        ),
      ),
    );
  }
}

class _CustomZeroPainter extends CustomPainter {
  _CustomZeroPainter({
    @required this.width,
    @required this.height,
    @required this.color,
  }) : assert(color != null);

  double width;
  double height;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    // Drawing a cacao element which
    // represents number 0
    Path pathShape = Path();
    pathShape.moveTo(0, height / 2);
    pathShape.quadraticBezierTo(width / 2, height * 1.5, width, height / 2);
    pathShape.moveTo(0, height / 2);
    pathShape.quadraticBezierTo(width / 2, -height / 2, width, height / 2);
    canvas.drawPath(pathShape, paint);
  }

  @override
  bool shouldRepaint(_CustomZeroPainter old) {
    return true;
  }
}
