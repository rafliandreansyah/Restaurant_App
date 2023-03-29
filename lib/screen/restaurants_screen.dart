import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screen/restaurant_detail_screen.dart';
import 'package:restaurant_app/widget/restaurant_card.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);

  static const String routeName = '/restaurants';

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: context.read<RestaurantProvider>().getListRestaurant(),
        builder: (context, snapshot) {
          return SafeArea(
            child: Consumer<RestaurantProvider>(builder: (ctx, state, _) {
              if (state.resultState == ResultState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.resultState == ResultState.noData) {
                return const Center(
                  child: Text('List Restaurant is Empty'),
                );
              } else if (state.resultState == ResultState.error) {
                return Center(
                  child: Text('Error :${state.message}'),
                );
              } else if (state.resultState == ResultState.success) {
                return SingleChildScrollView(
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
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black87,
                                  ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Recommendation restaurant for you!',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.listRestaurant.length,
                          itemBuilder: (context, index) {
                            return RestaurantCard(
                              restaurant: state.listRestaurant[index],
                              onClick: () => Navigator.pushNamed(
                                context,
                                RestaurantDetailScreen.routeName,
                                arguments: state.listRestaurant,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          );
        },
      ),
    );
  }
}
