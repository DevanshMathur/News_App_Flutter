import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/app/block/home/home_bloc.dart';
import 'package:news_headlines/src/app/block/home/home_events.dart';
import 'package:news_headlines/src/app/block/home/home_state.dart';
import 'package:news_headlines/src/app/block/theme/theme_bloc.dart';
import 'package:news_headlines/src/app/block/theme/theme_event.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_article.dart';
import 'package:news_headlines/src/app/ui/home/enum/dropdown_enum.dart';
import 'package:news_headlines/src/app/ui/home/widgets/dropdown_widget.dart';
import 'package:news_headlines/src/app/ui/home/widgets/home_app_bar.dart';
import 'package:news_headlines/src/app/ui/widgets/news_item.dart';
import 'package:news_headlines/src/app_utils/api_constants.dart';
import 'package:news_headlines/src/app_utils/app_preference.dart';
import 'package:news_headlines/src/app_utils/app_utils.dart';

import '../../../../theme/enum/theme_enum.dart';

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
                  DropDownWidget("App Theme", DropDownEnum.themeEnum, switchTheme),
                  DropDownWidget("News Category", DropDownEnum.categoryEnum, updateList),
                  DropDownWidget("News Language", DropDownEnum.languageEnum, updateList),
                  DropDownWidget("News Country", DropDownEnum.countryEnum, updateList),
                ],
              ),
            ),
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.09,
        ),
        child: const HomeAppBar(),
      ),
      body: const NewsState(),
    );
  }

  void switchTheme(String value) {
    setState(() {
      ThemeEnum e = AppUtils.getThemeEnum(value);
      AppPreference.setSelectedThemeEnum(e); //save enum
      switch (e) {
        case ThemeEnum.lightTheme:
          BlocProvider.of<ThemeBloc>(context)
              .add(const ThemeEvent(themeMode: ThemeMode.light));
          break;
        case ThemeEnum.darkTheme:
          BlocProvider.of<ThemeBloc>(context)
              .add(const ThemeEvent(themeMode: ThemeMode.dark));
          break;
        case ThemeEnum.systemTheme:
          BlocProvider.of<ThemeBloc>(context)
              .add(const ThemeEvent(themeMode: ThemeMode.system));
          break;
      }
    });
  }

  void updateList(String value) {
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
