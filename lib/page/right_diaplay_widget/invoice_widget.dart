import 'package:flutter/material.dart';
import 'package:my_billbook/list_widget/invoice_list_widget.dart';
import 'package:my_billbook/style/colors.dart';

class InvoiceWidget extends StatelessWidget {

  final String title;

  const InvoiceWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invoice',
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 30,bottom: 70),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: MyColors.boxShadow, blurRadius: 6)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Status',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Date',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'No.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Customer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Amount',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Divider(
                      color: MyColors.divider,
                      thickness: 1,
                      height: 1,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return InvoiceListWidget(index: index,);
                      },
                      itemCount: 50,
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
