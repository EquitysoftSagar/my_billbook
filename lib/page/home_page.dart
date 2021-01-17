import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:provider/provider.dart';

import 'home_page_widget/drawer_widget.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    FirebaseService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
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
      body: ChangeNotifierProvider(
        create: (BuildContext context) => HomePageProvider(),
        child: Center(
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
      ),
    );
  }
}
