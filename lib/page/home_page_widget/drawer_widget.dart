import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/add_document_dialog.dart';
import 'package:my_billbook/dialog/alert_dialog.dart';
import 'package:my_billbook/list_widget/document_name_list_widget.dart';
import 'package:my_billbook/page/drawer_widgets/drawer_items_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/setting_widget.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: MyColors.drawer,
        width: 200,
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 15, right: 10),
              title: Text(
                'Document',
                style: TextStyle(
                    color: MyColors.drawerTxt,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0),
              ),
              trailing: IconButton(
                onPressed: () {
                  onAddTap(context);
                },
                icon: Icon(
                  Icons.add,
                  color: MyColors.drawerTxt,
                  size: 20,
                ),
              ),
            ),  //document
            DocumentNameListWidget(),
            DrawerItemsWidget(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: Icon(Icons.message), onPressed: (){onMessageTap(context);},color: MyColors.invoiceTxt,),
                IconButton(icon: Icon(Icons.settings), onPressed: (){onSettingTap(context);},color: MyColors.invoiceTxt,),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onAddTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AddDocumentDialog());
  }

  void onMessageTap(BuildContext context) {
  }

  void onSettingTap(BuildContext context) {
    final _provider = Provider.of<HomePageProvider>(context,listen: false);
    if(_provider.isInvoiceWidget){
      showDialog(
          context: context,
          builder: (context) =>
              MyAlertDialog(
                  title:
                  'Are you sure you want to leave without saving?',
                  onYesTap: (){
                    _provider.isInvoiceWidget = false;
                    _provider.rideSideWidget = SettingWidget();
                  }
              ));
    }else{
      _provider.rideSideWidget = SettingWidget();
    }
  }
}
