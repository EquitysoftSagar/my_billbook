import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/model/address.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/customer_text_field.dart';
import 'package:my_billbook/util/methods.dart';

import 'import_customer_item_dialog.dart';

// ignore: must_be_immutable
class CustomerDialog extends StatefulWidget {

  final bool forEdit;
  final Customer customer;
  final String id;
  final bool fromInvoice;

  CustomerDialog({Key key, this.forEdit,this.customer,this.id,this.fromInvoice}) : super(key: key);

  @override
  _CustomerDialogState createState() => _CustomerDialogState();
}

class _CustomerDialogState extends State<CustomerDialog> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  final _businessNumberController = TextEditingController();

  final _additionalInformationController = TextEditingController();

  final _address1Controller = TextEditingController();

  final _address2Controller = TextEditingController();

  final _cityController = TextEditingController();

  final _stateController = TextEditingController();

  final _zipController = TextEditingController();

  final _countryController = TextEditingController();

  final _address1ShippingController = TextEditingController();

  final _address2ShippingController = TextEditingController();

  final _cityShippingController = TextEditingController();

  final _stateShippingController = TextEditingController();

  final _zipShippingController = TextEditingController();

  final _countryShippingController = TextEditingController();

  final _forKey = GlobalKey<FormState>();

  String _customerId;

  @override
  void initState() {
    super.initState();

    if(widget.forEdit){
      _nameController.text = widget.customer.name;
      _emailController.text = widget.customer.email;
      _phoneNumberController.text = widget.customer.phoneNumber;
      _businessNumberController.text = widget.customer.businessNumber;
      _additionalInformationController.text = widget.customer.additionalInformation;

      _address1Controller.text = widget.customer.address.address1;
      _address2Controller.text = widget.customer.address.address2;
      _cityController.text = widget.customer.address.city;
      _stateController.text = widget.customer.address.state;
      _zipController.text = widget.customer.address.zip;
      _countryController.text = widget.customer.address.country;

      _address1ShippingController.text = widget.customer.shippingAddress.address1;
      _address2ShippingController.text = widget.customer.shippingAddress.address2;
      _cityShippingController.text = widget.customer.shippingAddress.city;
      _stateShippingController.text = widget.customer.shippingAddress.state;
      _zipShippingController.text = widget.customer.shippingAddress.zip;
      _countryShippingController.text = widget.customer.shippingAddress.country;
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
          height: 500,
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
                  'Customer',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _forKey,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(height: 20,),
                        CustomerTextField(controller: _nameController,labelText: 'Name *',),SizedBox(height: 20,),
                        CustomerTextField(controller: _emailController,labelText: 'Email',),SizedBox(height: 20,),
                        CustomerTextField(controller: _phoneNumberController,labelText: 'Phone Number',),SizedBox(height: 20,),
                        CustomerTextField(controller: _businessNumberController,labelText: 'Business Number',),SizedBox(height: 20,),
                        CustomerTextField(controller: _additionalInformationController,labelText: 'Additional information',),SizedBox(height: 20,),
                        Text(
                          'AddressModel',
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20,),
                        CustomerTextField(controller: _address1Controller,labelText: 'Address 1',),SizedBox(height: 20,),
                        CustomerTextField(controller: _address2Controller,labelText: 'Address1 2',),SizedBox(height: 20,),
                        CustomerTextField(controller: _cityController,labelText: 'City',),SizedBox(height: 20,),
                        CustomerTextField(controller: _stateController,labelText: 'State',),SizedBox(height: 20,),
                        CustomerTextField(controller: _zipController,labelText: 'Zip',),SizedBox(height: 20,),
                        CustomerTextField(controller: _countryController,labelText: 'Country',),SizedBox(height: 20,),
                        Text(
                          'Shipping AddressModel',
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20,),
                        CustomerTextField(controller: _address1ShippingController,labelText: 'Address 1',),SizedBox(height: 20,),
                        CustomerTextField(controller: _address2ShippingController,labelText: 'Address 2',),SizedBox(height: 20,),
                        CustomerTextField(controller: _cityShippingController,labelText: 'City',),SizedBox(height: 20,),
                        CustomerTextField(controller: _stateShippingController,labelText: 'State',),SizedBox(height: 20,),
                        CustomerTextField(controller: _zipShippingController,labelText: 'Zip2',),SizedBox(height: 20,),
                        CustomerTextField(controller: _countryShippingController,labelText: 'Country',),SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 20,),
                  Visibility(
                      visible: widget.fromInvoice,
                      child: FlatButton(onPressed: (){
                        onImportTap(context);
                      }, child: Text('Import from save customer'))),
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
        var a = AddressModel();

        a.address1 = _address1Controller.text;
        a.address2 = _address2Controller.text;
        a.city = _cityController.text;
        a.state = _stateController.text;
        a.zip = _zipController.text;
        a.country = _countryController.text;

        var sa = AddressModel();

        sa.address1 = _address1ShippingController.text;
        sa.address2 = _address2ShippingController.text;
        sa.city = _cityShippingController.text;
        sa.state = _stateShippingController.text;
        sa.country = _countryShippingController.text;
        sa.zip = _zipShippingController.text;

        var c = Customer();

        c.id = _customerId;
        c.name = _nameController.text;
        c.email = _emailController.text;
        c.additionalInformation = _additionalInformationController.text;
        c.address = a;
        c.phoneNumber = _phoneNumberController.text;
        c.businessNumber = _businessNumberController.text;
        c.shippingAddress = sa;
        // c.userId = firebaseUser.uid;
        // c.createdAt = widget.forEdit ? widget.customer.createdAt : Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
        // c.updatedAt = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
        // c.status = 1;
        Navigator.pop(context,c);
      }else{
        addEditCustomer(context);
      }
    }
  }


  void addEditCustomer(BuildContext context)async{
    var a = AddressModel();

    a.address1 = _address1Controller.text;
    a.address2 = _address2Controller.text;
    a.city = _cityController.text;
    a.state = _stateController.text;
    a.zip = _zipController.text;
    a.country = _countryController.text;

    var sa = AddressModel();

    sa.address1 = _address1ShippingController.text;
    sa.address2 = _address2ShippingController.text;
    sa.city = _cityShippingController.text;
    sa.state = _stateShippingController.text;
    sa.country = _countryShippingController.text;
    sa.zip = _zipShippingController.text;

    var c = Customer();

    c.name = _nameController.text;
    c.email = _emailController.text;
    c.additionalInformation = _additionalInformationController.text;
    c.address = a;
    c.phoneNumber = _phoneNumberController.text;
    c.businessNumber = _businessNumberController.text;
    c.shippingAddress = sa;
    c.userId = firebaseUser.uid;
    c.createdAt = widget.forEdit ? widget.customer.createdAt : Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    c.updatedAt = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
    c.status = 1;

    showProgress(context);
    var _result = widget.forEdit ? await FirebaseService.editCustomer(widget.id,c) : await FirebaseService.addCustomer(c);
    if(_result){
      Navigator.pop(context);
      Navigator.pop(context);
    }else{
      Navigator.pop(context);
    }
  }

  void onImportTap(BuildContext context) {
    showDialog(context: context,builder: (context) => ImportCustomerItemDialog(
      headerTitle: 'Customer List',
    )).then((value){
      if(value != null){
        Customer customer = value;

        _customerId = customer.id;
        _nameController.text = customer.name;
        _emailController.text = customer.email;
        _businessNumberController.text = customer.businessNumber;
        _phoneNumberController.text = customer.phoneNumber;
        _additionalInformationController.text = customer.additionalInformation;

        AddressModel address = customer.address;

        _address1Controller.text = address.address1;
        _address2Controller.text = address.address2;
        _cityController.text = address.city;
        _stateController.text = address.state;
        _countryController.text = address.country;

        AddressModel shippingAddress = customer.shippingAddress;

        _address1ShippingController.text = shippingAddress.address1;
        _address2ShippingController.text = shippingAddress.address2;
        _cityShippingController.text = shippingAddress.city;
        _stateShippingController.text = shippingAddress.state;
        _countryShippingController.text = shippingAddress.country;

      }
    });
  }
}
