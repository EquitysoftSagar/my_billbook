import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/model/document.dart';
import 'package:my_billbook/model/invoice_item_model.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/methods.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class MyPdf{

  final String billName;
  final Documents documents;

  MyPdf({this.billName,this.documents});


  Widget headerView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image(imageProvider,height: 250,width: 250,fit: BoxFit.fill,),
        Text(userModel.companyInformation.companyName
            , style: TextStyle(color: PdfColor.fromHex('#000000'),fontSize: 22,fontWeight: FontWeight.normal)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(billName
                , style: TextStyle(color: PdfColor.fromHex('#000000'),fontSize: 20,fontWeight: FontWeight.normal)),SizedBox(height: 7,),
            Text(userModel.companyInformation.companyName
                ,style: TextStyle(color: PdfColor.fromHex('#000000'),fontSize: 13,fontWeight: FontWeight.bold)
            ),SizedBox(height: 5,),
            Text(userModel.companyInformation.emailOnInvoice
                ,style: TextStyle(color: PdfColor.fromHex('#000000'),fontSize: 10,fontWeight: FontWeight.normal)
            ),SizedBox(height: 5,),
          ],
        )
      ],
    );
  }

  Widget _itemListView(InvoiceItemModel item,int index) => Container(
       padding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
       color: PdfColor.fromHex(index % 2 == 0 ? '#ffffff' : '#EEEEEE'),
       child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               children: [
                 Expanded(
                   flex: 3,
                   child: Text(
                     item.name,
                     textAlign: TextAlign.left,
                     style: TextStyle(
                         color: PdfColor.fromHex('#000000'),
                         fontWeight: FontWeight.bold,
                         fontSize: 10.0),
                   ),
                 ),
                 Expanded(
                   flex: 1,
                   child: Text(
                     item.quantity,
                     textAlign: TextAlign.right,
                     style: TextStyle(
                         color: PdfColor.fromHex('#000000'),
                         fontWeight: FontWeight.normal,
                         fontSize: 10.0),
                   ),
                 ),
                 Expanded(
                   flex: 1,
                   child: Text(
                     '${Constants.indianCurrencySymbol}${item.price ?? 0}',
                     textAlign: TextAlign.right,
                     style: TextStyle(
                         color: PdfColor.fromHex('#000000'),
                         fontWeight: FontWeight.normal,
                         fontSize: 10.0),
                   ),
                 ),
                 Expanded(
                   flex: 1,
                   child: Text(
                     '${Constants.indianCurrencySymbol}${item.discount ?? 0}',
                     textAlign: TextAlign.right,
                     style: TextStyle(
                         color: PdfColor.fromHex('#000000'),
                         fontWeight: FontWeight.normal,
                         fontSize: 10.0),
                   ),
                 ),
                 Text(
                   '${Constants.indianCurrencySymbol}${item.amount ?? 0}',
                   textAlign: TextAlign.right,
                   style: TextStyle(
                       color: PdfColor.fromHex('#000000'),
                       fontWeight: FontWeight.normal,
                       fontSize: 10.0),
                 ),
               ],
             ),
             if(item.description.isNotEmpty) Padding(
               padding:  EdgeInsets.only(top: 10),
               child: Text(item.description,style: TextStyle(color: PdfColor.fromHex('#000000'),fontWeight: FontWeight.normal,fontSize: 8),),
             ),
           ]
       )
   );
  Widget _totalView() => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
            width : 160,
            child: Column(
                crossAxisAlignment:CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                        Text('${Constants.indianCurrencySymbol}${documents.subTotal}',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                      ]
                  ),
                  SizedBox(height: 5),
                  /*if(documents.taxDiscountShipping.discount.isNotEmpty)*/Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                        Text('${Constants.indianCurrencySymbol}0',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                      ]
                  ),
                  SizedBox(height: 5),
                  /*if(documents.taxDiscountShipping.tax.isNotEmpty)*/Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('TAX included(0%)',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                        Text('${Constants.indianCurrencySymbol}0',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                      ]
                  ),
                  SizedBox(height: 5),
                  /*if(documents.taxDiscountShipping.shipping.isNotEmpty)*/Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Shipping',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                        Text('${Constants.indianCurrencySymbol}0',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                      ]
                  ),
                  Divider(
                    color: PdfColor.fromHex('#E4E4E4'),
                    thickness: 2,
                    height: 20,
                  ),
                  if(documents.total.isNotEmpty)Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Net',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                        Text('${Constants.indianCurrencySymbol}${documents.total}',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                      ]
                  ),
                  SizedBox(height: 5),
                  if(documents.total.isNotEmpty)Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                        Text('${Constants.indianCurrencySymbol}${documents.total}',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                      ]
                  ),
                  Divider(
                    color: PdfColor.fromHex('#E4E4E4'),
                    thickness: 2,
                    height: 20,
                  ),
                  SizedBox(height: 5),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Amount Due',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.bold ,fontSize: 15),),
                        Text('${Constants.indianCurrencySymbol}${documents.total}',style: TextStyle(color: PdfColor.fromHex('#00930C'),height:1,fontWeight: FontWeight.bold ,fontSize: 15),),
                      ]
                  ),
                ]
            ))
      ]
  );
  Widget _signDocumentView() => Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
      Text('By signing this document, the customer agrees to the services and conditions described in this document.',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
        SizedBox(height: 15),
        Row(
        children: [
          Expanded(
            child:  Column(
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [
                  Text(userModel.firstName,style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.bold ,fontSize: 11),),
                  SizedBox(height: 60),
                  Divider(
                    color: PdfColor.fromHex('#E4E4E4'),
                    thickness: 2,
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(dateTimeToString('dd MMM yyyy', DateTime.now()),style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                  )
                ]
            )
          ),
          SizedBox(width: 50),
          Expanded(
              child:  Column(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    Text(documents.customer.name,style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.bold ,fontSize: 11),),
                    SizedBox(height: 60),
                    Divider(
                      color: PdfColor.fromHex('#E4E4E4'),
                      thickness: 2,
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('(     /     /     )',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                    )
                  ]
              )
          )
        ]
      )
    ]
  );
  Widget _customerView() {
    final Customer customer = documents.customer;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('BILL TO',style: TextStyle(color: PdfColor.fromHex('#000000'),fontWeight: FontWeight.bold ,fontSize: 10),),SizedBox(height: 5),
            Text(customer.name,style: TextStyle(color: PdfColor.fromHex('#000000'),lineSpacing:5,fontWeight: FontWeight.normal ,fontSize: 8),),
            if(customer.address.address1.isNotEmpty) Text(customer.address.address1,style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 8),),
            if(customer.address.address2.isNotEmpty) Text(customer.address.address2,style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 8),),
            if(customer.address.city.isNotEmpty || customer.address.state.isNotEmpty ||customer.address.zip.isNotEmpty) Text('${customer.address.city} ${customer.address.state} ${customer.address.zip}',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 8),),
            if(customer.address.country.isNotEmpty) Text(customer.address.country,style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 8),),
            if(customer.email.isNotEmpty) Text(customer.email,style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 8),),
            if(customer.phoneNumber.isNotEmpty) Text(customer.phoneNumber,style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 8),),
            SizedBox(height: 5),
            if(customer.shippingAddress.address1.isNotEmpty || customer.shippingAddress.address2.isNotEmpty || customer.shippingAddress.address1.isNotEmpty || customer.shippingAddress.city.isNotEmpty || customer.shippingAddress.state.isNotEmpty || customer.shippingAddress.zip.isNotEmpty || customer.shippingAddress.country.isNotEmpty) Text('SHIP TO',style: TextStyle(color: PdfColor.fromHex('#000000'),height: 1.3,fontWeight: FontWeight.bold ,fontSize: 10),),SizedBox(height: 5),
            if(customer.shippingAddress.address1.isNotEmpty) Text(customer.shippingAddress.address1,style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 8),),
            if(customer.shippingAddress.address2.isNotEmpty) Text(customer.shippingAddress.address2,style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 8),),
            if(customer.shippingAddress.city.isNotEmpty || customer.shippingAddress.state.isNotEmpty ||customer.shippingAddress.zip.isNotEmpty) Text('${customer.shippingAddress.city} ${customer.shippingAddress.state} ${customer.shippingAddress.zip}',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 8),),
            if(customer.shippingAddress.country.isNotEmpty) Text(customer.shippingAddress.country,style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 8),),
            if(customer.additionalInformation.isNotEmpty) Text(customer.additionalInformation,style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 8),),
          ],
        ),
        SizedBox(
          width: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$billName #',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.bold ,fontSize: 10),),
                    Text('${documents.invoice}',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                  ]
              ),
              SizedBox(height: 5),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.bold ,fontSize: 10),),
                    Text('${timeStampToString('dd-MM-yyyy',documents.date)}',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                  ]
              ),
              if(documents.dueDate != null) SizedBox(height: 5),
              if(documents.dueDate != null) Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Due Date',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.bold ,fontSize: 10),),
                    Text('${timeStampToString('dd-MM-yyyy',documents.dueDate)}',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                  ]
              ),
              SizedBox(height: 5),
              if(documents.po != null) Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('PO #',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.bold ,fontSize: 10),),
                    Text('${documents.po}',style: TextStyle(color: PdfColor.fromHex('#000000'),height:1,fontWeight: FontWeight.normal ,fontSize: 10),),
                  ]
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _itemsView(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
          margin: EdgeInsets.only(top: 20),
          color: PdfColor.fromHex('#d6f4ff'),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Item',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: PdfColor.fromHex('#000000'),
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Quantity',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: PdfColor.fromHex('#000000'),
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Price',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: PdfColor.fromHex('#000000'),
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Discount',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: PdfColor.fromHex('#000000'),
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0),
                ),
              ),
              Text(
                'Amount',
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: PdfColor.fromHex('#000000'),
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0),
              ),
            ],
          ),
        ),
        ListView.builder(
            itemCount: documents.item.length,
            itemBuilder: (Context context, int index) {
              return _itemListView(
                  documents.item[index],
                  index
              );
            }
        )
      ]
    );
  }

   Future<Uint8List> create()async{
    try{
      // var imageProvider = AssetImage(MyImages.model);
      // final image = await flutterImageProvider(imageProvider);
      var myTheme = ThemeData.withFont(
        base: Font.ttf(await rootBundle.load("assets/fonts/NotoSans-Regular.ttf")),
        bold: Font.ttf(await rootBundle.load("assets/fonts/NotoSans-Bold.ttf")),
      );
      final _doc = Document(theme: myTheme);
      _doc.addPage(MultiPage(
        margin: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
        pageFormat: PdfPageFormat.a4,
          build: (Context context) {
            return [
              headerView(),
              Divider(
                color: PdfColor.fromHex('#E4E4E4'),
                thickness: 2,
                height: 30,
              ),
              _customerView(),
              _itemsView(),
              _totalView(),
              Divider(
                color: PdfColor.fromHex('#E4E4E4'),
                thickness: 2,
                height: 30,
              ),
              _signDocumentView()
            ];
          })); // Page
      return _doc.save();
    }catch(error){
      toastError('Error on generating pdf');
      print('Error on generating pdf ==> $error');
      return null;
    }
  }
}