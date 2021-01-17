import 'package:flutter/material.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/tax_discount_text_field.dart';

class AddTaxDiscountDialog extends StatefulWidget {


  AddTaxDiscountDialog({Key key, }) : super(key: key);

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

  int _inclusiveDeductive = 0;
  bool _isSecondTax = false;
  bool _isDeductibleSecondTax = false;
  bool _isIncludedTax = false;
  bool _isNonTaxable = false;

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
                        TaxDiscountTextField(labelText: 'Discount %',
                          controller: _discountController,),
                        SizedBox(height: 15,),
                        TaxDiscountTextField(labelText: 'Tax label *',
                          controller: _taxLabelController,),
                        SizedBox(height: 15,),
                        TaxDiscountTextField(
                          labelText: 'Tax %', controller: _taxController,),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(value: 0,
                                groupValue: _inclusiveDeductive,
                                onChanged: onRadioChanged,
                                title: Text('Inclusive', style: TextStyle(
                                    color: MyColors.text, fontSize: 13),),),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: RadioListTile(value: 1,
                                groupValue: _inclusiveDeductive,
                                onChanged: onRadioChanged,
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
                              TaxDiscountTextField(
                                labelText: 'Second Tax label',
                                controller: _secondTaxLabel,),
                              SizedBox(height: 15,),
                              TaxDiscountTextField(
                                labelText: 'Second Tax %',
                                controller: _secondTax,),
                              SizedBox(height: 15,),
                              CheckboxListTile(
                                value: _isDeductibleSecondTax,
                                onChanged: (value) {
                                  setState(() {
                                    _isDeductibleSecondTax = value;
                                  });
                                },
                                title: Text('Deductible (Second Tax)',
                                  style: TextStyle(
                                      color: MyColors.text, fontSize: 13),),),
                              Visibility(
                                visible: _isDeductibleSecondTax,
                                child: CheckboxListTile(
                                  value: _isIncludedTax, onChanged: (value) {
                                  // _provider.taxInclusiveDeductible = value;
                                  setState(() {
                                    _isIncludedTax = value;
                                  });
                                },
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
                                value: _isNonTaxable, onChanged: (value) {
                                // _provider.taxInclusiveDeductible = value;
                                setState(() {
                                  _isNonTaxable = value;
                                });
                              },
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

  void onSaveTap(BuildContext context) {}

  void onRadioChanged(int value) {
    setState(() {
      _inclusiveDeductive = value;
    });
  }
}