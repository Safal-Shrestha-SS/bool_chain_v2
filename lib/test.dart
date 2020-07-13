import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Form Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Upload Books'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
  String _color = '';
  List<String> _selected = [];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.book),
                      hintText: 'Book Nitle',
                      labelText: 'Book Name',
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(100)],
                    validator: (val) => val.isEmpty ? 'Name is required' : null,
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
                    inputFormatters: [LengthLimitingTextInputFormatter(500)],
                  ),
                  SizedBox(height: 10),
                  Container(child: Text('Genres')),
                  Container(
                    width: 200,
                    height: 400,
                    color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.grey,
                            height: 60,
                            child: GridView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: _selected.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 0.0,
                                        mainAxisSpacing: 0.0),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 50,
                                    color: Colors.amber[index],
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Row(children: [
                                          Text('  ${_selected[index]}  '),
                                          GestureDetector(
                                              onTap: () {
                                                _selected
                                                    .remove(_selected[index]);
                                                setState(() {});
                                              },
                                              child:
                                                  Icon(Icons.clear, size: 15)),
                                        ]),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _selected.clear();
                              setState(() {});
                            }),
                        Container(
                          width: 20,
                          child: PopupMenuButton(
                              icon: Icon(Icons.add),
                              padding: EdgeInsets.all(0),
                              onSelected: (String value) {
                                setState(() {
                                  if (!_color.contains(value)) {
                                    _selected.add(value);
                                  }
                                  _color = value;
                                  // state.didChange(newValue);
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return _colors.map((String choice) {
                                  return PopupMenuItem(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              }),
                        ),
                      ],
                    ),
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
              ))),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: MyWidget(),
//     ),
//   );
// }

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(children: <Widget>[
//       Expanded(
//         child: Container(
//           height: 500,
//           child: CustomScrollView(
//             slivers: <Widget>[
//               const SliverAppBar(
//                 pinned: true,
//                 expandedHeight: 250.0,
//                 flexibleSpace: FlexibleSpaceBar(
//                   title: Text('Demo'),
//                 ),
//               ),
//               SliverGrid(
//                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                   maxCrossAxisExtent: 200.0,
//                   mainAxisSpacing: 10.0,
//                   crossAxisSpacing: 10.0,
//                   childAspectRatio: 4.0,
//                 ),
//                 delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                     return Container(
//                       alignment: Alignment.center,
//                       color: Colors.teal[100 * (index % 9)],
//                       child: Text('Grid Item $index'),
//                     );
//                   },
//                   childCount: 20,
//                 ),
//               ),
//               SliverFixedExtentList(
//                 itemExtent: 20.0,
//                 delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 20,
//                       itemBuilder: (BuildContext ctxt, int index) {
//                         return new Text('litems $index');
//                       },
//                     );
//                   },
//                   childCount: 2,
//                 ),
//               ),
//               SliverGrid(
//                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                   maxCrossAxisExtent: 200.0,
//                   mainAxisSpacing: 10.0,
//                   crossAxisSpacing: 10.0,
//                   childAspectRatio: 4.0,
//                 ),
//                 delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                     return Container(
//                       alignment: Alignment.center,
//                       color: Colors.teal[100 * (index % 9)],
//                       child: Text('Grid Item $index'),
//                     );
//                   },
//                   childCount: 20,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//                Container(
//                  height:200,child: SingleChildScrollView(
//                       child: Column(children:[
//             Container(
//               height:50,
//               child: Text('hel'),
//             ),
//             Container(
//               height:50,
//               child: Text('hell'),
//             ),
//             Container(
//               height:50,
//               child: Text('hello'),
//             ),
//              Container(
//               height:50,
//               child: Text('hello'),
//             ),
//              Container(
//               height:50,
//               child: Text('hello'),
//             ),
//              Container(
//               height:50,
//               child: Text('hello'),
//             ),
//              Container(
//               height:50,
//               child: Text('hello'),
//             ),
//              Container(
//               height:50,
//               child: Text('hello'),
//             ),
//              Container(
//               height:50,
//               child: Text('hello'),
//             ),
//              Container(
//               height:50,
//               child: Text('hello'),
//             ),
//              Container(
//               height:50,
//               child: Text('hell'),
//             ),
//              Container(
//               height:50,
//               child: Text('hello'),
//             ),
//           ],
//         ),
//     )
//     ]));
//   }
// }
