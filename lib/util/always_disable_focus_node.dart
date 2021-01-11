import 'package:flutter/cupertino.dart';

class AlwaysDisableFocusNode extends FocusNode{
  @override
  // TODO: implement hasFocus
  bool get hasFocus => false;
}