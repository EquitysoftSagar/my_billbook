import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/customer_dialog.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:provider/provider.dart';

class InvoiceCustomerViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<HomePageProvider>(context);
    return _provider.invoiceCustomer != null ? _customerView(context,_provider) : InkWell(
      onTap: () {
        onAddCustomerTap(context);
      },
      child: Container(
        height: 280,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(
              0.08),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment
              .center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: MyColors.accent,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Add Customer',
              style: TextStyle(
                  color: MyColors.accent,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
  Widget _customerView(BuildContext context,HomePageProvider provider){
    var c = provider.invoiceCustomer;
    var a = c.address;
    var sa = c.shippingAddress;
    var _fontSize = 13.0;
    var _fontHeight = 1.3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('BILL TO',style: TextStyle(color: MyColors.text,fontWeight: FontWeight.bold ,fontSize: 18),),SizedBox(height: 10,),
        Text(c.name,style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.bold ,fontSize: 16),),
        Visibility(
            visible: a.address1.isNotEmpty ? true : false,
            child: Text(a.address1,style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),)),
        Visibility(
            visible: a.address2.isNotEmpty ? true : false,
            child: Text(a.address2,style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),)),
        Visibility(
          visible: a.city.isNotEmpty || a.state.isNotEmpty || a.zip.isNotEmpty ? true : false,
          child: Row(
            children: [
              Text('${a.city} ',style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),),
              Text('${a.state} ',style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),),
              Text('${a.zip} ',style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),),
            ],
          ),
        ),
        Visibility(
            visible: a.country.isNotEmpty ? true : false,
            child: Text(a.country,style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),)),
        Visibility(
            visible: c.email.isNotEmpty ? true : false,
            child: Text(c.email,style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),)),
        Visibility(
            visible: c.phoneNumber.isNotEmpty ? true : false,
            child: Text('${c.phoneNumber}',style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),)),
        SizedBox(height: 10,),
        Visibility(
            visible: sa.address1.isNotEmpty || sa.address2.isNotEmpty || sa.address1.isNotEmpty || sa.city.isNotEmpty || sa.state.isNotEmpty || sa.zip.isNotEmpty || sa.country.isNotEmpty ? true : false,
            child: Text('SHIP TO',style: TextStyle(color: MyColors.text,fontWeight: FontWeight.bold ,fontSize: 18),)),
        Visibility(
            visible: sa.address1.isNotEmpty ? true : false,
            child: Text(sa.address1,style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),)),
        Visibility(
            visible: sa.address2.isNotEmpty ? true : false,
            child: Text(sa.address2,style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),)),
        Visibility(
          visible: sa.city.isNotEmpty || sa.state.isNotEmpty || sa.zip.isNotEmpty ? true : false,
          child: Row(
            children: [
              Text('${sa.city} ',style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),),
              Text('${sa.state} ',style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),),
              Text('${sa.zip} ',style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),),
            ],
          ),
        ),
        Visibility(
            visible: sa.country.isNotEmpty ? true : false,
            child: Text(sa.country,style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),)),
        Visibility(
            visible: c.additionalInformation.isNotEmpty ? true : false,
            child: Text('${c.additionalInformation} ',style: TextStyle(color: MyColors.text,height:_fontHeight,fontWeight: FontWeight.w400 ,fontSize: _fontSize),)),
        SizedBox(height: 15,),
        RaisedButton(
          onPressed: () {
            _onCustomerEditTap(context);
          },
          child: Text(
            'Edit',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Spacer()
      ],
    );
  }

  void onAddCustomerTap(BuildContext context) {
    final _provider = Provider.of<HomePageProvider>(context,listen: false);
    showDialog(
        context: context,
        builder: (context) =>
            CustomerDialog(
              fromInvoice: true,
              forEdit: false,
              provider: _provider,
            ));
  }
  void _onCustomerEditTap(BuildContext context) {
    final _provider = Provider.of<HomePageProvider>(context,listen: false);
    showDialog(context: context,builder: (context) => CustomerDialog(
      fromInvoice: true,
      forEdit: true,
      customer: _provider.invoiceCustomer,
      provider: _provider,
    ));
  }
}
