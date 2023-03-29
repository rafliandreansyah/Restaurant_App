import 'package:flutter/material.dart';

import '../style/theme.dart';

class Rating extends StatelessWidget {
  final double rating;
  const Rating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(
          Icons.star,
          color: colorYellow,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          rating.toString(),
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
