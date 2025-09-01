import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loginpage/apiservice.dart';
import 'package:loginpage/favoritepage.dart';
import 'package:loginpage/product_model.dart';
import 'package:loginpage/profile.dart';
import 'package:loginpage/shimmer_page.dart';
import 'package:loginpage/user_model.dart';
import 'package:loginpage/user_singleton.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  String? _errorMessage;
  late Box<UserModel> userBox;
  late Box<Product> favoriteBox;
  bool _isLoading = true;
  // bool _hasError = false;
  var _products = [];

  @override
  void initState() {
    super.initState();
    userBox = Hive.box<UserModel>('userBox');
    final currentUser = userBox.get('currentuser');
    favoriteBox = Hive.box<Product>('favorite_${currentUser!.id}');
    fetchPersonalData();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            Center(
              child: TextButton(
                child: Text('Retry'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchProductsList() async {
    setState(() {
      _isLoading = true;
      //   _errorMessage = null;
    });
    final response = await Apiservice.getProducts();

    print("ProductData ${response.data}");
    if (response.data != null) {
      setState(() {
        _products = response.data!;
        _errorMessage = null;
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = response.errorMessage;
        _isLoading = false;
      });
      print("Loaded products: ${response.errorMessage}");

      print("Loaded produccts: ${response.data}");
    }
  }

  Future<void> fetchPersonalData() async {
    setState(() {
      _isLoading = false;
      _errorMessage = null;
    });

    final user = CurrentUserSingleton().currentuser;
    if (user == null || user.accessToken.isEmpty) {
      _showErrorDialog('user not login');
      return;
    }

    //  try {
    final result = await Apiservice.personalData(user.accessToken);

    // success
    if (result.errorMessage == null) {
      final personaldata = result.data!;
      CurrentUserSingleton().setPersonaldata(personaldata);
    } else {
      _errorMessage = result.errorMessage;
      print(_errorMessage);
    }
    await fetchProductsList();
    setState(() {
      _isLoading = false;
    });

    // _products = await Apiservice.fetchProducts();

    // print('product$_products');
    // setState(() {
    //   _products;
    //   _isLoading = false;
    // });
    //   } catch (e) {

    //     //   e.toString;
    //     //   setState(() {
    //     //     _errorMessage = e.toString();
    //     //     _isLoading = false;
    //     //   });
    //     // }
    //     final box = Hive.box<Product>('products');
    //     final cached = box.values.toList();

    //     if (cached.isNotEmpty) {
    //       setState(() {
    //         _products = cached;
    //         _isLoading = false;
    //         _hasError = true;
    //         _errorMessage = 'No internet — showing offline products.';
    //       });
    //     } else {
    //       setState(() {
    //         _isLoading = false;
    //         _hasError = true;
    //         _errorMessage = 'No internet connection. Try again.';
    //       });
    //     }
    //   }
  }

  Widget _buildProductCard(Product product) {
    bool isFavorite = favoriteBox.values.any((item) => item.id == product.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              height: 150,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      product.image,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Text(
                              maxLines: 3,
                              product.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 4,
            right: 4,
            child: Container(
              decoration: BoxDecoration(),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () async {
                  final currentUser = Hive.box<UserModel>(
                    'userBox',
                  ).get('currentuser');
                  final favoritesBox = Hive.box<Product>(
                    'favorite_${currentUser!.id}',
                  );

                  final alreadyFavorite = favoritesBox.values.any(
                    (item) => item.id == product.id,
                  );

                  if (alreadyFavorite) {
                    final key = favoritesBox.keys.firstWhere(
                      (k) => favoritesBox.get(k)!.id == product.id,
                    );
                    await favoritesBox.delete(key);
                  } else {
                    await favoritesBox.add(product);
                  }
                  // if (alreadyFavorite) {
                  //   final key = box.keys.firstWhere(
                  //     (k) => box.get(k)!.id == product.id,
                  //   );
                  //   await box.delete(key);
                  // } else {
                  //   await box.add(product);
                  // }
                  setState(() {});
                },
                iconSize: 20,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    if (_isLoading) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ShimmerCard(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await fetchProductsList();
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    if (_products.isEmpty) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ShimmerCard(),
      );
      // return const Center(child: CircularProgressIndicator());
    }
    // SingleChildScrollView(
    //   child: Column(
    //     children: _products
    //         .map((product) => _buildProductCard(product))
    //         .toList(),
    //   ),
    // );

    return RefreshIndicator(
      onRefresh: fetchProductsList,

      child: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return _buildProductCard(product);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Product List'),
        // actions: [
        //   ElevatedButton(
        //     onPressed: () async {
        //       await Hive.box<UserModel>('userBox').delete('currentuser');
        //       Navigator.pushNamed(context, '/login');
        //     },
        //     child: Text('Logout'),
        //   ),
        // ],
      ),

      body: IndexedStack(
        index: pageIndex,
        children: [
          _buildHomeScreen(),
          FavoritePage(favoriteProducts: []),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //  backgroundColor: Colors.teal,
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline, color: Colors.black),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, color: Colors.black),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
