import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/app/block/home/home_bloc.dart';
import 'package:news_headlines/src/app/block/home/home_events.dart';
import 'package:news_headlines/src/app/block/home/home_state.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_article.dart';
import 'package:news_headlines/src/app/ui/home/widgets/custom_drawer.dart';
import 'package:news_headlines/src/app/ui/home/widgets/home_app_bar.dart';
import 'package:news_headlines/src/app/ui/widgets/custom_loader.dart';
import 'package:news_headlines/src/app/ui/widgets/news_item.dart';
import 'package:news_headlines/src/app_utils/api_constants.dart';
import 'package:news_headlines/src/app_utils/app_utils.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => NewsHome();
}

class NewsHome extends State<NewsScreen> {
  int page = 0;
  bool isNextPage = true;
  late HomeBloc homeBloc;
  late ScrollController _controller;
  static List<Article> articleList = [];
  static bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(
      HomeFetchEvent(
        page: 0,
        country: AppUtils.getSelectedCountryCode(),
        category: AppUtils.getSelectedCategoryCode(),
      ),
    );
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        isNextPage &&
        !isLoading) {
      page++;
      homeBloc.add(HomeFetchEvent(
          page: page,
          country: AppUtils.getSelectedCountryCode(),
          category: AppUtils.getSelectedCategoryCode()));
      isLoading = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.09,
        ),
        child: const HomeAppBar(),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc, //BlocProvider.of<HomeBloc>(context);
        builder: (context, state) {
          if (state is InitialSearchState) {
            return const CustomLoader("InitialSearchState", true);
          }
          else if (state is LoadedSearchState) {
            articleList.addAll(state.searchResponse.data!.articles!);
            isNextPage = state.searchResponse.data!.totalResults! > page;
            isLoading = false;
            return ListView.builder(
              controller: _controller,
              itemCount: articleList.length,
              itemBuilder: (context, position) =>
                  NewsItem(articleList[position]),
            );
          }
          else if (state is LoadingSearchState) {
            return articleList.isEmpty
                ? const CustomLoader("LoadingSearchState", true)
                : ListView.builder(
                    controller: _controller,
                    itemCount: articleList.length,
                    itemBuilder: (context, position) =>
                        NewsItem(articleList[position]),
                  );
          }
          else if (state is SearchApiErrorState) {
            return const CustomLoader("SearchApiErrorState", false);
          }
          else if (state is SearchErrorState) {
            return CustomLoader(
                "SearchErrorState\n" +
                    NewsApiConstants.getServerMessage(
                        state.error!.getErrorCode()),
                false);
          }
          return const CustomLoader("Error", false);
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
