import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/menu_card.dart';
import 'package:restaurant_app/widget/rating.dart';

import '../data/model/restaurant_detail.dart';
import '../style/theme.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  static const String routeName = '/restaurant-detail';

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final dataRestaurant =
        ModalRoute.of(context)!.settings.arguments as Restaurant;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: FutureBuilder(
          future: context
              .read<RestaurantProvider>()
              .getDetailRestaurant(dataRestaurant.id),
          builder: (ctx, snapshot) {
            return Consumer<RestaurantProvider>(builder: (ctx, state, _) {
              if (state.resultStateDetailRestaurant == ResultState.error) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state.resultStateDetailRestaurant ==
                  ResultState.success) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: 300,
                        child: Image.network(
                          state.restaurantDetail.pictureId != null
                              ? 'https://restaurant-api.dicoding.dev/images/small/${state.restaurantDetail.pictureId}'
                              : '',
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
                              state.restaurantDetail.name ?? '',
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
                                  state.restaurantDetail.city ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color: colorGrey,
                                      ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Rating(
                              rating: state.restaurantDetail.rating,
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
                              state.restaurantDetail.description ?? '',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Menu',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 150,
                              child:
                                  MenuCard(menus: state.restaurantDetail.menus),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
          },
        ),
      ),
    );
  }
}
