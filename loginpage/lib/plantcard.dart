import 'package:flutter/material.dart';
import 'package:loginpage/plantdetail.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({super.key});

  @override
  Widget build(BuildContext context) {
    //  double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 230,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),

              child: InkWell(
                child: Image.asset('assets/images/img4.jpg'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Plantdetail()),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 170,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'SAMANTHA',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Spacer(),
                  Text('\$400', style: TextStyle(color: Colors.teal)),
                ],
              ),
              SizedBox(
                width: 170,
                child: Text(
                  'RUSSIA',
                  style: TextStyle(fontSize: 12, color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    //Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Container(
    //         //   margin: EdgeInsets.symmetric(),
    //         // width: width / 2,
    //         height: 200,
    //         child: Image.asset('assets/images/img4.jpg', fit: BoxFit.cover),
    //       ),
    //     ),
    //     // Container(
    //     //   margin: EdgeInsets.symmetric(),
    //     //   width: width / 2,
    //     //   height: 50,
    //     //   color: Colors.white,
    //     // ),
    //   ],
    // );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         //    appBar: AppBar(title: Text('CustomScrollView Example')),
//         body: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               expandedHeight: 200.0,
//               floating: false,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: Text('SliverAppBar'),
//                 background: Image.asset(
//                   'assets/images/img4.jpg',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate((
//                 BuildContext context,
//                 int index,
//               ) {
//                 return ListTile(title: Text('Item #$index'));
//               }, childCount: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
