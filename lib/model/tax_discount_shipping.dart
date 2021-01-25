import 'second_tax.dart';

class TaxDiscountShipping {
  double discount;
  int tax;
  String taxLabel;
  double shipping;
  bool inclusive;
  bool deductible;
  bool nonTaxable;
  SecondTax secondTax;

  TaxDiscountShipping(
      {
        this.discount = 0.00,
        this.tax = 0,
        this.taxLabel = 'Tax',
        this.shipping = 0,
        this.inclusive = false,
        this.deductible = false,
        this.nonTaxable = false,
        this.secondTax});

  TaxDiscountShipping.fromJson(Map<String, dynamic> json) {
    discount = json['discount'];
    tax = json['tax'];
    taxLabel = json['tax_label'];
    shipping = json['shipping'];
    inclusive = json['inclusive'];
    deductible = json['deductible'];
    nonTaxable = json['non_taxable'];
    secondTax = json['second_tax'] != null
        ? new SecondTax.fromJson(json['second_tax'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount'] = this.discount;
    data['tax'] = this.tax;
    data['tax_label'] = this.taxLabel;
    data['shipping'] = this.shipping;
    data['inclusive'] = this.inclusive;
    data['deductible'] = this.deductible;
    data['non_taxable'] = this.nonTaxable;
    if (this.secondTax != null) {
      data['second_tax'] = this.secondTax.toJson();
    }
    return data;
  }
}
