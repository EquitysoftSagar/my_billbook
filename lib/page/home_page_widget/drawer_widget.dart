import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/add_document_dialog.dart';
import 'package:my_billbook/list_widget/document_name_list_widget.dart';
import 'package:my_billbook/page/drawer_widgets/drawer_items_widget.dart';
import 'package:my_billbook/style/colors.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: MyColors.drawer,
        width: 200,
        child: ListView(
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
            DrawerItemsWidget()
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
}
