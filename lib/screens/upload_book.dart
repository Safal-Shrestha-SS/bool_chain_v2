import 'package:bool_chain_v2/services/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadBook extends StatefulWidget {
  @override
  _UploadBookState createState() => _UploadBookState();
}

class _UploadBookState extends State<UploadBook> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _colors = <String>[
    'Action and Adventure',
    'Anthology',
    'Biography/Autobiography',
    'Classic',
    'Comic and Graphic Novel',
    'Crime and Detective',
    'Drama',
    'Essay',
    'Fan-fiction',
    'Fable',
    'Fantasy',
    'Historical Fiction',
    'Horror',
    'Humor',
    'Legend',
    'Magical Realism',
    'Memoir',
    'Mystery',
    'Mythology',
    'Narrative Nonfictio',
    'Periodicals',
    'Realistic Fiction',
    'Reference Books',
    'Romance',
    'Satire',
    'Science Fiction',
    'Self-help',
    'Short Story',
    'Speech',
    'Suspence/Thriller',
    'Textbook',
    'Poetry'
  ];
  List<String> _selected = [];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageCapture>(
      create: (context) => ImageCapture(),
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Upload Book'),
        ),
        body: SafeArea(
            top: false,
            bottom: false,
            child: Consumer<ImageCapture>(builder: (context, image, child) {
              return Form(
                key: _formKey,
                autovalidate: true,
                child: Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      children: <Widget>[
                        if (image.imageFile != null) ...[
                          Image.file(image.imageFile),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.crop),
                                  onPressed: () async {
                                    await image.cropImage();
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.refresh),
                                  onPressed: () {
                                    image.clear();
                                  },
                                ),
                              ])
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.photo_camera),
                              onPressed: () {
                                image.pickImage(ImageSource.camera);
                              }, // image.pickImage(ImageSource.camera),
                            ),
                            IconButton(
                              icon: Icon(Icons.photo_library),
                              onPressed: () async {
                                await image.pickImage(ImageSource.gallery);
                              },
                            )
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.book),
                            hintText: 'Book Nitle',
                            labelText: 'Book Name',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100)
                          ],
                          validator: (val) =>
                              val.isEmpty ? 'Name is required' : null,
                        ),
                        new TextFormField(
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.person),
                            hintText: 'Author name',
                            labelText: 'Author Name',
                          ),
                        ),
                        TextFormField(
                          maxLines: 5,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.person),
                            hintText: 'Short Description',
                            labelText: 'About Book',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(500)
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(child: Text('Genres')),
                        Wrap(
                          spacing: 8.0, // gap between adjacent chips
                          runSpacing: 4.0, // gap between lines
                          children: <Widget>[
                            for (var ip in _selected)
                              Container(
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('  $ip  '),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selected.remove(ip);
                                            });
                                          },
                                          child: Icon(Icons.clear, size: 15)),
                                    ]),
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: PopupMenuButton(
                                  icon: Icon(Icons.add, size: 30),
                                  padding: EdgeInsets.all(0),
                                  onSelected: (String value) {
                                    setState(() {
                                      if (!_selected.contains(value)) {
                                        _selected.add(value);
                                      }
                                    });
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return _colors.map((String choice) {
                                      return PopupMenuItem(
                                        value: choice,
                                        child: Text(choice,
                                            style:
                                                TextStyle(color: Colors.black)),
                                      );
                                    }).toList();
                                  }),
                            ),
                            GestureDetector(
                                child: Icon(Icons.clear),
                                onTap: () {
                                  _selected.clear();
                                  setState(() {});
                                }),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                          child: new RaisedButton(
                              child: const Text('Submit'),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  // Process data.
                                }
                              }),
                        ),
                      ],
                    ),
                    ((image.inProgress)
                        ? Container(
                            color: Colors.white,
                            height: double.infinity,
                            width: double.infinity,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Center())
                  ],
                ),
              );
            })),
      ),
    );
  }
}
