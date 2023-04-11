import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/enum/result_state.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/screen/restaurant_detail_screen.dart';
import 'package:restaurant_app/widget/restaurant_card.dart';

import '../utils/navigation.dart';

class FavoriteScreen extends StatefulWidget {
  static const String routeName = '/favorite';

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: context.read<FavoriteProvider>().getAllFavorite(),
          builder: (context, snapshot) {
            return Consumer<FavoriteProvider>(
                builder: (context, favoriteState, _) {
              if (favoriteState.allFavoriteResult == ResultState.error) {
                return Center(
                  child: Text(
                    favoriteState.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                );
              } else if (favoriteState.allFavoriteResult ==
                  ResultState.noData) {
                return Center(
                  child: Text(
                    'Favorite is empty',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                );
              } else if (favoriteState.allFavoriteResult ==
                  ResultState.success) {
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
                          'Favorite Restaurant',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black87,
                                  ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Favorite restaurant do you want!',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: favoriteState.allFavoriteRestaurant.length,
                          itemBuilder: (ctx, index) {
                            return RestaurantCard(
                              restaurant:
                                  favoriteState.allFavoriteRestaurant[index],
                              onClick: () => Navigation.intentWithData(
                                RestaurantDetailScreen.routeName,
                                favoriteState.allFavoriteRestaurant[index],
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
            });
          }),
    );
  }
}
