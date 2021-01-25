import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_billbook/model/second_tax.dart';
import 'package:my_billbook/model/tax_discount_shipping.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/tax_discount_text_field.dart';

class AddTaxDiscountDialog extends StatefulWidget {

  final TaxDiscountShipping taxDiscountShipping;

  const AddTaxDiscountDialog({Key key, this.taxDiscountShipping}) : super(key: key);

  @override
  _AddTaxDiscountDialogState createState() => _AddTaxDiscountDialogState();
}

class _AddTaxDiscountDialogState extends State<AddTaxDiscountDialog> {
  final _discountController = TextEditingController();
  final _taxLabelController = TextEditingController();
  final _taxController = TextEditingController();
  final _shippingController = TextEditingController();
  final _secondTaxLabel = TextEditingController();
  final _secondTax = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _secondTaxFormKey = GlobalKey<FormState>();

  var _isSecondTax = false;
  var _inclusive = false;
  var _deductible = false;
  var _deductibleSecondTax = false;
  var _includingTax = false;
  var _nonTaxable = false;

  @override
  void initState() {
    super.initState();
    _discountController.text = widget.taxDiscountShipping.discount.toString();
    _taxLabelController.text = widget.taxDiscountShipping.taxLabel.toString();
    _taxController.text = widget.taxDiscountShipping.tax.toString();
    _shippingController.text = widget.taxDiscountShipping.shipping.toString();
    _isSecondTax = widget.taxDiscountShipping.secondTax == null ? false : true;
    if(widget.taxDiscountShipping.secondTax != null){
      _secondTaxLabel.text = widget.taxDiscountShipping.secondTax.taxLabel;
      _secondTax.text = widget.taxDiscountShipping.secondTax.tax.toString();
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
                  'Tax & Discount',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15),
                  child: Form(
                    // key: _forKey,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        TaxDiscountTextField(labelText: 'Discount',
                          controller: _discountController,),
                        SizedBox(height: 15,),
                        Form(
                          key: _formKey,
                          child: TaxDiscountTextField(labelText: 'Tax label *',
                            controller: _taxLabelController,),
                        ),
                        SizedBox(height: 15,),
                        TaxDiscountTextField(
                          labelText: 'Tax %', controller: _taxController,),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                value: _inclusive,
                                onChanged: !_deductible ? onInclusiveChanged : null,
                                title: Text('Inclusive', style: TextStyle(
                                    color: MyColors.text, fontSize: 13),),),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: CheckboxListTile(
                                value: _deductible,
                                onChanged: onDeductibleChanged,
                                title: Text('Deductible', style: TextStyle(
                                    color: MyColors.text, fontSize: 13),),),
                            ),
                          ],
                        ),
                        SizedBox(width: 150,
                            child: SwitchListTile(
                              value: _isSecondTax, onChanged: (value) {
                             setState(() {
                               _isSecondTax = value;
                             });
                            }, title: Text('Second Tax', style: TextStyle(
                                color: MyColors.text, fontSize: 13),),)),
                        SizedBox(height: 15,),
                        Visibility(
                          visible: _isSecondTax,
                          child: Column(
                            children: [
                              Form(
                                key : _secondTaxFormKey,
                                child: TaxDiscountTextField(
                                  labelText: 'Second Tax label',
                                  controller: _secondTaxLabel,),
                              ),
                              SizedBox(height: 15,),
                              TaxDiscountTextField(
                                labelText: 'Second Tax %',
                                controller: _secondTax,),
                              SizedBox(height: 15,),
                              CheckboxListTile(
                                value: _deductibleSecondTax,
                                onChanged: _onSecondTaxDeductibleChanged,
                                title: Text('Deductible (Second Tax)',
                                  style: TextStyle(
                                      color: MyColors.text, fontSize: 13),),),
                              Visibility(
                                visible: _deductibleSecondTax,
                                child: CheckboxListTile(
                                  value:_includingTax,
                                  onChanged: _onSecondTaxIncludedChanged,
                                  title: Text('Including tax', style: TextStyle(
                                      color: MyColors.text, fontSize: 13),),),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Expanded(
                                flex: 3, child: TaxDiscountTextField(
                              labelText: 'Shipping %',
                              controller: _shippingController,)),
                            Expanded(
                              flex: 3,
                              child: CheckboxListTile(
                                value: _nonTaxable,
                                onChanged: _onNonTaxableChanged,
                                title: Text('Non-taxable', style: TextStyle(
                                    color: MyColors.text, fontSize: 13),),),
                            ),
                          ],
                        )
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
    if(_formKey.currentState.validate()){
      widget.taxDiscountShipping.discount = roundDouble(double.parse(_discountController.text.isEmpty ? '0.00' : _discountController.text), 2);
      widget.taxDiscountShipping.taxLabel = _taxLabelController.text;
      widget.taxDiscountShipping.tax = int.parse(_taxController.text.isEmpty ? '0' : _taxController.text);
      widget.taxDiscountShipping.shipping = roundDouble(double.parse(_shippingController.text.isEmpty ? '0.00' : _shippingController.text), 2);
      widget.taxDiscountShipping.inclusive = _inclusive;
      widget.taxDiscountShipping.deductible = _deductible;
      if(_isSecondTax){
        if(_secondTaxFormKey.currentState.validate()){
          var s = SecondTax();
          s.tax = int.parse(_secondTax.text.isEmpty ? '0' : _secondTax.text);
          s.taxLabel = _secondTaxLabel.text;
          widget.taxDiscountShipping.secondTax = s;
        }else{
          return;
        }
      }
      Navigator.pop(context,true);
    }
  }

  void onInclusiveChanged(bool value) {
    setState(() {
      _inclusive = value;
    });
  }
  void onDeductibleChanged(bool value) {
    setState(() {
      _deductible = value;
    });
  }

  void _onSecondTaxDeductibleChanged(bool value) {
    setState(() {
      _deductibleSecondTax = value;
    });
  }
  void _onSecondTaxIncludedChanged(bool value) {
    setState(() {
      _includingTax = value;
    });
  }

  void _onNonTaxableChanged(bool value) {
    setState(() {
      _nonTaxable = value;
    });
  }
  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}