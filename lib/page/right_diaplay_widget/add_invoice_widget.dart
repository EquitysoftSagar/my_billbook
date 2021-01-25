import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:my_billbook/dialog/item_dialog.dart';
import 'package:my_billbook/dialog/add_tax_discount_dialog.dart';
import 'package:my_billbook/dialog/alert_dialog.dart';
import 'package:my_billbook/dialog/preview_dialog.dart';
import 'package:my_billbook/dialog/send_email_dialog.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/item_view_widget/invoice_item_view_widget.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/model/document.dart';
import 'package:my_billbook/model/invoice_item_model.dart';
import 'package:my_billbook/model/photo.dart';
import 'package:my_billbook/model/second_tax.dart';
import 'package:my_billbook/model/tax_discount_shipping.dart';
import 'package:my_billbook/page/add_invoce_widget/invoice_customer_view_widget.dart';
import 'package:my_billbook/page/right_diaplay_widget/invoice_widget.dart';
import 'package:my_billbook/pdf/pdf_creator.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/invoice_text_field.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/methods.dart';
import 'package:provider/provider.dart';


class AddInvoiceWidget extends StatefulWidget {

  final String billId;
  final String docId;
  final Bills bills;
  final bool forEdit;
  final Documents documents;


  AddInvoiceWidget({Key key, this.billId, this.bills, this.forEdit, this.documents,this.docId}) : super(key: key);

  @override
  _AddInvoiceWidgetState createState() => _AddInvoiceWidgetState();
}

class _AddInvoiceWidgetState extends State<AddInvoiceWidget> {
  final _invoiceController = TextEditingController();

  final _poController = TextEditingController();

  final _dateController = TextEditingController();

  final _dueOnDateController = TextEditingController();

  final _noteController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();


  Customer _customer;
  List<InvoiceItemModel> _invoiceItem = [];
  TaxDiscountShipping taxDiscountShipping = TaxDiscountShipping();
  List<Photo> _photoList = [];
  bool _removeDueDate = false;
  bool _mySignature = false;
  bool _clientSignature = false;
  String _recurring = 'None';

