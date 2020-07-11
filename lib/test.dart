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
