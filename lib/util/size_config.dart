import 'package:flutter/cupertino.dart';

class SizeConfig{

  SizeConfig._();

  static double screenHeight;
  static double screenWidth;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  static void init(BoxConstraints constraints){

    screenHeight = constraints.maxHeight;
    screenWidth = constraints.maxWidth;

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  static double setSp(num size) => size * blockSizeVertical;
  static double setHeight(num size) => size * blockSizeVertical;
  static double setWidth(num size) => size * blockSizeHorizontal;
}

extension SizeExtensionInteger on num{
  num get t => SizeConfig.setSp(this);
  num get h => SizeConfig.setHeight(this);
  num get w => SizeConfig.setWidth(this);
}