import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/add_documnet_name_dialog.dart';
import 'package:my_billbook/dialog/alert_dialog.dart';
import 'package:my_billbook/page/right_diaplay_widget/add_invoice_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/customer_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/item_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/summary_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/trash_widget.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:provider/provider.dart';
// ignore: must_be_immutable
class DrawerItemWidget extends StatelessWidget {
  final String title;
  final Function onDrawerItemClick;
  DrawerItemWidget({Key key, this.title,this.onDrawerItemClick}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<HomePageProvider>(context);
    return  ListTile(
      contentPadding: EdgeInsets.only(left: 15, right: 10),
      title: Text(
        title,
        style: TextStyle(
            color: MyColors.drawerTxt,
            fontWeight: FontWeight.w700,
            fontSize: 13.0),
      ),
      onTap: (){
        onDrawerItemClick(title);
      },
      trailing: title == 'Document' ? IconButton(
        onPressed: (){
          // showDialog(context: context,builder: (context) => AddDocumentNameDialog(provider: _provider,));
        },
        icon: Icon(
          Icons.add,
          color: MyColors.drawerTxt,
          size: 20  ,
        ),
      ) : null,
    );
  }

}
