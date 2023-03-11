import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/data/restaurant_response.dart';
import 'package:restaurant_app/utils/parse_data.dart';

import '../data/restaurant.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);

  static final String routeName = '/restaurants';

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
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Restaurant'),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text('Recommendation restaurant for you!'),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dataRestaurant.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 280,
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
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
                                      Text(dataRestaurant[index].name ?? ''),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Icon(Icons.location_city),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                              dataRestaurant[index].city ?? ''),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
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
