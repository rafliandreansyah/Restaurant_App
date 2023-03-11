import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/data/restaurant_response.dart';
import 'package:restaurant_app/screen/restaurant_detail_screen.dart';
import 'package:restaurant_app/style/theme.dart';

import '../data/restaurant.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);

  static const String routeName = '/restaurants';

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  Future<List<Restaurant>> getRestaurants() async {
    final data =
        await rootBundle.loadString('assets/data/data_restaurant.json');
    //print(data);
    var jsonData = json.decode(data);
    //print(jsonData);
    final body = Restaurants.fromJson(jsonData);
    print(body.restaurants);

    return body.restaurants as List<Restaurant>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Restaurant>>(
        future: getRestaurants(),
        builder: (context, snapshot) {
          List<Restaurant> dataRestaurant = snapshot.data ?? [];

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Restaurant',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black87,
                          ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Recommendation restaurant for you!',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dataRestaurant.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RestaurantDetailScreen.routeName,
                                arguments: dataRestaurant[index]);
                          },
                          child: SizedBox(
                            height: 300,
                            child: Card(
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(21),
                                        topRight: Radius.circular(21),
                                      ),
                                      child: Image.network(
                                        dataRestaurant[index].pictureId ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dataRestaurant[index].name ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                          maxLines: 2,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Icon(
                                              Icons.location_city,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              dataRestaurant[index].city ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: colorYellow,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              dataRestaurant[index]
                                                  .rating
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
