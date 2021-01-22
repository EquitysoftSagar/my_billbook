import 'package:flutter/material.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/send_email_text_field.dart';

class SendEmailDialog extends StatelessWidget {
  final String fileName;
  final String recipientEmail;
  final _recipientController = TextEditingController();
  final _messageController = TextEditingController();

  SendEmailDialog({Key key, this.fileName,this.recipientEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _recipientController.text = recipientEmail;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 400,
        padding: EdgeInsets.only(
          bottom: 15,
        ),
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
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Send',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(fileName,
                      style: TextStyle(
                          color: MyColors.text,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 20,
                  ),
                  SendEmailTextField(
                    labelText: 'Recipient',
                    controller: _recipientController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SendEmailTextField(
                    labelText: 'Message',
                    controller: _messageController,
                  ),
                ],
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
  void onSendTap(BuildContext context) {

  }
}
