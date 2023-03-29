import 'package:flutter/material.dart';

import '../data/model/restaurant_detail.dart';
import '../style/theme.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  static const String routeName = '/restaurant-detail';

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  Widget listMenu(RestaurantDetail restaurant) {
    List<String> allMenus = [];

    var foods =
        restaurant.menus?.foods?.map((food) => 'Makanan:\n\n${food.name}');
    var drinks =
        restaurant.menus?.drinks?.map((drink) => 'Minuman:\n\n${drink.name}');
    allMenus.addAll(foods!);
    allMenus.addAll(drinks!);

    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: allMenus.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(10),
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              color: colorLightGrey,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              allMenus[index],
              style: Theme.of(context).textTheme.bodyText2,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final dataRestaurant =
        ModalRoute.of(context)!.settings.arguments as RestaurantDetail;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                child: Image.network(
                  dataRestaurant.pictureId ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataRestaurant.name ?? '',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.location_city,
                          color: colorGrey,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          dataRestaurant.city ?? '',
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: colorGrey,
                                  ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.star,
                          color: colorYellow,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          dataRestaurant.rating.toString(),
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: colorGrey,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      dataRestaurant.description ?? '',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Menu',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      height: 130,
                      child: listMenu(dataRestaurant),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
