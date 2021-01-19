import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/model/invoice_item_model.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/item_text_field.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/methods.dart';

import 'import_customer_item_dialog.dart';

class ItemDialog extends StatefulWidget {

  final bool forEdit;
  final Item item;
  final InvoiceItemModel invoiceItemModel;
  final String id;
  final bool fromInvoice;

  const ItemDialog({Key key, this.forEdit, this.item, this.id,this.fromInvoice,this.invoiceItemModel}) : super(key: key);

  @override
  _ItemDialogState createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  final _nameController = TextEditingController();

  final _priceController = TextEditingController();

  final _descriptionController = TextEditingController();

  final _discountController = TextEditingController();

  final _quantityController = TextEditingController();

  final _forKey = GlobalKey<FormState>();
  InvoiceItemModel _invoiceItemModel = InvoiceItemModel();

  int _totalAmount = 0;
  String _itemId;

  @override
  void initState() {
    super.initState();
    _quantityController.text = 1.toString();

    if(widget.forEdit){
      if(widget.fromInvoice){
        _nameController.text = widget.invoiceItemModel.name;
            _priceController.text = widget.invoiceItemModel.price;
            _descriptionController.text = widget.invoiceItemModel.description;
            _discountController.text = widget.invoiceItemModel.discount;
            _quantityController.text = widget.invoiceItemModel.quantity;
            _totalAmount = int.parse( widget.invoiceItemModel.amount);
      }else{
        _nameController.text = widget.item.name;
        _priceController.text = widget.item.price;
        _descriptionController.text = widget.item.description;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: 400,
          padding: EdgeInsets.only(bottom: 15,),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                height: 50,
                decoration: BoxDecoration(
                    color: MyColors.accent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )),
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Item',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _forKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      ItemTextField(controller: _nameController,labelText: 'Name *',),SizedBox(height: 20,),
                      ItemTextField(controller: _priceController,labelText: 'Price *',onChangedFunction: (value){
                        onPriceChangedFunction(value);
                      },
                      price: _getCalculatedPrice(),),SizedBox(height: 20,),
                      Visibility(
                        visible: widget.fromInvoice,
                        child: Column(
                          children: [
                            ItemTextField(controller: _quantityController,labelText: 'Quantity',onChangedFunction: (value){
                             onQuantityChangedFunction(value);
                            },
                            price: _getCalculatedPrice(),),SizedBox(height: 20,),
                            ItemTextField(controller: _discountController,labelText: 'Discount',onChangedFunction: (value){
                              onDiscountChangedFunction(value);
                            },price:_getCalculatedPrice()),SizedBox(height: 20,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueAccent.withOpacity(0.08),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Amount',style: TextStyle(fontSize: 15,color: MyColors.accent,fontWeight: FontWeight.bold),),
                                  Text('${Constants.indianCurrencySymbol} $_totalAmount',style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      ItemTextField(controller: _descriptionController,labelText: 'Description',),SizedBox(height: 20,),
                      /*Visibility(
                        visible: widget.fromInvoice,
                        child: CheckboxListTile(value: _gstIncluded , onChanged: (value) {
                          setState(() {
                            _gstIncluded = value;
                          });
                        },title: Text('Gst Included')),
                      ),*/
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Visibility(
                    visible: widget.fromInvoice,
                      child: FlatButton(onPressed: (){
                        onImportTap(context);
                      }, child: Text('Import from save items'))),
                  Spacer(),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                    color: Colors.white,
                    textColor: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      onSaveTap(context);
                    },
                    child: Text('Save'),
                    color: MyColors.accent,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void onSaveTap(BuildContext context) {
    if(_forKey.currentState.validate()){
      if(widget.fromInvoice){
        _invoiceItemModel.name = _nameController.text;
        _invoiceItemModel.price = _priceController.text;
        _invoiceItemModel.description = _descriptionController.text;
        _invoiceItemModel.quantity = _quantityController.text.isEmpty ? '1' :_quantityController.text;
        _invoiceItemModel.discount = _discountController.text.isEmpty ? '0' : _discountController.text;
        _invoiceItemModel.amount = _totalAmount.toString();
        _invoiceItemModel.id = _itemId;
        Navigator.pop(context,_invoiceItemModel);
      }else{
        addEditItem(context);
      }
    }
  }

  void addEditItem(BuildContext context)async{
    var i = Item();

    i.name = _nameController.text;
    i.price = _priceController.text;
    i.description = _descriptionController.text;
    i.createdAt =  widget.forEdit ? widget.item.createdAt : Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    i.updatedAt = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    i.userId = firebaseUser.uid;
    i.status = 1;

      showProgress(context);
      var _result = widget.forEdit ? await FirebaseService.editItem(widget.id,i) : await FirebaseService.addItem(i);
      if(_result){
        Navigator.pop(context);
        Navigator.pop(context);
      }else{
        Navigator.pop(context);
      }
  }

  void onImportTap(BuildContext context) {
    showDialog(context: context,builder: (context) => ImportCustomerItemDialog(
      headerTitle: 'Items List',
    )).then((value){
      if(value != null){
        Item item = value;
        _itemId = item.id;
        _nameController.text = item.name;
        _priceController.text = item.price.toString();
        _descriptionController.text = item.description;

        setState(() {
          _totalAmount = int.parse(item.price);
        });
      }
    });
  }

  void onQuantityChangedFunction(value) {
    setState(() {
      int _price = _priceController.text.isEmpty ? 0 : int.parse(_priceController.text);
      int _quantity = _quantityController.text.isEmpty ? 1 : int.parse(value);
      int _discount = _discountController.text.isEmpty ? 0 : int.parse(_discountController.text);
      _totalAmount = (_price * _quantity) - _discount;
    });
  }
  void onDiscountChangedFunction(value) {
    setState(() {
      int _discount = _discountController.text.isEmpty ? 0 : int.parse(value);
      int _price = _priceController.text.isEmpty ? 0 : int.parse(_priceController.text);
      int _quantity = _quantityController.text.isEmpty ? 1 : int.parse(_quantityController.text);
      _totalAmount = (_price * _quantity) - _discount;
    });
  }

  void onPriceChangedFunction(value) {
    setState(() {
      int _price = _priceController.text.isEmpty ? 0 : int.parse(value);
      int _quantity = _quantityController.text.isEmpty ? 1 : int.parse(_quantityController.text);
      int _discount = _discountController.text.isEmpty ? 0 : int.parse(_discountController.text);
      _totalAmount = (_price * _quantity) - _discount;
    });
  }

  int _getCalculatedPrice(){
    int _price =  _priceController.text.isEmpty ? 0 : int.parse(_priceController.text);
    int _quantity =  _quantityController.text.isEmpty ? 1 : int.parse(_quantityController.text);
    return _price * _quantity;
  }
}
