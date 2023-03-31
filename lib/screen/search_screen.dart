import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screen/restaurant_detail_screen.dart';
import 'package:restaurant_app/widget/restaurant_card.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().searchRestaurant('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Search',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.black87,
                      ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 55,
                margin: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextField(
                  onChanged: (text) {
                    context.read<RestaurantProvider>().searchRestaurant(text);
                  },
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.only(top: 2),
                    hintText: 'Search restaurant...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(90),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Consumer<RestaurantProvider>(
                  builder: (ctx, state, _) {
                    print(state.resultStateSearch);
                    if (state.resultStateSearch == ResultState.error) {
                      return Center(
                        child: Text('Error: ${state.message}'),
                      );
                    } else if (state.resultStateSearch == ResultState.noData) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else if (state.resultStateSearch == ResultState.success) {
                      return ListView.builder(
                        itemCount: state.searchRestaurantData.length,
                        itemBuilder: (ctx, index) {
                          return RestaurantCard(
                              restaurant: state.searchRestaurantData[index],
                              onClick: () {
                                Navigator.pushNamed(
                                  context,
                                  RestaurantDetailScreen.routeName,
                                  arguments: state.listRestaurant[index],
                                );
                              });
                        },
                      );
                    } else if (state.resultStateSearch == ResultState.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Center(
                        child: Text('Search your resto...'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
