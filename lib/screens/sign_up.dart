import 'package:bool_chain_v2/data/users.dart';
import 'package:bool_chain_v2/services/firebase_auth_service.dart';
import 'package:bool_chain_v2/services/firestorage.dart';
import 'package:bool_chain_v2/services/geolocation_service.dart';
import 'package:bool_chain_v2/services/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bool_chain_v2/services/firestore.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final PageController _pageController = PageController();
  Users users = Users();
  GeoLocationService geoLocationService = GeoLocationService();
  String _password;
  String _address = "I don't know";
  TextEditingController emailInputController = TextEditingController();
  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else if (value == null) {
      return 'Email cannot be empty';
    } else {
      return null;
    }
  }

  bool _toggle = false;
  FireStorageService _storageService = FireStorageService();
  FirebaseAuthService _authService = FirebaseAuthService();
  FireStoreService _fireStoreService = FireStoreService();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageCapture>(
      create: (context) => ImageCapture(),
      child: SafeArea(
        child: Material(
            color: Theme.of(context).primaryColor,
            child: Consumer<ImageCapture>(builder: (context, image, child) {
              return Form(
                key: _formKey,
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ListView(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Book_Chain',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              inherit: false,
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            icon: const Icon(Icons.title),
                            hintText: 'Name',
                            labelText: ' Name',
                          ),
                          onSaved: (value) => users.userName = value,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100)
                          ],
                          validator: (val) =>
                              val.isEmpty ? 'Name is required' : null,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.email),
                            hintText: 'Email',
                            labelText: 'Email',
                          ),
                          controller: emailInputController,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) => users.userEmail = value,
                          validator: emailValidator,
                        ),
                        TextFormField(
                          textAlign: TextAlign.justify,
                          maxLines: 1,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            icon: Icon(Icons.visibility_off),
                            hintText: 'Password',
                            labelText: 'Password',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30)
                          ],
                          onSaved: (value) => _password = value,
                        ),
                        TextFormField(
                            textAlign: TextAlign.justify,
                            maxLines: 1,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              icon: Icon(Icons.visibility_off),
                              hintText: 'Confirm Password',
                              labelText: 'Confirm Password',
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30)
                            ],
                            onSaved: (value) {
                              print(value);
                            },
                            validator: (val) {
                              String msg;
                              if (val != _password) {
                                msg = 'Password do not match';
                              } else if (val.length <= 7)
                                msg =
                                    "Password must be longer than 7 character";
                              else
                                msg = null;
                              return msg;
                            }),
                        Container(
                          alignment: Alignment.centerRight,
                          child: MaterialButton(
                              child: Icon(Icons.arrow_forward),
                              onPressed: () {
                                _formKey.currentState.save();
                                if (_formKey.currentState.validate()) {
                                  _pageController.animateToPage(1,
                                      duration: Duration(milliseconds: 100),
                                      curve: Curves.bounceIn);
                                  print('nani');
                                }
                              }),
                        ),
                      ],
                    ),
                    ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        if (image.imageFile == null) ...[
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 140,
                                  ),
                                ),
                                Positioned(
                                  bottom: 2,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.add_a_photo),
                                    onPressed: () async {
                                      await image
                                          .pickImage(ImageSource.gallery);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                        if (image.imageFile != null) ...[
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  child: CircleAvatar(
                                    radius: 65,
                                    backgroundImage: FileImage(image.imageFile),
                                  ),
                                ),
                                Positioned(
                                  bottom: 2,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.add_a_photo),
                                    onPressed: () async {
                                      await image
                                          .pickImage(ImageSource.gallery);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          textAlign: TextAlign.justify,
                          maxLines: null,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Short Description',
                            labelText: 'About User',
                          ),
                          onSaved: (value) => users.userBio = value,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(500)
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Text(
                          'Address: $_address',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            child: Center(
                                child: Container(
                                    width: 200,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        )),
                                    child: Center(
                                        child: Text(
                                      'Get Location',
                                      textAlign: TextAlign.center,
                                    )))),
                            onTap: () async {
                              Position position =
                                  await geoLocationService.getLocation();
                              users.position = position;
                              users.userAddress =
                                  await geoLocationService.getAddress(position);
                              setState(() {
                                _address = users.userAddress;
                              });
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: _toggle,
                                onChanged: (value) {
                                  setState(() {
                                    _toggle = !_toggle;
                                  });
                                }),
                            Expanded(
                              child: Text(
                                'I acccept the terms and conditions of BookChain',
                                strutStyle: StrutStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                              child: Text('Register'),
                              onPressed: () async {
                                _formKey.currentState.save();
                                if (users.userAddress == null) {
                                  setState(() {
                                    _address = "We need your address";
                                  });
                                } else if (_toggle == false) {
                                  // print("dame");
                                } else {
                                  users.userId = await _authService.signUp(
                                      users.userEmail, _password);
                                  await _authService.sendEmailVerification();
                                }
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              );
            })),
      ),
    );
  }
}
