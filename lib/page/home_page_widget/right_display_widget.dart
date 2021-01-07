import 'package:flutter/material.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:provider/provider.dart';

class RightDisplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<HomePageProvider>(context);
    return _provider.rideSideWidget;
  }
}
