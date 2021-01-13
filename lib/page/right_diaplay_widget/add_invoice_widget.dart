import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_billbook/dialog/customer_dialog.dart';
import 'package:my_billbook/dialog/item_dialog.dart';
import 'package:my_billbook/dialog/import_invoice_customer_item_dialog.dart';
import 'package:my_billbook/dialog/add_tax_discount_dialog.dart';
import 'package:my_billbook/dialog/alert_dialog.dart';
import 'package:my_billbook/list_widget/invoice_item_list_widget.dart';
import 'package:my_billbook/list_widget/item_list_widget.dart';
import 'package:my_billbook/model/invoice_item_model.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/page/right_diaplay_widget/invoice_widget.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/invoice_text_field.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/methods.dart';
import 'package:provider/provider.dart';

class AddInvoiceWidget extends StatelessWidget {
  final _invoiceController = TextEditingController();
  final _poController = TextEditingController();
  final _dateController = TextEditingController();
  final _dueOnDateController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<HomePageProvider>(context);
    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _dueOnDateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 8)));
    return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              MyAlertDialog(
                                title:
                                'Are you sure you want to leave without saving?',
                                onYesTap: () {
                                  _provider.invoiceItem = [];
                                  _provider.invoiceCustomer = null;
                                  _provider.rideSideWidget = InvoiceWidget();
                                },
                              ));
                    },
                    child: Text(
                      'Invoice ',
                      style: TextStyle(
                          color: MyColors.accent,
                          fontWeight: FontWeight.w700,
                          fontSize: 25.0),
                    ),
                  ),
                  Text(
                    '> New',
                    style: TextStyle(
                        color: MyColors.invoiceTxt,
                        fontWeight: FontWeight.w700,
                        fontSize: 25.0),
                  ),
                  Spacer(),
                  RaisedButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  )
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 30, bottom: 30, left: 5, right: 5),
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: MyColors.boxShadow, blurRadius: 6)
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: SizedBox(
                        height: 313,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: _provider.invoiceCustomer != null ? _customerView(context,_provider) : InkWell(
                                onTap: () {
                                  onAddCustomerTap(context,_provider);
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
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              flex: 2,
                              child: Consumer<HomePageProvider>(
                                builder: (BuildContext context, _provider,
                                    Widget child) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: InvoiceTextField(
                                                labelText: 'Invoice #',
                                                controller: _invoiceController,
                                              )),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                              child: InvoiceTextField(
                                                labelText: 'Po #',
                                                controller: _poController,
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      InvoiceTextField(
                                        labelText: 'Date',
                                        controller: _dateController,
                                        onSuffixTap: () async {
                                          _dateController.text =
                                          await getDateFromDatePicker(
                                              context);
                                        },
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Visibility(
                                        visible: !_provider.removeDueDate,
                                        child: InvoiceTextField(
                                          labelText: 'Due on',
                                          controller: _dueOnDateController,
                                          onSuffixTap: () async {
                                            _dueOnDateController.text =
                                            await getDateFromDatePicker(
                                                context);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: SwitchListTile(
                                          value: _provider.removeDueDate,
                                          onChanged: (value) {
                                            _provider.removeDueDate = value;
                                          },
                                          title: Text('Remove due date'),
                                          contentPadding: EdgeInsets.zero,),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _itemHeader(_provider),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      color: MyColors.divider,
                      thickness: 2,
                      height: 1,
                    ),
                    _itemList(_provider),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        onAddItemTap(context,_provider);
                      },
                      child: Text(
                        '+ Add Item',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: MyColors.divider,
                      thickness: 2,
                      height: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        onTaxAndDiscountTap(context);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.settings,
                                            color: MyColors.accent,
                                            size: 15,
                                          ),
                                          Text(
                                            ' Tax ,Discount & Shipping',
                                            style: TextStyle(
                                                color: MyColors.accent,
                                                fontWeight: FontWeight
                                                    .w500,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                        width: 200,
                                        child: SwitchListTile(
                                          contentPadding: EdgeInsets
                                              .zero,
                                          value: _provider.signature,
                                          onChanged: (value) {
                                            _provider.signature = value;
                                          },
                                          title: Text(
                                            'My Signature',
                                            style: TextStyle(
                                                color: MyColors.text,
                                                fontWeight: FontWeight
                                                    .w500,
                                                fontSize: 13),
                                          ),
                                        )),
                                    SizedBox(
                                        width: 200,
                                        child: SwitchListTile(
                                          contentPadding: EdgeInsets
                                              .zero,
                                          value: _provider
                                              .clientSignature,
                                          onChanged: (value) {
                                            _provider.clientSignature =
                                                value;
                                          },
                                          title: Text(
                                            'Client\'s Signature',
                                            style: TextStyle(
                                                color: MyColors.text,
                                                fontWeight: FontWeight
                                                    .w500,
                                                fontSize: 13),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: DropdownButtonFormField(
                                          value: 'None',
                                          onChanged: (String value) {
                                            _provider.recurring = value;
                                          },
                                          decoration: InputDecoration(
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  vertical: 5,
                                                  horizontal: 5),
                                              labelText: 'Recurring',
                                              fillColor: Colors.black
                                                  .withOpacity(0.05),
                                              filled: true,
                                              labelStyle: TextStyle(
                                                  color: MyColors
                                                      .accent,
                                                  fontSize: 13),
                                              hintStyle: TextStyle(
                                                  height: 2),
                                              hintText: '',
                                              focusColor: MyColors
                                                  .accent),
                                          items: [
                                            'None',
                                            'Every day',
                                            'Every week',
                                            'Every 2 weeks',
                                            'Every 4 weeks'
                                          ].map((e) {
                                            return DropdownMenuItem(
                                              child: Text(e),
                                              value: e,
                                            );
                                          }).toList()),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Subtotal',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: MyColors.text,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          '${Constants.indianCurrencySymbol}${_getSubTotal(_provider)}',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: MyColors.text,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //   MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       'Discount (10%)',
                                    //       textAlign: TextAlign.right,
                                    //       style: TextStyle(
                                    //           color: MyColors.text,
                                    //           fontWeight: FontWeight.w500,
                                    //           fontSize: 13),
                                    //     ),
                                    //     Text(
                                    //       '₹0.00',
                                    //       textAlign: TextAlign.right,
                                    //       style: TextStyle(
                                    //           color: MyColors.text,
                                    //           fontWeight: FontWeight.w500,
                                    //           fontSize: 13),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tax (0%)',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: MyColors.text,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          '₹0.00',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: MyColors.text,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //   MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       'shipping',
                                    //       textAlign: TextAlign.right,
                                    //       style: TextStyle(
                                    //           color: MyColors.text,
                                    //           fontWeight: FontWeight.w500,
                                    //           fontSize: 13),
                                    //     ),
                                    //     Text(
                                    //       '₹0.00',
                                    //       textAlign: TextAlign.right,
                                    //       style: TextStyle(
                                    //           color: MyColors.text,
                                    //           fontWeight: FontWeight.w500,
                                    //           fontSize: 13),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: MyColors.text,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          '${Constants.indianCurrencySymbol}${_getSubTotal(_provider)}',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: MyColors.text,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Amount Due',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: MyColors.text,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          '${Constants.indianCurrencySymbol}${_getSubTotal(_provider)}',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Divider(
                            color: MyColors.divider,
                            thickness: 2,
                            height: 1,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InvoiceTextField(
                            labelText: 'Note',
                            controller: _noteController,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RaisedButton(
                            onPressed: () {},
                            padding:
                            EdgeInsets.symmetric(
                                horizontal: 35, vertical: 18),
                            child: Text(
                              '+ Add Photo',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),);
  }

  Widget _itemHeader(HomePageProvider provider) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Expanded(
          flex: 5,
          child: Text(
            'Item',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: MyColors.invoiceTxt,
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
          ),
        ),
        Expanded(
          child: Text('Quantity',
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0)),
        ),
        Expanded(
          child: Text('Price',
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0)),
        ),
        Expanded(
          child: Text('Discount',
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0)),
        ),
        Expanded(
          child: Text('Amount',
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0)),
        ),
        Expanded(
          child: Text(
            'Actions',
            textAlign: TextAlign.right,
            style: TextStyle(
                color: MyColors.invoiceTxt,
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
          ),
        ),
      ],
    ),
  );

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
            _onCustomerEditTap(context,provider);
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

  Widget _itemList(HomePageProvider _provider) =>  ListView.builder(
    itemBuilder: (BuildContext context, int index) {
      return InvoiceItemListWidget(
        index: index,
        item: _provider.invoiceItem[index],
        removeFunction: (InvoiceItemModel item){
          _provider.removeInvoiceItem = item;
        },
        updateFunction: (InvoiceItemModel item,int index){
          showDialog(
              context: context,
              builder: (context) =>
                  ItemDialog(
                    forEdit: true,
                    fromInvoice: true,
                    provider: _provider,
                    invoiceItemModel: item,
                    index: index,
                  ));
        },
      );
    },
    shrinkWrap: true,
    itemCount: _provider.invoiceItem.length,
    physics: NeverScrollableScrollPhysics(),);


  void onTaxAndDiscountTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AddTaxDiscountDialog());
  }

  void onAddCustomerTap(BuildContext context,HomePageProvider provider) {
    showDialog(
        context: context,
        builder: (context) =>
            CustomerDialog(
              fromInvoice: true,
              forEdit: false,
              provider: provider,
            ));
  }

  void onAddItemTap(BuildContext context,HomePageProvider provider) {
    showDialog(
        context: context,
        builder: (context) =>
            ItemDialog(
              forEdit: false,
              fromInvoice: true,
              provider: provider,
            ));
  }

  void _onCustomerEditTap(BuildContext context,HomePageProvider provider) {
    showDialog(context: context,builder: (context) => CustomerDialog(
      fromInvoice: true,
      forEdit: true,
      customer: provider.invoiceCustomer,
      provider: provider,
    ));
  }
  int _getSubTotal(HomePageProvider provider){
    int _total = 0;
    for(InvoiceItemModel i in provider.invoiceItem){
      _total = _total + int.parse(i.amount);
    }
    return _total;
  }
}
