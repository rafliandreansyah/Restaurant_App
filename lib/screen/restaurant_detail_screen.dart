import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widget/menu_card.dart';
import 'package:restaurant_app/widget/rating.dart';

import '../data/enum/result_state.dart';
import '../style/theme.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({Key? key, required this.restaurant})
      : super(key: key);

  static const String routeName = '/restaurant-detail';

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<RestaurantProvider>()
        .getDetailRestaurant(widget.restaurant.id);
    context.read<FavoriteProvider>().checkFavorite(widget.restaurant.id);
  }

  void favoriteErrorMessage(
      FavoriteProvider favoriteState, BuildContext context) {
    if (favoriteState.checkIsFavoriteResult == ResultState.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error get data favorite',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (favoriteState.deleteFavoriteResult == ResultState.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            favoriteState.message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (favoriteState.insertFavoriteResult == ResultState.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            favoriteState.message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget detailRestaurantWidget(
      RestaurantProvider restaurantState, FavoriteProvider favoriteState) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 300,
                child: Image.network(
                  restaurantState.restaurantDetail.pictureId != null
                      ? 'https://restaurant-api.dicoding.dev/images/small/${restaurantState.restaurantDetail.pictureId}'
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
                      restaurantState.restaurantDetail.name ?? '',
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
                          restaurantState.restaurantDetail.city ?? '',
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
                    Rating(
                      rating: restaurantState.restaurantDetail.rating,
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
                      restaurantState.restaurantDetail.description ?? '',
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
                      child: MenuCard(
                          menus: restaurantState.restaurantDetail.menus),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton:
          favoriteState.checkIsFavoriteResult != ResultState.error &&
                  favoriteState.checkIsFavoriteResult != ResultState.loading
              ? FloatingActionButton(
                  onPressed: () {
                    if (favoriteState.isFavorite) {
                      context
                          .read<FavoriteProvider>()
                          .deleteFavorite(widget.restaurant.id);
                    } else {
                      context
                          .read<FavoriteProvider>()
                          .insertFavorite(widget.restaurant);
                    }
                    context
                        .read<FavoriteProvider>()
                        .checkFavorite(widget.restaurant.id);
                  },
                  backgroundColor: Colors.white,
                  child: Icon(
                    favoriteState.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.pinkAccent,
                  ),
                )
              : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<RestaurantProvider, FavoriteProvider>(
      builder: (context, restaurantState, favoriteState, _) {
        if (restaurantState.resultStateDetailRestaurant == ResultState.error) {
          return Center(
            child: Text(restaurantState.message),
          );
        } else if (restaurantState.resultStateDetailRestaurant ==
            ResultState.success) {
          favoriteErrorMessage(favoriteState, context);
          return detailRestaurantWidget(restaurantState, favoriteState);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
