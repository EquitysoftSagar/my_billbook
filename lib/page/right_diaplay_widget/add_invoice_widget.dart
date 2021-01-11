import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_billbook/dialog/add_invoice_customer_dialog.dart';
import 'package:my_billbook/dialog/add_tax_discount_dialog.dart';
import 'package:my_billbook/dialog/alert_dialog.dart';
import 'package:my_billbook/list_widget/item_list_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/invoice_widget.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/invoice_text_field.dart';
import 'package:my_billbook/util/methods.dart';
import 'package:provider/provider.dart';

class AddInvoiceWidget extends StatelessWidget {
  final _invoiceController = TextEditingController();
  final _poController = TextEditingController();
  final _dateController = TextEditingController();
  final _dueOnDateController = TextEditingController();
  final _noteController = TextEditingController();
  final HomePageProvider provider;

  AddInvoiceWidget({Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _dueOnDateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 8)));
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
                      builder: (context) => MyAlertDialog(
                            title:
                                'Are you sure you want to leave without saving?',
                            onYesTap: () {
                              provider.rideSideWidget = InvoiceWidget();
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
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
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
                                    await getDateFromDatePicker(context);
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            InvoiceTextField(
                              labelText: 'Due on',
                              controller: _dueOnDateController,
                              onSuffixTap: () async {
                                _dueOnDateController.text =
                                    await getDateFromDatePicker(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          onTap: () {
                            onAddCustomerTap(context);
                          },
                          child: Container(
                            height: 250,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
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
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
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
                        flex: 1,
                        child: Text('Quantity',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('Price',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('Amount',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0)),
                      ),
                      Expanded(
                        flex: 1,
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
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: MyColors.divider,
                  thickness: 2,
                  height: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<HomePageProvider>(
                  builder: (BuildContext context, _provider, Widget child) {
                    return  ListView.builder(itemBuilder: (BuildContext context, int index) {
                      return ItemListWidget(
                        index: index,
                        item: _provider.invoiceItem[index],
                        isInvoiceList: true,
                      );
                    },
                    shrinkWrap: true,
                      itemCount: _provider.invoiceItem.length,
                    physics: NeverScrollableScrollPhysics(),);
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    onAddItemTap(context);
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
                            child: Consumer<HomePageProvider>(
                              builder: (context, _provider, _) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        onTaxAndDiscountTap(context, _provider);
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
                                                fontWeight: FontWeight.w500,
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
                                          contentPadding: EdgeInsets.zero,
                                          value: _provider.signature,
                                          onChanged: (value) {
                                            _provider.signature = value;
                                          },
                                          title: Text(
                                            'My Signature',
                                            style: TextStyle(
                                                color: MyColors.text,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          ),
                                        )),
                                    SizedBox(
                                        width: 200,
                                        child: SwitchListTile(
                                          contentPadding: EdgeInsets.zero,
                                          value: _provider.clientSignature,
                                          onChanged: (value) {
                                            _provider.clientSignature = value;
                                          },
                                          title: Text(
                                            'Client\'s Signature',
                                            style: TextStyle(
                                                color: MyColors.text,
                                                fontWeight: FontWeight.w500,
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
                                                  color: MyColors.accent,
                                                  fontSize: 13),
                                              hintStyle: TextStyle(height: 2),
                                              hintText: '',
                                              focusColor: MyColors.accent),
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
                                );
                              },
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Discount (10%)',
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'gst included (9%)',
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'shipping',
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
                                      '₹0.00',
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
                            EdgeInsets.symmetric(horizontal: 35, vertical: 18),
                        child: Text(
                          '+ Add Photo',
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
    ));
  }

  void onTaxAndDiscountTap(BuildContext context, HomePageProvider _provider) {
    showDialog(
        context: context,
        builder: (context) => AddTaxDiscountDialog());
  }

  void onAddCustomerTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AddInvoiceCustomerDialog(
              headerTitle: 'Customer List',
            ));
  }

  void onAddItemTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AddInvoiceCustomerDialog(
              headerTitle: 'Items List',
            ));
  }
}
