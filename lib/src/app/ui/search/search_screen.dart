import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/app/block/search/search_bloc.dart';
import 'package:news_headlines/src/app/block/search/search_event.dart';
import 'package:news_headlines/src/app/block/search/search_state.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_article.dart';
import 'package:news_headlines/src/app/ui/search/widgets/search_app_bar.dart';
import 'package:news_headlines/src/app/ui/widgets/custom_loader.dart';
import 'package:news_headlines/src/app/ui/widgets/news_item.dart';
import 'package:news_headlines/src/app_utils/api_constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int page = 1;
  String query = ' ';
  bool isLoading = true;
  bool isNextPage = true;
  List<Article> articleList = [];
  late SearchBloc searchBloc;
  late ScrollController _controller;
  late TextEditingController queryTextController;

  @override
  void initState() {
    super.initState();
    searchBloc = BlocProvider.of<SearchBloc>(context);
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    queryTextController = TextEditingController();
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        isNextPage &&
        !isLoading) {
      page++;
      searchBloc.add(
        SearchModule(
          page: page,
          query: queryTextController.text,
        ),
      );
      isLoading = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.09),
          child: SearchAppBar(searchQuery, queryTextController),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          bloc: searchBloc,
          builder: (context, state) {
            if (state is InitialSearchState) {
              return const CustomLoader("Enter text in top search bar", false);
            } else if (state is LoadedSearchState) {
              articleList.addAll(state.searchResponse.data!.articles!);
              if (articleList.isNotEmpty) {
                isNextPage = state.searchResponse.data!.totalResults! > page;
                isLoading = false;
                return ListView.builder(
                  controller: _controller,
                  itemCount: articleList.length,
                  itemBuilder: (context, position) {
                    return NewsItem(articleList[position]);
                  },
                );
              } else {
                return const Center(
                  child: Text("No results found"),
                );
              }
            } else if (state is LoadingSearchState) {
              return articleList.isEmpty
                  ? const CustomLoader("LoadingSearchState", true)
                  : ListView.builder(
                      controller: _controller,
                      itemCount: articleList.length,
                      itemBuilder: (context, position) {
                        return NewsItem(articleList[position]);
                      },
                    );
            } else if (state is SearchApiErrorState) {
              return const CustomLoader("SearchApiErrorState", true);
            } else if (state is SearchErrorState) {
              return CustomLoader(
                  "SearchErrorState\n" +
                      NewsApiConstants.getServerMessage(
                          state.error!.getErrorCode()),
                  false);
            }
            return const CustomLoader("Error", true);
          },
        ));
  }

  void searchQuery() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (queryTextController.text.trim().isNotEmpty) {
      articleList.clear();
      searchBloc.add(
        SearchModule(
          page: page,
          query: queryTextController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    queryTextController.dispose();
  }
}
