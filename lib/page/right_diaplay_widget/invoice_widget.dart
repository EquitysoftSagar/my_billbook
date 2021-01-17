import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/item_view_widget/invoice_list_item_view_widget.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/model/document.dart';
import 'package:my_billbook/page/right_diaplay_widget/add_invoice_widget.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/search_text_field.dart';
import 'package:provider/provider.dart';

class InvoiceWidget extends StatelessWidget {

  final Bills bills;
  final String id;
  final _searchController = TextEditingController();

  InvoiceWidget({Key key, this.bills,this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<HomePageProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _provider.isInvoiceWidget = true;
          _provider.rideSideWidget = AddInvoiceWidget(
            id: id,
            bills: bills,
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  bills.name,
                  style: TextStyle(
                      color: MyColors.invoiceTxt,
                      fontWeight: FontWeight.w700,
                      fontSize: 25.0),
                ),
                SearchTextField(
                  controller: _searchController,
                )
              ],
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
                    StreamBuilder(
                      stream: FirebaseService.getDocuments(id),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(snapshot.data.docs.length == 0){
                          return Text(
                            'No Document',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0),
                          );
                        }else{
                          return Flexible(
                              child: ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return InvoiceListItemViewWidget(
                                    index: index,
                                    documents:Documents.fromJson( snapshot.data.docs[index].data())
                                  );
                                },
                                itemCount: snapshot.data.docs.length,
                              ));
                        }
                      },),
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
