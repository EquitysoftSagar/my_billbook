import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/model/user.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:provider/provider.dart';
import 'home_page_widget/drawer_widget.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return/*FutureBuilder(
      future: FirebaseService.getUserDetails(),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }else{
          userModel = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('MyBillBook'),
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              actions: [
                IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                SizedBox(width: 20,)
              ],
            ),
            body: Center(
              child: Row(
                children: [
                  SizedBox(
                      width: 200,
                      child: DrawerWidget()),
                  Consumer<HomePageProvider>(
                    builder: (BuildContext context, provider, Widget child) {
                      return Expanded(
                          child: provider.rideSideWidget
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }
      },
    );*/
      Scaffold(
        appBar: AppBar(
          title: Text('MyBillBook'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                onPressed: () {}),
            SizedBox(width: 20,)
          ],
        ),
        body: Center(
          child: Row(
            children: [
              SizedBox(
                  width: 200,
                  child: DrawerWidget()),
              Consumer<HomePageProvider>(
                builder: (BuildContext context, provider, Widget child) {
                  return Expanded(
                      child: provider.rideSideWidget
                  );
                },
              )
            ],
          ),
        ),
      );
  }
}
