import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/model/invoice_item_model.dart';

import 'photo.dart';
import 'tax_discount_shipping.dart';

class Documents {
  String invoice;
  String po;
  Timestamp date;
  Timestamp dueDate;
  String subTotal;
  String total;
  String amountDue;
  TaxDiscountShipping taxDiscountShipping;
  Customer customer;
  List<InvoiceItemModel> item;
  bool mySignature;
  bool clientSignature;
  String note;
  List<Photo> photo;
  int status;
  String documentStatus;
  String recurring;
  String customerId;
  List<String> itemId;
  Timestamp createdAt;
  Timestamp updatedAt;

  Documents(
      {this.invoice,
        this.po,
        this.date,
        this.dueDate,
        this.subTotal,
        this.total,
        this.amountDue,
        this.taxDiscountShipping,
        this.customer,
        this.item,
        this.recurring,
        this.mySignature,
        this.clientSignature,
        this.note,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.documentStatus,
        this.customerId,
        this.itemId,
        this.photo});

  Documents.fromJson(Map<String, dynamic> json) {
    invoice = json['invoice'];
    po = json['po'];
    date = json['date'];
    dueDate = json['due_date'];
    subTotal = json['sub_total'];
    total = json['total'];
    status = json['status'];
    amountDue = json['amount_due'];
    recurring = json['recurring'];
    documentStatus = json['document_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerId = json['customer_id'];
    taxDiscountShipping = json['tax_discount_shipping'] != null
        ? new TaxDiscountShipping.fromJson(json['tax_discount_shipping'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['item'] != null) {
      item = [];
      json['item'].forEach((v) {
        item.add(new InvoiceItemModel.fromJson(v));
      });
    }
    if (json['item_id'] != null) {
      itemId = [];
      json['item_id'].forEach((v) {
        itemId.add(v);
      });
    }
    mySignature = json['my_signature'];
    clientSignature = json['client_signature'];
    note = json['note'];
    if (json['photo'] != null) {
      photo = [];
      json['photo'].forEach((v) {
        photo.add(new Photo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice'] = this.invoice;
    data['po'] = this.po;
    data['date'] = this.date;
    data['due_date'] = this.dueDate;
    data['sub_total'] = this.subTotal;
    data['total'] = this.total;
    data['status'] = this.status;
    data['recurring'] = this.recurring;
    data['amount_due'] = this.amountDue;
    data['document_status'] = this.documentStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.taxDiscountShipping != null) {
      data['tax_discount_shipping'] = this.taxDiscountShipping.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    data['customer_id'] = this.customerId;
    if (this.item != null) {
      data['item'] = this.item.map((v) => v.toJson()).toList();
    }
    if (this.itemId != null) {
      data['item_id'] = this.itemId.map((v) => v).toList();
    }
    data['my_signature'] = this.mySignature;
    data['client_signature'] = this.clientSignature;
    data['note'] = this.note;
    if (this.photo != null) {
      data['photo'] = this.photo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}