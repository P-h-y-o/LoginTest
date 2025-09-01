import 'package:flutter/material.dart';
import 'package:loginpage/plantcard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Row(
            children: [
              SliverAppBar(
                leading: Icon(Icons.menu),
                pinned: true,
                expandedHeight: 250,
                backgroundColor: Colors.teal,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Hi Uishopy!',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),

                  background: CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage('assets/images/img5.jpg'),
                  ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                // Search Field
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 16,
                  ),
                  height: 60,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                // Recommended Section
                sectionTitle('Recommended', () {}),
                plantListView(),

                // Featured Section
                sectionTitle('Featured Plants', () {}),
                plantListView(height: 320),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title, VoidCallback onMorePressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            onPressed: onMorePressed,
            child: const Text('More', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget plantListView({double height = 300}) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return PlantCard();
        },
      ),
    );
  }
}