  @override
  void initState() {
    super.initState();
    _invoiceController.text = widget.bills.settingPrefix + widget.bills.settingNext.toString();
    if(widget.forEdit){
      var d = widget.documents;
      _invoiceController.text = d.invoice;
      _poController.text = d.po;
      _dateController.text = DateFormat('dd-MM-yyyy').format(d.date.toDate());
      _dueOnDateController.text = d.dueDate != null ? DateFormat('dd-MM-yyyy').format(d.dueDate.toDate()) : DateFormat('dd-MM-yyyy').format(d.date.toDate().add(Duration(days: int.parse(userModel.userSettings.dueInDays))));
      _removeDueDate = d.dueDate == null ? true : false;
      _noteController.text = d.note;
      taxDiscountShipping = d.taxDiscountShipping;
      _customer = d.customer;
      _invoiceItem = d.item;
      _mySignature = d.mySignature;
      _clientSignature = d.clientSignature;
      _recurring = d.recurring;
    }else{
      _dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
      _dueOnDateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: userModel.userSettings.dueInDays == 'Same Day' ? 0 :  int.parse(userModel.userSettings.dueInDays))));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    !widget.forEdit ? '> New' : '> #${widget.documents.invoice}',
                    style: TextStyle(
                        color: MyColors.invoiceTxt,
                        fontWeight: FontWeight.w700,
                        fontSize: 25.0),
                  ),
                  Spacer(),
                  Tooltip(
                    message: 'Preview',
                    child: FloatingActionButton(onPressed: (){
                      onPreviewTap(context);
                    }, elevation: 0,
                      child: Icon(Icons.preview,color: Colors.white,),),
                  ),
                  SizedBox(width: 10,),
                  Tooltip(
                    message: 'Save',
                    child: FloatingActionButton(onPressed: (){
                      onSaveTap(context);
                    }, elevation: 0,
                    child: Icon(Icons.save,color: Colors.white,),),
                  )
                  /*RaisedButton(
                    onPressed: () {
                      onSaveTap(context);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  )*/
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
                                child: InvoiceCustomerViewWidget(customer: _customer,onSetCustomer:onSetCustomer,)
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
                                    onSuffixTap: () {
                                      onDateTap(context);
                                    },
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Visibility(
                                    visible: !_removeDueDate,
                                    child: InvoiceTextField(
                                      labelText: 'Due on',
                                      controller: _dueOnDateController,
                                      onSuffixTap: () {
                                        onDueDateTap(context);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: SwitchListTile(
                                      value: _removeDueDate,
                                      onChanged: (value) {
                                        setState(() {
                                          _removeDueDate = value;
                                        });
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
                      onPressed:onAddItemTap,
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
                                          value: _mySignature,
                                          onChanged: (value) {
                                            setState(() {
                                              _mySignature = value;
                                            });
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
                                          value: _clientSignature,
                                          onChanged: (value) {
                                            setState(() {
                                              _clientSignature = value;
                                            });
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
                                          value: _recurring,
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
                                          '${Constants.indianCurrencySymbol}${_getSubTotal().toStringAsFixed(2)}',
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
                                    if(taxDiscountShipping.discount != 0)Padding(
                                      padding: const EdgeInsets.only(bottom: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Discount',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: MyColors.text,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          ),
                                          Text(
                                            '₹${taxDiscountShipping.discount.toStringAsFixed(2)}',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: MyColors.text,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if(taxDiscountShipping.shipping != 0)Padding(
                                      padding: const EdgeInsets.only(bottom: 15),
                                      child: Row(
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
                                            '₹${taxDiscountShipping.shipping.toStringAsFixed(2)}',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: MyColors.text,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                   Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${taxDiscountShipping.taxLabel} (${taxDiscountShipping.tax}%)',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: MyColors.text,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          '₹${taxDiscountShipping.tax.toStringAsFixed(2)}',
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
                                          '${Constants.indianCurrencySymbol}${_getSubTotal().toStringAsFixed(2)}',
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
                                          'Grand Total',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: MyColors.text,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          '${Constants.indianCurrencySymbol}${_getGrandTotal().toStringAsFixed(2)}',
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
          item: _invoiceItem[index],
          removeFunction: _removeItem,
          updateFunction:_updateItem,
        );
      },
      shrinkWrap: true,
      itemCount: _invoiceItem.length,
      physics: NeverScrollableScrollPhysics(),);
  }

  void onTaxAndDiscountTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AddTaxDiscountDialog(taxDiscountShipping: taxDiscountShipping,)).then((value){
          if(value != null){
            setState(() {});
          }
    });
  }
  void onAddItemTap() {
    showDialog(
        context: context,
        builder: (context) =>
            ItemDialog(
              forEdit: false,
              fromInvoice: true,
            )).then((value){
              if(value != null){
                InvoiceItemModel itemModel = value;

               setState(() {
                 _invoiceItem.add(itemModel);
               });
              }
    });
  }

  int _getSubTotal(){
    int _total = 0;
    for(InvoiceItemModel i in _invoiceItem){
      _total = _total + int.parse(i.amount);
    }
    return _total;
  }

  int _getGrandTotal(){
    int _total = 0;
    // for(InvoiceItemModel i in _invoiceItem){
    //   _total = _total + int.parse(i.amount);
    // }
    return _total;
  }

  void onAlertYesTap() {
    final _homeProvider = Provider.of<HomePageProvider>(context,listen: false);
    _homeProvider.isInvoiceWidget = false;
    _homeProvider.rideSideWidget = InvoiceWidget(
      id: widget.billId,
      bills: widget.bills,
    );
  }

  void onRecurringChange(String value) {
    setState(() {
      _recurring = value;
    });
  }

  void onDateTap(BuildContext context)async{
    DateTime _initialDate = DateFormat('dd-MM-yyyy').parse(_dateController.text);
    _dateController.text = await getDateFromDatePicker(context,_initialDate);
    _initialDate = DateFormat('dd-MM-yyyy').parse(_dateController.text);
    DateTime _dueDate = _initialDate.add(Duration(days: userModel.userSettings.dueInDays == 'Same Day' ? 0 : int.parse(userModel.userSettings.dueInDays)));
    _dueOnDateController.text = DateFormat('dd-MM-yyyy').format(_dueDate);
  }

  void onDueDateTap(BuildContext context)async {
    DateTime _initialDate = DateFormat('dd-MM-yyyy').parse(_dueOnDateController.text);
    _dueOnDateController.text = await getDateFromDatePicker(context,_initialDate);
  }

  void onSaveTap(BuildContext context) {
    if(_customer == null){
      toastError('Please add customer');
    }else if(_invoiceItem.length == 0){
      toastError('Please add at least one item');
    }else if(_formKey.currentState.validate()){
      addEditDocument(context);
    }
  }

  void addEditDocument(BuildContext context,)async{

    showProgress(context);

    var d = Documents();
    d.invoice = _invoiceController.text;
    d.po = _poController.text;
    d.date = Timestamp.fromDate(DateFormat('dd-MM-yyyy').parse(_dateController.text));
    d.dueDate = _removeDueDate ? null : Timestamp.fromDate(DateFormat('dd-MM-yyyy').parse(_dueOnDateController.text));
    d.customer = _customer;
    d.item = _invoiceItem;
    d.subTotal = _getSubTotal().toDouble();
    d.total = d.subTotal;
    d.amountDue = d.total;
    d.mySignature = _mySignature;
    d.clientSignature = _clientSignature;
    d.recurring = _recurring;
    d.note = _noteController.text;
    d.photo = _photoList;
    d.taxDiscountShipping = TaxDiscountShipping();
    d.taxDiscountShipping.secondTax = SecondTax();
    d.createdAt = widget.forEdit ? widget.documents.updatedAt : Timestamp.fromDate(DateTime.now());
    d.updatedAt = Timestamp.fromDate(DateTime.now());
    d.status = 1;
    d.documentStatus = 'Pending';
    d.customerId = _customer.id;
    d.itemId = await getItemsId();

    bool _result;

    if(widget.forEdit){
       _result = await FirebaseService.editDocuments(widget.billId, widget.docId, d);
    }else{
      widget.bills.settingNext = widget.bills.settingNext + 1;
       _result = await FirebaseService.addDocument(widget.billId, d,widget.bills.settingNext);
    }

    Navigator.pop(context);

    if(_result){
      final _homeProvider = Provider.of<HomePageProvider>(context,listen: false);
      _homeProvider.isInvoiceWidget = false;
      _homeProvider.rideSideWidget = InvoiceWidget(
        id: widget.billId,
        bills: widget.bills,
      );
    }
  }

  void onSetCustomer(Customer value) {
    setState(() {
      _customer = value;
    });
  }

  void _removeItem(InvoiceItemModel item) {
    setState(() {
      _invoiceItem.remove(item);
    });
  }
  void _updateItem(InvoiceItemModel item,int index) {
    showDialog(
        context: context,
        builder: (context) =>
            ItemDialog(
              forEdit: true,
              fromInvoice: true,
              invoiceItemModel: item,
            )).then((value){
      if(value != null){
        InvoiceItemModel _item = value;
        setState(() {
          _invoiceItem[index] = _item;
        });
      }
    });
  }

  Future<List<String>> getItemsId()async{
    List<String> _list = [];
    for(InvoiceItemModel i in _invoiceItem){
      _list.add(i.id);
    }
    return _list;
  }

  // Widget _printView() => PdfView(printKey: _printKey,);

  void onPreviewTap(BuildContext context)async{
    showProgress(context);
    MyPdf(documents: widget.documents,billName: widget.bills.name).create().then((uint8list){
      Navigator.pop(context);
      if(uint8list != null){
        showDialog(
            context: context,
            builder: (context) => PreviewDialog(uint8list: uint8list,billName: widget.bills.name,invoiceNumber: widget.documents.invoice,)).then((value){
              if(value != null){
                showDialog(context: context,builder: (context) => SendEmailDialog(fileName: value,recipientEmail: _customer.email,uint8list: uint8list,));
              }
        });
      }
    });
  }
}
