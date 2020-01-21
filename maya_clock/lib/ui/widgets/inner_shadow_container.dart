import 'package:maya_clock/ui/widgets/inner_shadow.dart';
import 'package:flutter/material.dart';

/// The InnerShadowContainer
///
/// The container needs to paint two inner shadows
/// to give a different look and feel, this pattern
/// will be used for all elements on this clock
class InnerShadowContainer extends StatelessWidget {
  final Widget child;
  final Color darkShadowColor;
  final Color backgroundShadowColor;
  const InnerShadowContainer(
      {this.child, this.darkShadowColor, this.backgroundShadowColor, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InnerShadow(
            color: darkShadowColor,
            offset: Offset(10, 10),
            blur: 20,
            child: InnerShadow(
              color: backgroundShadowColor,
              offset: Offset(-5, -5),
              blur: 20,
              child: child,
            )));
  }
}
