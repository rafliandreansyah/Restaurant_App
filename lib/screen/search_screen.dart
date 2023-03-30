import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Search',
                  style:
                  Theme.of(context).textTheme.headline4!.copyWith(
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
                  onSubmitted: (text) {
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
              Expanded(child: Consumer<RestaurantProvider>(builder: (ctx, state, _){
                if(state.resultState == ResultState.error) {
                  return Center(
                    child: Text('Error: ${state.message}'),
                  );
                } else if (state.resultState == ResultState.noData) {
                  return const Center(
                    child: Text('Data is empty!'),
                  );
                } else if (state.resultState == ResultState.success) {
                  return ListView.builder(
                      itemCount: state.searchRestaurantData.length,
                      itemBuilder: (ctx, index) {
                        return RestaurantCard(restaurant: state.searchRestaurantData[index], onClick: (){});
                      },
                  );
                } else if (state.resultState == ResultState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Center(
                    child: Text('Search your resto...'),
                  );
                }
              },),),
            ],
          ),
        ),
      ),
    );
  }
}
