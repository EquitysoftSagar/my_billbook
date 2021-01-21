import 'dart:typed_data';

import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/methods.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MyPdf{
  static pw.Widget headerView(String billName){
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // pw.Image(imageProvider,height: 250,width: 250,fit: pw.BoxFit.fill,),
        pw.Text(userModel.companyInformation.companyName
            , style: pw.TextStyle(color: PdfColor.fromHex('#000000'),fontSize: 22,fontWeight: pw.FontWeight.normal)),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Text(billName
                , style: pw.TextStyle(color: PdfColor.fromHex('#000000'),fontSize: 20,fontWeight: pw.FontWeight.normal)),pw.SizedBox(height: 8,),
            pw.Text(userModel.companyInformation.companyName
                ,style: pw.TextStyle(color: PdfColor.fromHex('#000000'),fontSize: 13,fontWeight: pw.FontWeight.bold)
            ),pw.SizedBox(height: 5,),
            pw.Text(userModel.companyInformation.emailOnInvoice
                ,style: pw.TextStyle(color: PdfColor.fromHex('#000000'),fontSize: 10,fontWeight: pw.FontWeight.normal)
            ),pw.SizedBox(height: 5,),
          ],
        )
      ],
    );
  }
  static pw.Widget view(String billName){
    return pw.Container(
      child: pw.Column(
        children: [
          headerView(billName),
          pw.Divider(
            color: PdfColor.fromHex('#5c5858'),
            thickness: 2,
            height: 40,
          ),
        ],
      ),
    );
  }

  static Future<Uint8List> create(String billName)async{
    try{
      // var imageProvider = AssetImage(MyImages.model);
      // final image = await flutterImageProvider(imageProvider);
      final _doc = pw.Document();

      _doc.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return [
              view(billName),
            ];
          })); // Page

      toastSuccess('pdf generated');
      return _doc.save();
    }catch(error){
      toastError('Error on generating pdf');
      print('Error on generating pdf ==> $error');
      return null;
    }
  }
}