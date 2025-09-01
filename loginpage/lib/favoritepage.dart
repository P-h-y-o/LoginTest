import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loginpage/product_model.dart';
import 'package:loginpage/user_model.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({
    super.key,
    required List favoriteProducts,
    //  required Box<Product> favoriteBox,
  });

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box<UserModel>('userBox');
    final currentUser = userBox.get('currentuser');
    final favoritesBox = Hive.box<Product>('favorite_${currentUser!.id}');
    final userFavorites = favoritesBox.values.toList();
    if (userFavorites.isEmpty) {
      return const Center(child: Text("No favorites yet."));
    }
    return ListView(
      children: userFavorites.map((product) {
        return ListTile(
          leading: Image.network(product.image, width: 50, height: 50),
          title: Text(product.title),
          subtitle: Text(product.description),
        );
      }).toList(),
    );
  }
}
