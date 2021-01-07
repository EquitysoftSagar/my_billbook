import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/model/address.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/customer_text_field.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/methods.dart';

class AddCustomerDialog extends StatelessWidget {

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
  FirebaseFirestore _firebaseFirestore;

  @override
  Widget build(BuildContext context) {
    _firebaseFirestore = FirebaseFirestore.instance;
    return Dialog(
        insetAnimationDuration: Duration(seconds: 8),
        insetAnimationCurve: Curves.bounceInOut,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: 500,
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
                          'Address',
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20,),
                        CustomerTextField(controller: _address1Controller,labelText: 'Address 1',),SizedBox(height: 20,),
                        CustomerTextField(controller: _address2Controller,labelText: 'Address 2',),SizedBox(height: 20,),
                        CustomerTextField(controller: _cityController,labelText: 'City',),SizedBox(height: 20,),
                        CustomerTextField(controller: _stateController,labelText: 'State',),SizedBox(height: 20,),
                        CustomerTextField(controller: _zipController,labelText: 'Zip',),SizedBox(height: 20,),
                        CustomerTextField(controller: _countryController,labelText: 'Country',),SizedBox(height: 20,),
                        Text(
                          'Shipping Address',
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
                        CustomerTextField(controller: _zipShippingController,labelText: 'Zip',),SizedBox(height: 20,),
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
      addCustomer(context);
    }
  }
  void addCustomer(BuildContext context)async{
    var a = Address();

    a.address1 = _address1Controller.text;
    a.address2 = _address2Controller.text;
    a.city = _cityController.text;
    a.state = _stateController.text;
    a.zip = 0;

    var sa = Address();

    sa.address1 = _address1ShippingController.text;
    sa.address2 = _address2ShippingController.text;
    sa.city = _cityShippingController.text;
    sa.state = _stateShippingController.text;

    a.zip = 0;

    var c = Customer();

    c.name = _nameController.text;
    c.email = _emailController.text;
    c.additionalInformation = _additionalInformationController.text;
    c.address = a;
    c.phoneNumber = 0;
    c.businessNumber = 0;
    c.shippingAddress = sa;
    c.userId = Constants.userId;

    try{
      showProgress(context);
     var _result = await _firebaseFirestore.collection('customer').add(c.toJson());
     Navigator.pop(context);
     Navigator.pop(context);
    }catch (e){
      Navigator.pop(context);
      print('error on add customer ===> $e');
    }
  }
}
