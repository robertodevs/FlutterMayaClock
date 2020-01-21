import 'package:maya_clock/ui/widgets/maya_number.dart';
import 'package:maya_clock/ui/widgets/zero_number.dart';
import 'package:flutter/material.dart';

class MayaNumberBoard extends StatelessWidget {
  final int value;
  final double width;
  final double heigh;
  final Color backgroundColor;
  final Color primaryColorDark;
  final Color darkShadowColor;
  const MayaNumberBoard(
      {this.value,
      this.width,
      this.heigh,
      this.backgroundColor,
      this.primaryColorDark,
      this.darkShadowColor,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildNumber(value);
  }

  /// Building different atomic number
  /// From 0 to 19, according to the mayan number system
  /// and depending of [value]
  Widget _buildNumber(int value) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment(0, 0),
          child: _buildMayaNumberWidget(value),
        ),
      ],
    );
  }

  /// This method allow to get a list
  /// of children dynamically for every
  /// number [value] from 1 to 4
  Widget _buildChildrenUnits(int value, double size, Color backgroundColor) {
    List<Widget> atomicNumbers = [];
    for (var i = 0; i < value; i++) {
      atomicNumbers.add(MayaNumber(
          width: size,
          height: size,
          value: value,
          backgroundColor: backgroundColor));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: atomicNumbers,
    );
  }

  /// This method allow to get a list
  /// of a final columns dynamically for every
  /// number [value]
  Widget _buildMayaNumberWidget(int value) {
    // This represents a list of blocs which
    // contains horizontal bars and dots from 1 to 4
    List<Widget> childrenBlocNumbers = [];
    Widget unitsNumber;
    // Evaluating and assigning number of horizontal bars
    int horizontalBarNumbers = value ~/ 5;
    // Calculating and assigning remaining units
    int units = value % 5;
    // Evaluating the number zero
    if (value == 0) {
      childrenBlocNumbers.add(ZeroMayaNumber(
          width: width * 0.35, height: width * 0.15, color: backgroundColor));
    }
    // Evaluating if exists units
    if (units > 0 && units < 5) {
      // Reducing the size depending of the further numbers
      unitsNumber = _buildChildrenUnits(units,
          width * 0.15 / (1 + (horizontalBarNumbers * 0.3)), backgroundColor);
      childrenBlocNumbers.add(unitsNumber);
    }
    for (var i = 0; i < horizontalBarNumbers; i++) {
      childrenBlocNumbers.add(MayaNumber(
        width: width * 0.8,
        height: width * 0.15 / (horizontalBarNumbers),
        value: 5,
        backgroundColor: backgroundColor,
      ));
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: childrenBlocNumbers);
  }
}
