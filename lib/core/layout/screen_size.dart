import 'package:flutter/material.dart';

extension MySize on BuildContext {
  double getHorizontalPadding() {
    const double kDesignFullWidth = 414.0;
    const double k100Precentage = 100.0;
    double padding = 36.0;
    double size = ((padding * k100Precentage) / kDesignFullWidth);
    double actualPadding =
        (MediaQuery.of(this).size.width * size) / k100Precentage;
    return actualPadding - 10;
  }

  double getHomeCardSize() {
    const double k100Precentage = 100.0;
    return (MediaQuery.of(this).size.width / k100Precentage) * 20;
  }

  double get hSize => MediaQuery.of(this).size.height;
  double get wSize => MediaQuery.of(this).size.width;
}
