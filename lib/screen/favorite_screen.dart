import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  static const String routeName = '/favorite';
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Favorite Screen'),
    );
  }
}
