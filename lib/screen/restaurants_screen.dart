import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/parse_data.dart';

import '../data/restaurant.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);

  static final String routeName = '/restaurants';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/data/data_restaurant.json'),
        builder: (context, snapshot) {
          List<Restaurant> dataRestaurant =
              ParseData.parseRestaurants(snapshot.data);

          return SingleChildScrollView(
            child: Column(
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
                  itemCount: dataRestaurant.length,
                  itemBuilder: (context, index) {
                    return Container();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
