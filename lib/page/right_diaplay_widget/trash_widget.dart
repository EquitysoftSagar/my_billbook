import 'package:flutter/material.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:provider/provider.dart';

class TrashWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // final _provider = Provider.of<HomePageProvider>(context);
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trash',
            style: TextStyle(
                color: MyColors.invoiceTxt,
                fontWeight: FontWeight.w700,
                fontSize: 25.0),
          ),
          Flexible(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 30),
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
                      SizedBox(width: 10,),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Date',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontWeight: FontWeight.w600,
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
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Customer',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Amount',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Action',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                        ),
                      ),
                      SizedBox(width: 10,),
                    ],
                  ),
                  Divider(
                    color: MyColors.divider,
                    thickness: 1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
