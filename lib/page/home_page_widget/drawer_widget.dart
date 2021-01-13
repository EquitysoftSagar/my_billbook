import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/alert_dialog.dart';
import 'package:my_billbook/list_widget/drawer_document_widget.dart';
import 'package:my_billbook/list_widget/drawer_item_list.dart';
import 'package:my_billbook/page/right_diaplay_widget/add_invoice_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/customer_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/item_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/summary_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/trash_widget.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:provider/provider.dart';
class DrawerWidget extends StatelessWidget {

  HomePageProvider _provider;
  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
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
                  return DrawerDocumentWidget(
                    title: _provider.document[index],
                  );
                }),
              )
            ],
          ),
          DrawerItemWidget(title: 'Customer',onDrawerItemClick: onListTap,),
          DrawerItemWidget(title: 'Item',onDrawerItemClick: onListTap,),
          Divider(
            color: MyColors.divider,
            thickness: 1,
          ),
          DrawerItemWidget(title: 'Trash',onDrawerItemClick: onListTap,),
          DrawerItemWidget(title: 'Summary',onDrawerItemClick: onListTap,),
        ],
      ),
    );
  }
  void onListTap(String title) {
    switch(title){
      case 'Customer':
        if(_provider.isInvoiceWidget){
          showAlertDialog(CustomerWidget());
        }else{
          _provider.rideSideWidget = CustomerWidget();
        }

        break;
      case 'Item':
        if(_provider.isInvoiceWidget){
          showAlertDialog(ItemWidget());
        }else{
          _provider.rideSideWidget = ItemWidget();
        }
        break;
      case 'Trash':
        if(_provider.isInvoiceWidget){
          showAlertDialog(TrashWidget());
        }else{
          _provider.rideSideWidget = TrashWidget();
        }
        break;
      case 'Summary':
        if(_provider.isInvoiceWidget){
          showAlertDialog(SummaryWidget());
        }else{
          _provider.rideSideWidget = SummaryWidget();
        }
        break;
    }
  }
  void showAlertDialog(Widget widget){
    showDialog(
        context: _context,
        builder: (context) =>
            MyAlertDialog(
              title:
              'Are you sure you want to leave without saving?',
              onYesTap: () {
                _provider.invoiceItem = [];
                _provider.invoiceCustomer = null;
                _provider.isInvoiceWidget = false;
                _provider.rideSideWidget = widget;
              },
            ));
  }
}
