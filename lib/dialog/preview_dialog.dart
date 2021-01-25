import 'dart:typed_data';

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/style/colors.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;



class PreviewDialog extends StatelessWidget {
  final Uint8List uint8list;
  final String billName;
  final String invoiceNumber;

  PreviewDialog({Key key, this.uint8list,this.billName,this.invoiceNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blob =  html.Blob([uint8list],'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
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
              child: /*PdfPreview(
                build: (PdfPageFormat format) {
                return uint8list;
              },),*/
              EasyWebView(
                src: url,
                onLoaded: () { }, // Try to convert to flutter widgets
                // width: 100,
                // height: 100,
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

    final _fileName = '$billName#$invoiceNumber.pdf';
    Navigator.pop(context,_fileName);
  }
}
