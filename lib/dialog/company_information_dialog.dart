import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/text_field/company_information_text_field.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/methods.dart';

class CompanyInformationDialog extends StatelessWidget {
  final _scrollController = ScrollController();

  final _companyNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _additionalInformationController = TextEditingController();
  final _abbreviationController = TextEditingController();
  final _businessNumberController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _countryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    _companyNameController.text = userModel.companyInformation.companyName;
    _emailAddressController.text = userModel.companyInformation.emailOnInvoice;
    _phoneNumberController.text = userModel.companyInformation.phoneNumber;
    _additionalInformationController.text = userModel.companyInformation.additionalInformation;
    _abbreviationController.text = userModel.companyInformation.abbreviation;
    _businessNumberController.text = userModel.companyInformation.businessNumber;
    _address1Controller.text = userModel.companyInformation.address.address1;
    _address2Controller.text = userModel.companyInformation.address.address2;
    _cityController.text = userModel.companyInformation.address.city;
    _stateController.text = userModel.companyInformation.address.state;
    _zipController.text = userModel.companyInformation.address.zip;
    _countryController.text = userModel.companyInformation.address.country;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 400,
        height: 500,
        padding: EdgeInsets.only(
          bottom: 15,
        ),
        child: Column(
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
                'Company Information',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Flexible(
              child: CupertinoScrollbar(
                thickness: 6.0,
                thicknessWhileDragging: 6.0,
                controller: _scrollController,
                isAlwaysShown: true,
                radius: Radius.circular(0),
                radiusWhileDragging: Radius.circular(0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        SizedBox(height: 20,),
                        CompanyInformationTextField(labelText: 'Company Name',controller: _companyNameController,),SizedBox(height: 20,),
                        CompanyInformationTextField(labelText: 'Email address in invoice',controller: _emailAddressController,),SizedBox(height: 20,),
                        CompanyInformationTextField(labelText: 'Phone Number',controller: _phoneNumberController,),SizedBox(height: 20,),
                        CompanyInformationTextField(labelText: 'Additional information',controller: _additionalInformationController,),SizedBox(height: 20,),
                        Text(
                          'Business Number',
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        SizedBox(height: 20,),
                        CompanyInformationTextField(labelText: 'Abbreviation',controller: _abbreviationController,),SizedBox(height: 20,),
                        CompanyInformationTextField(labelText: 'Business Number',controller: _businessNumberController,),SizedBox(height: 20,),
                        Text(
                          'Address',
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        SizedBox(height: 20,),
                        CompanyInformationTextField(labelText: 'Address 1',controller: _address1Controller,),SizedBox(height: 20,),
                        CompanyInformationTextField(labelText: 'Address 2',controller: _address2Controller,),SizedBox(height: 20,),
                        CompanyInformationTextField(labelText: 'City',controller: _cityController,),SizedBox(height: 20,),
                        CompanyInformationTextField(labelText: 'State',controller: _stateController,),SizedBox(height: 20,),
                        CompanyInformationTextField(labelText: 'Zip',controller: _zipController,),SizedBox(height: 20,),
                        CompanyInformationTextField(labelText: 'Country',controller: _countryController,),SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
      ),
    );
  }

  void onSaveTap(BuildContext context) async{
    if(_formKey.currentState.validate()){
      showProgress(context);

      userModel.companyInformation.companyName = _companyNameController.text;
      userModel.companyInformation.emailOnInvoice = _emailAddressController.text;
      userModel.companyInformation.phoneNumber = _phoneNumberController.text;
      userModel.companyInformation.additionalInformation = _additionalInformationController.text;
      userModel.companyInformation.abbreviation = _abbreviationController.text;
      userModel.companyInformation.businessNumber = _businessNumberController.text;
      userModel.companyInformation.address.address1 = _address1Controller.text;
      userModel.companyInformation.address.address2 = _address2Controller.text;
      userModel.companyInformation.address.city = _cityController.text;
      userModel.companyInformation.address.state = _stateController.text;
      userModel.companyInformation.address.zip = _zipController.text;
      userModel.companyInformation.address.country = _countryController.text;

      var _result = await FirebaseService.updateCompanyInformation(userModel.companyInformation);
      Navigator.pop(context);
      if(_result){
        Navigator.pop(context);
      }
    }
  }
}
