
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/pdf/pdf_creator.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';


class PreviewDialog extends StatelessWidget {
  final _scrollController = ScrollController();
  final Uint8List uint8list;

  PreviewDialog({Key key, this.uint8list}) : super(key: key);

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
                controller: _scrollController,
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
  void onSaveTap(BuildContext context) {}
}
