import 'package:maya_clock/ui/widgets/inner_shadow_container.dart';
import 'package:flutter/material.dart';

class MayaNumber extends StatelessWidget {
  final double width;
  final double height;
  final int value;
  final Color backgroundColor;
  const MayaNumber(
      {this.width, this.height, this.value, this.backgroundColor, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InnerShadowContainer(
        darkShadowColor: Color(0x66ffffff),
        backgroundShadowColor: Color(0xff335399),
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: backgroundColor,
              shape: value < 5 ? BoxShape.circle : BoxShape.rectangle,
              borderRadius:
                  value < 5 ? null : BorderRadius.all(Radius.circular(30))),
        ),
      ),
    );
  }
}
