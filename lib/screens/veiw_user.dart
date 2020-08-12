import 'package:flutter/material.dart';

class ViewUser extends StatefulWidget {
  @override
  _ViewUserState createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment:MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 110,
              child: CircleAvatar(radius: 50),
            ),
            SizedBox(height: 10),
            Text('sUFFERfOOLS'),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.update), Icon(Icons.drafts)]),
            Divider(),
            Text(
              'sjflasjflsdjfljsdfksjdfljsdlfjsdlfjsdlf',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Divider(),
            Row(children: [
              Text('Honor'),
              Flexible(child: Container(width: double.infinity)),
              CircleAvatar(radius: 10, child: Text('20'))
            ]),
            Flexible(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Text('Fxirst Book');
                  }),
            ),
            Divider(),
          ]),
    );
  }
}
