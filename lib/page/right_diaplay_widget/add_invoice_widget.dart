import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_billbook/dialog/customer_dialog.dart';
import 'package:my_billbook/dialog/item_dialog.dart';
import 'package:my_billbook/dialog/add_tax_discount_dialog.dart';
import 'package:my_billbook/dialog/alert_dialog.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/item_view_widget/invoice_item_view_widget.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/model/document.dart';
import 'package:my_billbook/model/invoice_item_model.dart';
import 'package:my_billbook/model/tax_discount_shipping.dart';
import 'package:my_billbook/page/add_invoce_widget/invoice_customer_view_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/invoice_widget.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/invoice_text_field.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/methods.dart';
import 'package:provider/provider.dart';

class AddInvoiceWidget extends StatefulWidget {

  final String id;
  final Bills bills;

  AddInvoiceWidget({Key key, this.id, this.bills}) : super(key: key);

  @override
  _AddInvoiceWidgetState createState() => _AddInvoiceWidgetState();
}

class _AddInvoiceWidgetState extends State<AddInvoiceWidget> {
  final _invoiceController = TextEditingController();

  final _poController = TextEditingController();

  final _dateController = TextEditingController();

  final _dueOnDateController = TextEditingController();

  final _noteController = TextEditingController();
  HomePageProvider _provider;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    _dueOnDateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 8)));
  }
  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<HomePageProvider>(context);
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
                                onYesTap: onAlertYesTap
                              ));
                    },
                    child: Text(
                      '${widget.bills.name} ',
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
                    onPressed: () {
                      onSaveTap();
                    },
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
                        height: 320,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: InvoiceCustomerViewWidget()
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Form(
                                            key: _formKey,
                                            child: InvoiceTextField(
                                              labelText: 'Invoice #',
                                              controller: _invoiceController,
                                            ),
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
                                      onDateTap();
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
                                       onDueDateTap();
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _itemHeader(),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      color: MyColors.divider,
                      thickness: 2,
                      height: 1,
                    ),
                    _itemList(),
                    SizedBox(
                      height: 10,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        onTaxAndDiscountTap();
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
                                          onChanged: onRecurringChange,
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
                                          '${Constants.indianCurrencySymbol}${_getSubTotal()}',
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
                                          '${Constants.indianCurrencySymbol}${_getSubTotal()}',
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
                                          '${Constants.indianCurrencySymbol}${_getSubTotal()}',
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

  Widget _itemHeader(){
    return Padding(
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
  }

  Widget _itemList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return InvoiceItemViewWidget(
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
  }

  void onTaxAndDiscountTap() {
    showDialog(
        context: context,
        builder: (context) => AddTaxDiscountDialog());
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

  void onAddItemTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) =>
            ItemDialog(
              forEdit: false,
              fromInvoice: true,
              provider: _provider,
            ));
  }

  int _getSubTotal(){
    int _total = 0;
    for(InvoiceItemModel i in _provider.invoiceItem){
      _total = _total + int.parse(i.amount);
    }
    return _total;
  }

  void onAlertYesTap() {
    _provider.invoiceItem = [];
    _provider.invoiceCustomer = null;
    _provider.signature = false;
    _provider.clientSignature = false;
    _provider.isInvoiceWidget = false;

    _provider.rideSideWidget = InvoiceWidget(
      id: widget.id,
      bills: widget.bills,
    );
  }

  void onRecurringChange(String value) {
    _provider.recurring = value;
  }

  void onDateTap()async{
    DateTime _initialDate = DateFormat('dd-MM-yyyy').parse(_dateController.text);
    _dateController.text = await getDateFromDatePicker(context,_initialDate);
    _initialDate = DateFormat('dd-MM-yyyy').parse(_dateController.text);
    DateTime _dueDate = _initialDate.add(Duration(days: 6));
    _dueOnDateController.text = DateFormat('dd-MM-yyyy').format(_dueDate);
  }

  void onDueDateTap()async {
    DateTime _initialDate = DateFormat('dd-MM-yyyy').parse(_dueOnDateController.text);
    _dueOnDateController.text = await getDateFromDatePicker(context,_initialDate);
  }

  void onSaveTap() {
    if(_provider.invoiceCustomer == null){
      toastError('Please add customer');
    }else if(_formKey.currentState.validate()){
      addDocument();
    }
  }
  void addDocument()async{
    showProgress(context);

    var d = Documents();
    d.invoice = _invoiceController.text;
    d.po = _poController.text;
    d.date = Timestamp.fromDate(DateFormat('dd-MM-yyyy').parse(_dateController.text));
    d.dueDate = _provider.removeDueDate ? '' : Timestamp.fromDate(DateFormat('dd-MM-yyyy').parse(_dueOnDateController.text));
    d.customer = _provider.invoiceCustomer;
    d.item = _provider.invoiceItem;
    d.subTotal = _getSubTotal().toString();
    d.total = d.subTotal;
    d.amountDue = d.total;
    d.mySignature = _provider.signature;
    d.clientSignature = _provider.clientSignature;
    d.recurring = _provider.recurring;
    d.note = _noteController.text;
    d.photo = [];
    d.taxDiscountShipping = TaxDiscountShipping();
    d.createdAt = Timestamp.fromDate(DateTime.now());
    d.updatedAt = Timestamp.fromDate(DateTime.now());
    d.status = 1;
    d.documentStatus = 'Pending';

    var _result = await FirebaseService.addDocument(widget.id, d);
    Navigator.pop(context);

    if(_result){
      _provider.invoiceItem = [];
      _provider.invoiceCustomer = null;
      _provider.signature = false;
      _provider.clientSignature = false;

      _provider.rideSideWidget = InvoiceWidget(
        id: widget.id,
        bills: widget.bills,
      );
    }
  }
}
