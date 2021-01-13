import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/edit_document_name_dialog.dart';
import 'package:my_billbook/page/right_diaplay_widget/invoice_widget.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/style/images.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DrawerDocumentWidget extends StatelessWidget {
  HomePageProvider _provider;
  final String title;

   DrawerDocumentWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<HomePageProvider>(context);
    return ListTile(
        contentPadding: EdgeInsets.only(left: 30, right: 10),
        onTap: onDocumentTap,
        title: Text(
          title,
          style: TextStyle(
              color: MyColors.drawerTxt,
              fontWeight: FontWeight.w600,
              fontSize: 13.0),
        ),
        trailing: IconButton(
          icon: Image.asset(
            MyImages.threeDot,
            color: MyColors.drawerTxt,
            height: 10,
            width: 10,
          ),
          onPressed: (){
            // onMenuTap(context);
          },
        ));
  }

  void onMenuTap(BuildContext context) {
    showDialog(context: context,builder: (context) => EditDocumentNameDialog(title: title,provider: _provider,));
  }

  void onDocumentTap() {
    _provider.rideSideWidget = InvoiceWidget();
  }
}
