import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/app/block/search/search_bloc.dart';
import 'package:news_headlines/src/app/block/search/search_event.dart';
import 'package:news_headlines/src/app/block/search/search_state.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_article.dart';
import 'package:news_headlines/src/app/ui/search/widgets/search_app_bar.dart';
import 'package:news_headlines/src/app/ui/widgets/news_item.dart';

class SearchScreenWidget extends StatelessWidget {
  const SearchScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: const SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static int page = 1;
  String query = ' ';
  static List<Article> articleList = [];
  static late SearchBloc searchBloc;
  static bool isNextPage = true;
  static bool isLoading = true;
  static late ScrollController _controller;
  late TextEditingController queryTextController;

  @override
  void initState() {
    super.initState();
    searchBloc = BlocProvider.of<SearchBloc>(context);
    _controller = ScrollController();
    queryTextController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.addListener(_scrollListener);
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
  void dispose() {
    super.dispose();
    _controller.dispose();
    queryTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.09),
        child: SearchAppBar(searchQuery, queryTextController),
      ),
      body: const SearchState2(),
    );
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
}

class SearchState2 extends StatelessWidget {
  const SearchState2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: _SearchScreenState.searchBloc,
      builder: (context, state) {
        if (state is InitialSearchState) {
          return const Center(
            child: Text("Enter text in top search bar"),
          );
        } else if (state is LoadedSearchState) {
          _SearchScreenState.articleList
              .addAll(state.searchResponse.data!.articles!);
          if (_SearchScreenState.articleList.isNotEmpty) {
            _SearchScreenState.isNextPage =
                state.searchResponse.data!.totalResults! >
                        _SearchScreenState.page
                    ? true
                    : false;
            _SearchScreenState.isLoading = false;
            return ListView.builder(
              controller: _SearchScreenState._controller,
              itemCount: _SearchScreenState.articleList.length,
              itemBuilder: (context, position) {
                return Card(
                  elevation: 10,
                  margin: const EdgeInsets.all(5),
                  // child: Container(
                  //   padding: const EdgeInsets.fromLTRB(0, 2, 0, 1),
                  //   child: Text("Item" + position.toString()),
                  // ),
                  child: NewsItem(_SearchScreenState.articleList[position]),
                );
              },
            );
          } else {
            return const Center(
              child: Text("No results found"),
            );
          }
        } else if (state is LoadingSearchState) {
          return _SearchScreenState.articleList.isEmpty
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
                  controller: _SearchScreenState._controller,
                  itemCount: _SearchScreenState.articleList.length,
                  itemBuilder: (context, position) {
                    return Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(5),
                      // child: Container(
                      //   padding: const EdgeInsets.fromLTRB(0, 2, 0, 1),
                      //   child: Text("Item" + position.toString()),
                      // ),
                      child: NewsItem(_SearchScreenState.articleList[position]),
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
                state.error!.getErrorCode() == 429
                    ? const Text("Too many req")
                    : Container(),
              ],
            ),
          );
        }
        return const Text('error');
      },
    );
  }
}
