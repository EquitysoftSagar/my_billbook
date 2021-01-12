import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/import_invoice_customer_item_dialog.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/item_text_field.dart';
import 'package:my_billbook/util/methods.dart';

class AddItemDialog extends StatefulWidget {

  final bool forEdit;
  final Item item;
  final String id;
  final bool fromInvoice;
  final HomePageProvider provider;

  const AddItemDialog({Key key, this.forEdit, this.item, this.id,this.fromInvoice,this.provider}) : super(key: key);

  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final _nameController = TextEditingController();

  final _priceController = TextEditingController();

  final _descriptionController = TextEditingController();

  final _discountController = TextEditingController();

  final _quantityController = TextEditingController();

  final _forKey = GlobalKey<FormState>();
  Item item = Item();

  @override
  void initState() {
    super.initState();
    if(widget.forEdit){
      _nameController.text = widget.item.name;
      _priceController.text = widget.item.price == 0 ? '' : widget.item.price.toString();
      _descriptionController.text = widget.item.description;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetAnimationDuration: Duration(seconds: 8),
        insetAnimationCurve: Curves.bounceInOut,
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
                      ItemTextField(controller: _priceController,labelText: 'Price *',),SizedBox(height: 20,),
                      Visibility(
                        visible: widget.fromInvoice,
                        child: Column(
                          children: [
                            ItemTextField(controller: _quantityController,labelText: 'Quantity',),SizedBox(height: 20,),
                            ItemTextField(controller: _discountController,labelText: 'Discount',),SizedBox(height: 20,),
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
        widget.provider.addInvoiceItem = item;
        Navigator.pop(context);
      }else{
        addEditItem(context);
      }
    }
  }

  void addEditItem(BuildContext context)async{
    var i = Item();

    i.name = _nameController.text;
    i.price = int.parse(_priceController.text);
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
       item = value;
      _nameController.text = item.name;
      _priceController.text = item.price.toString();
      _descriptionController.text = item.description;
    });
  }
}
