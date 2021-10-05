import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/app/block/home/home_bloc.dart';
import 'package:news_headlines/src/app/block/home/home_events.dart';
import 'package:news_headlines/src/app/block/home/home_state.dart';
import 'package:news_headlines/src/app/block/theme/theme_bloc.dart';
import 'package:news_headlines/src/app/block/theme/theme_event.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_article.dart';
import 'package:news_headlines/src/app/ui/widgets/news_item.dart';
import 'package:news_headlines/src/app_utils/api_constants.dart';
import 'package:news_headlines/src/app_utils/app_utils.dart';
import 'package:news_headlines/theme/app_theme.dart';

import '../search/search_screen.dart';

class NewsScreenWidget extends StatelessWidget {
  const NewsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(
          HomeModule(
            page: 0,
            country: AppUtils.getSelectedCountryCode(),
            category: AppUtils.getSelectedCategoryCode(),
          ),
        ),
      child: const NewsHome(),
    );
  }
}

class NewsHome extends StatefulWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  NewsHomeState createState() => NewsHomeState();
}

class NewsHomeState extends State<NewsHome> {
  static List<Article> articleList = [];
  static int page = 0;
  static bool isNextPage = true;
  static bool isLoading = true;
  static late HomeBloc homeBloc;
  static late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        isNextPage &&
        !isLoading) {
      page++;
      homeBloc.add(HomeModule(
          page: page,
          country: AppUtils.getSelectedCountryCode(),
          category: AppUtils.getSelectedCategoryCode()));
      isLoading = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
                          value: AppUtils.getDarkMode(),
                          onChanged: switchTheme),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("News Category"),
                      DropdownButton<String>(
                        value: AppUtils.getSelectedCategory(),
                        items: AppUtils.getCategoryList().map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (category) {
                          setState(() {
                            AppUtils.setSelectedCategory(category!);
                            updateList();
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
                        value: AppUtils.getSelectedLanguage(),
                        items: AppUtils.getLanguageList().map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (language) {
                          setState(() {
                            AppUtils.setSelectedLanguage(language!);
                            updateList();
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
                        value: AppUtils.getSelectedCountry(),
                        items: AppUtils.getCountryList().map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (country) {
                          setState(() {
                            AppUtils.setSelectedCountry(country!);
                            updateList();
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
                    builder: (context) => const SearchScreenWidget(),
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
      body: const NewsState(),
    );
  }

  void switchTheme(bool val) {
    setState(() {
      AppUtils.setDarkMode(val);
      if (val) {
        BlocProvider.of<ThemeBloc>(context)
            .add(ThemeEvent(themeData: AppTheme.darkTheme));
      } else {
        BlocProvider.of<ThemeBloc>(context)
            .add(ThemeEvent(themeData: AppTheme.lightTheme));
      }
    });
  }

  void updateList() {
    articleList.clear();
    BlocProvider.of<HomeBloc>(context).add(HomeModule(
        page: page,
        country: AppUtils.getSelectedCountryCode(),
        category: AppUtils.getSelectedCategoryCode()));
    isLoading = true;
  }
}

class NewsState extends StatelessWidget {
  const NewsState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: NewsHomeState.homeBloc,
      builder: (context, state) {
        if (state is InitialSearchState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                Text("InitialSearchState"),
              ],
            ),
          );
        } else if (state is LoadedSearchState) {
          NewsHomeState.articleList
              .addAll(state.searchResponse.data!.articles!);
          NewsHomeState.isNextPage =
              state.searchResponse.data!.totalResults! > NewsHomeState.page
                  ? true
                  : false;
          NewsHomeState.isLoading = false;
          return ListView.builder(
            controller: NewsHomeState._controller,
            itemCount: NewsHomeState.articleList.length,
            itemBuilder: (context, position) {
              return Card(
                elevation: 10,
                margin: const EdgeInsets.all(5),
                child: NewsItem(NewsHomeState.articleList[position]),
              );
            },
          );
        } else if (state is LoadingSearchState) {
          return NewsHomeState.articleList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("LoadingSearchState"),
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: NewsHomeState._controller,
                  itemCount: NewsHomeState.articleList.length,
                  itemBuilder: (context, position) {
                    return Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(5),
                      child: NewsItem(NewsHomeState.articleList[position]),
                    );
                  },
                );
        } else if (state is SearchApiErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("SearchApiErrorState"),
              ],
            ),
          );
        } else if (state is SearchErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("SearchErrorState"),
                Text(NewsApiConstants.getServerMessage(
                    state.error!.getErrorCode())),
              ],
            ),
          );
        }
        return const Text('error');
      },
    );
  }
}
