import 'second_tax.dart';

class TaxDiscountShipping {
  String discount;
  String discountType;
  String tax;
  String taxType;
  String taxLabel;
  String shipping;
  bool inclusive;
  bool deductible;
  bool nonTaxable;
  SecondTax secondTax;

  TaxDiscountShipping(
      {this.discount,
        this.discountType,
        this.tax,
        this.taxType,
        this.taxLabel,
        this.shipping,
        this.inclusive,
        this.deductible,
        this.nonTaxable,
        this.secondTax});

  TaxDiscountShipping.fromJson(Map<String, dynamic> json) {
    discount = json['discount'];
    discountType = json['discount_type'];
    tax = json['tax'];
    taxType = json['tax_type'];
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
    data['discount_type'] = this.discountType;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
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
