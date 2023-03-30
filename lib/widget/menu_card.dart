import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/menus.dart';

import '../style/theme.dart';

class MenuCard extends StatelessWidget {
  final Menus? menus;
  final List<String> _allMenus = [];
  MenuCard({super.key, required this.menus}) {
    var foods = menus?.foods.map((food) => food.name);
    var drinks = menus?.drinks.map((drink) => drink.name);
    _allMenus.addAll(foods!);
    _allMenus.addAll(drinks!);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _allMenus.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(10),
            width: 100,
            decoration: BoxDecoration(
              color: colorLightGrey,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/images/food_place_holder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _allMenus[index],
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          );
        });
  }
}
