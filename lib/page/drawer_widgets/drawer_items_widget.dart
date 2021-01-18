import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/alert_dialog.dart';
import 'package:my_billbook/page/right_diaplay_widget/customer_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/item_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/summary_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/trash_widget.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:provider/provider.dart';

class DrawerItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(left: 15, right: 10),
          title: Text(
            'Customer',
            style: TextStyle(
                color: MyColors.drawerTxt,
                fontWeight: FontWeight.w700,
                fontSize: 13.0),
          ),
          onTap: (){
            onListTap('Customer', context);
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 15, right: 10),
          title: Text(
            'Item',
            style: TextStyle(
                color: MyColors.drawerTxt,
                fontWeight: FontWeight.w700,
                fontSize: 13.0),
          ),
          onTap: (){
            onListTap('Item', context);
          },
        ),
        Divider(
          color: MyColors.divider,
          thickness: 1,
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 15, right: 10),
          title: Text(
            'Trash',
            style: TextStyle(
                color: MyColors.drawerTxt,
                fontWeight: FontWeight.w700,
                fontSize: 13.0),
          ),
          onTap: (){
            onListTap('Trash', context);
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 15, right: 10),
          title: Text(
            'Summary',
            style: TextStyle(
                color: MyColors.drawerTxt,
                fontWeight: FontWeight.w700,
                fontSize: 13.0),
          ),
          onTap: (){
            onListTap('Summary', context);
          },
        ),
      ],
    );
  }
  void onListTap(String title,BuildContext _context) {
    final _provider = Provider.of<HomePageProvider>(_context,listen:false);
    switch (title) {
      case 'Customer':
        if (_provider.isInvoiceWidget) {
          showAlertDialog(CustomerWidget(),_context);
        } else {
          _provider.rideSideWidget = CustomerWidget();
        }

        break;
      case 'Item':
        if (_provider.isInvoiceWidget) {
          showAlertDialog(ItemWidget(),_context);
        } else {
          _provider.rideSideWidget = ItemWidget();
        }
        break;
      case 'Trash':
        if (_provider.isInvoiceWidget) {
          showAlertDialog(TrashWidget(),_context);
        } else {
          _provider.rideSideWidget = TrashWidget();
        }
        break;
      case 'Summary':
        if (_provider.isInvoiceWidget) {
          showAlertDialog(SummaryWidget(),_context);
        } else {
          _provider.rideSideWidget = SummaryWidget();
        }
        break;
    }
  }

  void showAlertDialog(Widget widget,BuildContext _context) {
    showDialog(
        context: _context,
        builder: (context) => MyAlertDialog(
          title: 'Are you sure you want to leave without saving?',
          onYesTap: () {
            final _homeProvider = Provider.of<HomePageProvider>(_context,listen:false);
            _homeProvider.isInvoiceWidget = false;
            _homeProvider.rideSideWidget = widget;
          },
        ));
  }
}
