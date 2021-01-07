import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/add_documnet_name_dialog.dart';
import 'package:my_billbook/page/right_diaplay_widget/customer_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/item_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/summary_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/trash_widget.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:provider/provider.dart';
// ignore: must_be_immutable
class DrawerItemWidget extends StatelessWidget {
  HomePageProvider _provider;
  final String title;
  DrawerItemWidget({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<HomePageProvider>(context);
    return  ListTile(
      contentPadding: EdgeInsets.only(left: 15, right: 10),
      title: Text(
        title,
        style: TextStyle(
            color: MyColors.drawerTxt,
            fontWeight: FontWeight.w700,
            fontSize: 13.0),
      ),
      onTap: onListTap,
      trailing: title == 'Document' ? IconButton(
        onPressed: (){
          showDialog(context: context,builder: (context) => AddDocumentNameDialog(provider: _provider,));
        },
        icon: Icon(
          Icons.add,
          color: MyColors.drawerTxt,
          size: 20  ,
        ),
      ) : null,
    );
  }

  void onListTap() {
    switch(title){
      case 'Customer':
        _provider.rideSideWidget = CustomerWidget();
        break;
      case 'Item':
        _provider.rideSideWidget = ItemWidget();
        break;
      case 'Trash':
        _provider.rideSideWidget = TrashWidget();
        break;
      case 'Summary':
        _provider.rideSideWidget = SummaryWidget();
        break;
    }
  }
}
