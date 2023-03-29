import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/widget/rating.dart';

import '../style/theme.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onClick;
  const RestaurantCard(
      {Key? key, required this.restaurant, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
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
                    restaurant.pictureId != null
                        ? 'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}'
                        : '',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name ?? '',
                      style: Theme.of(context).textTheme.headline6,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.location_city,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          restaurant.city ?? '',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Rating(rating: restaurant.rating),
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
