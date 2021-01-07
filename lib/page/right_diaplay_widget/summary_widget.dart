import 'package:flutter/material.dart';
import 'package:my_billbook/style/colors.dart';

class SummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: TextStyle(
                color: MyColors.invoiceTxt,
                fontWeight: FontWeight.w700,
                fontSize: 25.0),
          ),
          /* Flexible(
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
                        Text(
                          'Customer',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                        ),
                        Spacer(),
                        Text(
                          'Actions',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
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
            )*/
        ],
      ),
    );
  }
}
