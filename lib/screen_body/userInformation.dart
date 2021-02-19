// import 'package:bool_chain_v2/services/firebase_auth_service.dart';
// import 'package:bool_chain_v2/services/firestorage.dart';
// import 'package:bool_chain_v2/services/image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'navigation_sidebar.dart';
// import 'package:geolocator/geolocator.dart';

final _firestore = Firestore.instance;

class UserInformation extends StatefulWidget {
  UserInformation(userUID);

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("User Information"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
            stream:
                _firestore.collection("users").document(userUID).snapshots(),

            // ignore: missing_return
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              GeoPoint position = snapshot.data["userGeoCode"];
              return Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircleAvatar(
                        radius: 95,
                        backgroundColor: Colors.blue,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage("${snapshot.data["image"]}"),
                          radius: 90,
                          backgroundColor: Colors.transparent,
                        ),
                      )),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text("User Name"),
                          subtitle: Text("${snapshot.data['userName']}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.volume_up),
                          title: Text('User Bio'),
                          subtitle: Text("${snapshot.data['userBio']}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.location_searching),
                          title: Text('User Location'),
                          subtitle: Text("${snapshot.data['userAddress']}"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text('User GeoCode'),
                          subtitle: Text(
                              "${position.latitude},${position.longitude}"),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
