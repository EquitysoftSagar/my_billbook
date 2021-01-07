import 'package:flutter/material.dart';
import 'package:my_billbook/list_widget/drawer_document_widget.dart';
import 'package:my_billbook/list_widget/drawer_item_list.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:provider/provider.dart';
class DrawerWidget extends StatelessWidget {

  HomePageProvider _provider;
  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<HomePageProvider>(context);

    return Container(
      color: MyColors.drawer,
      width: 200,
      child: ListView(
        children: [
          Column(
            children: [
              DrawerItemWidget(title: 'Document',),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true ,
                children: List.generate(_provider.document.length, (index) {
                  return DrawerDocumentWidget(title: _provider.document[index],);
                }),
              )
            ],
          ),
          DrawerItemWidget(title: 'Customer',),
          DrawerItemWidget(title: 'Item',),
          Divider(
            color: MyColors.divider,
            thickness: 1,
          ),
          DrawerItemWidget(title: 'Trash',),
          DrawerItemWidget(title: 'Summary',),
        ],
      ),
    );
  }
}
