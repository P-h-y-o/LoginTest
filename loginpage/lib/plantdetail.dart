import 'package:flutter/material.dart';

class Plantdetail extends StatefulWidget {
  const Plantdetail({super.key});

  @override
  State<Plantdetail> createState() => _PlantdetailState();
}

class _PlantdetailState extends State<Plantdetail> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          // Top area with image and icons
          Flexible(
            flex: 7,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: [
                      // Left Icon Buttons Column
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          width: width,
                          //   color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 150.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        offset: Offset(7, 7),
                                        color: const Color.fromARGB(
                                          227,
                                          198,
                                          231,
                                          207,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.wb_sunny_outlined,
                                      color: Colors.teal,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        offset: Offset(7, 7),
                                        color: const Color.fromARGB(
                                          227,
                                          198,
                                          231,
                                          207,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.water_drop_outlined),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        offset: Offset(7, 7),
                                        color: const Color.fromARGB(
                                          227,
                                          198,
                                          231,
                                          207,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.agriculture_outlined),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        offset: Offset(7, 7),
                                        color: const Color.fromARGB(
                                          227,
                                          198,
                                          231,
                                          207,
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.share_outlined),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Image area
                      Flexible(
                        flex: 3,
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            //  color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7,
                                spreadRadius: 7,
                                offset: Offset(7, 7),
                                color: const Color.fromARGB(225, 240, 244, 241),
                              ),
                            ],
                          ),
                          height: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              topLeft: Radius.circular(20),
                            ),
                            child: Image.asset(
                              'assets/images/img4.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),

                          //      child: const Center(child: Text("Plant Image")),
                        ),
                      ),
                    ],
                  ),
                ),
                //   SizedBox(height: 30),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,

                  // right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        // Spacer(),
                        Icon(Icons.more_horiz),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Name, origin, price
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: width / 2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          "Angelica",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width / 2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "RUSSIA",
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  width: width / 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 110, bottom: 40),
                    child: Text(
                      "\$440",
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom buttons
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },

                    child: Container(
                      height: height,
                      width: width / 2,
                      decoration: BoxDecoration(
                        color: selectedIndex == 0 ? Colors.teal : Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                            color: selectedIndex == 0
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },

                    child: Container(
                      height: height,
                      width: width / 2,
                      decoration: BoxDecoration(
                        color: selectedIndex == 1 ? Colors.teal : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Description',
                          style: TextStyle(
                            color: selectedIndex == 1
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
