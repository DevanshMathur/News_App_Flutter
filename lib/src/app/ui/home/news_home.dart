import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/app/block/home/home_bloc.dart';
import 'package:news_headlines/src/app/block/home/home_events.dart';
import 'package:news_headlines/src/app/block/home/home_state.dart';
import 'package:news_headlines/src/app/ui/widgets/news_item.dart';
import 'package:news_headlines/src/constants/app_utils.dart';

import '../search/search_screen.dart';

class NewsHome extends StatefulWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  NewsHomeState createState() => NewsHomeState();
}

class NewsHomeState extends State<NewsHome> {
  // List<Article> articleList = [];
  // int page = 0;
  // bool isNextPage = true;
  // bool isLoading = true;
  // late HomeBloc homeBloc;
  // late ScrollController _controller;
  

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = ScrollController();
  // }


  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   homeBloc = BlocProvider.of<HomeBloc> (context);
  //   _controller.addListener(_scrollListener);
  // }


  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SafeArea(
          child: Drawer(
            elevation: 10,
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Settings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              body: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Dark Mode"),
                        Switch(
                            value: AppUtils.darkMode, onChanged: switchTheme),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("News Category"),
                        DropdownButton<String>(
                          value: AppUtils.selectedCategory,
                          items: AppUtils.categoryList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (category) {
                            setState(() {
                              AppUtils.selectedCategory = category!;
                            });
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("News Language"),
                        DropdownButton<String>(
                          value: AppUtils.selectedLanguage,
                          items: AppUtils.languageList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (language) {
                            setState(() {
                              AppUtils.selectedLanguage = language!;
                            });
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("News Country"),
                        DropdownButton<String>(
                          value: AppUtils.selectedCountry,
                          items: AppUtils.countryList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (country) {
                            setState(() {
                              AppUtils.selectedCountry = country!;
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("Top Headlines"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, "/search");
                  // Navigator.pushNamed(context, Routes.newsSearch);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.search_outlined,
                ),
              ),
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => HomeBloc()..add(HomeModule(page: 0,country: AppUtils.getSelectedCountry(), category: AppUtils.getSelectedCategory())),
          child: const NewsState(),
        ),
    );
  }

  void switchTheme(bool val) {
    setState(() {
      AppUtils.darkMode = !AppUtils.darkMode;
    });
  }

  // void _scrollListener() {
  //   if (_controller.offset >= _controller.position.maxScrollExtent
  //   && isNextPage && !isLoading) {
  //     homeBloc.add(HomeModule(
  //         page: page,
  //     country: AppUtils.getSelectedCountry(),
  //     category: AppUtils.getSelectedCategory()));
  //     isLoading = true;
  //   }
  // }
}

class NewsState extends StatelessWidget {
  const NewsState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: BlocProvider.of<HomeBloc> (context),
      builder: (context, state) {
        if (state is InitialSearchState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (state is LoadedSearchState) {
          return ListView.builder(
              itemCount: state.searchResponse.data!.articles!.length
              ,itemBuilder: (context, position) {
                return Card(
                  elevation: 10,
                  margin: const EdgeInsets.all(5),
                  child: NewsItem(state.searchResponse.data!.articles![position]),
                );
          });
        }
        else if (state is LoadingSearchState) {
          return const Text("LoadingSearchState");
        }
        else if (state is SearchApiErrorState) {
          return const Text("SearchApiErrorState");
        }
        else if (state is SearchErrorState) {
          return const Text("SearchErrorState");
        }
        return const Text('error');
      },
    );
  }

}
