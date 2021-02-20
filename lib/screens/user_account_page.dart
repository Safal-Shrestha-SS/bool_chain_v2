import 'package:flutter/material.dart';

class UserAccountPage extends StatefulWidget {
  @override
  _UserAccountPageState createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  TextEditingController _editingController;
  String initialText = "Initial Text";

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              child: Stack(children: [
                CircleAvatar(radius: 50),
                Positioned(right: 10, top: 10, child: Icon(Icons.edit)),
              ]),
            ),
            SizedBox(height: 10),
            Text('sUFFERfOOLS'),
            Divider(),
            TextField(
                controller: _editingController,
                style: TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
                onTap: () {}),
            Divider(),
            ListTile(
              title: Text('Honor'),
              trailing: CircleAvatar(radius: 10, child: Text('20')),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('First Book'),
                    );
                  }),
            ),
            ListTile(
              title: Text('One-line with trailing widget'),
              trailing: Icon(Icons.edit_location),
            ),
            FlatButton.icon(
                onPressed: null,
                icon: Icon(Icons.edit_location),
                label: Text('Update Location'))
          ]),
    );
  }
}
