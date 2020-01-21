// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:maya_clock/ui/widgets/inner_shadow_container.dart';
import 'package:maya_clock/ui/widgets/maya_number_board.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';

/// A Maya Clock.
///
/// One way to represent maya numbers!
class MayaClock extends StatefulWidget {
  const MayaClock(this.model);

  final ClockModel model;

  @override
  _MayaClockState createState() => _MayaClockState();
}

class _MayaClockState extends State<MayaClock> {
  var _now = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(MayaClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {}

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once every 10 seconds.
      _timer = Timer(
        Duration(seconds: 10) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_now);
    final minute = DateFormat('mm').format(_now);
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            // Main shadow color for all elements
            primaryColor: Color(0xff335399),
            // Dark shadow elements
            primaryColorDark: Color(0x66ffffff),
            // FontColor
            accentColor: Color(0xfffafcff),
            backgroundColor: Color(0xFF87A0D7),
          )
        : Theme.of(context).copyWith(
            // Main shadow color for all elements
            primaryColor: Color(0xff335399),
            // Dark shadow elements
            primaryColorDark: Color(0x66ffffff),
            // FontColor
            accentColor: Color(0xfffafcff),
            backgroundColor: Color(0xFF181818),
          );

    final time = DateFormat.Hms().format(DateTime.now());
    // Calculating new height respect to ratio 5/3
    double newHeight = MediaQuery.of(context).size.width / (5 / 3);

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Maya clock with time $time',
        value: time,
      ),
      child: Container(
        color: customTheme.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Evaluating hour format
                widget.model.is24HourFormat
                    ?
                    // Showing two sectios equal like minutes
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Top section to represent 20 vigesimal number after
                          // 20 hours
                          InnerShadowContainer(
                            darkShadowColor: customTheme.primaryColorDark,
                            backgroundShadowColor: customTheme.primaryColor,
                            child: new Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: newHeight * 0.24,
                              decoration: new BoxDecoration(
                                  color: customTheme.backgroundColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30))),
                              child: MayaNumberBoard(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  heigh: 350,
                                  value: int.parse(hour) ~/ 20,
                                  backgroundColor: customTheme.backgroundColor,
                                  primaryColorDark: customTheme.primaryColor,
                                  darkShadowColor:
                                      customTheme.primaryColorDark),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Down section to represent 0 to 19 maya numbers for hours
                          InnerShadowContainer(
                            darkShadowColor: customTheme.primaryColorDark,
                            backgroundShadowColor: customTheme.primaryColor,
                            child: new Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: newHeight * 0.24,
                              decoration: new BoxDecoration(
                                  color: customTheme.backgroundColor,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30))),
                              child: MayaNumberBoard(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  heigh: 350,
                                  value: int.parse(hour) % 20,
                                  backgroundColor: customTheme.backgroundColor,
                                  primaryColorDark: customTheme.primaryColor,
                                  darkShadowColor:
                                      customTheme.primaryColorDark),
                            ),
                          ),
                        ],
                      )
                    : InnerShadowContainer(
                        darkShadowColor: customTheme.primaryColorDark,
                        backgroundShadowColor: customTheme.primaryColor,
                        child: new Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: newHeight * 0.5,
                          decoration: new BoxDecoration(
                              color: customTheme.backgroundColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          child: MayaNumberBoard(
                              width: MediaQuery.of(context).size.width * 0.35,
                              heigh: newHeight * 0.5,
                              value: int.parse(hour),
                              backgroundColor: customTheme.backgroundColor,
                              primaryColorDark: customTheme.primaryColor,
                              darkShadowColor: customTheme.primaryColorDark),
                        ),
                      ),
                SizedBox(
                  width: 20,
                ),
                // Right clock side, indicates minutes in maya numbers
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Top section to represent 20,40,60 vigesimal numbers
                    InnerShadowContainer(
                      darkShadowColor: customTheme.primaryColorDark,
                      backgroundShadowColor: customTheme.primaryColor,
                      child: new Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: newHeight * 0.24,
                        decoration: new BoxDecoration(
                            color: customTheme.backgroundColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30))),
                        child: MayaNumberBoard(
                            width: MediaQuery.of(context).size.width * 0.35,
                            heigh: 350,
                            value: int.parse(minute) ~/ 20,
                            backgroundColor: customTheme.backgroundColor,
                            primaryColorDark: customTheme.primaryColor,
                            darkShadowColor: customTheme.primaryColorDark),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Down section to represent 0 to 19 maya numbers
                    InnerShadowContainer(
                      darkShadowColor: customTheme.primaryColorDark,
                      backgroundShadowColor: customTheme.primaryColor,
                      child: new Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: newHeight * 0.24,
                        decoration: new BoxDecoration(
                            color: customTheme.backgroundColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30))),
                        child: MayaNumberBoard(
                            width: MediaQuery.of(context).size.width * 0.35,
                            heigh: 350,
                            value: int.parse(minute) % 20,
                            backgroundColor: customTheme.backgroundColor,
                            primaryColorDark: customTheme.primaryColor,
                            darkShadowColor: customTheme.primaryColorDark),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Bottom digital clock section
            InnerShadowContainer(
              darkShadowColor: customTheme.primaryColorDark,
              backgroundShadowColor: customTheme.primaryColor,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: newHeight * 0.1,
                decoration: BoxDecoration(
                  color: customTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(hour + ' : ' + minute,
                      style: TextStyle(
                        color: customTheme.accentColor,
                        fontSize: newHeight * 0.12 / 2,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
