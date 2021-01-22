import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/send_email_dialog.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/methods.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
// import 'dart:html' as html;



class PreviewDialog extends StatelessWidget {
  final Uint8List uint8list;
  final String billName;
  final String invoiceNumber;

  PreviewDialog({Key key, this.uint8list,this.billName,this.invoiceNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 700,
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
              child: SingleChildScrollView(
                child: Text(
                  'Preview',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Flexible(
              child: PdfPreview(
                build: (PdfPageFormat format) {
                return uint8list;
              },),
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
                    onSendTap(context);
                  },
                  child: Text('Send'),
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
  void onSendTap(BuildContext context) async{
    // final blob =  html.Blob([uint8list],'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // html.window.open(url, "_blank");
    // html.Url.revokeObjectUrl(url);
    // showProgress(context);
    final _fileName = '$billName#$invoiceNumber.pdf';
    // var _result = await FirebaseService.uploadPdf(uint8list,_fileName);
    // if(_result != null){
    //   print('pdf link ===> $_result}');
    // }
    Navigator.pop(context,_fileName);
  }
}
