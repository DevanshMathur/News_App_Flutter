import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/app/block/search/search_bloc.dart';
import 'package:news_headlines/src/app/block/search/search_event.dart';
import 'package:news_headlines/src/app/block/search/search_state.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_article.dart';
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
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchBloc = BlocProvider.of<SearchBloc>(context);
    _controller = ScrollController();
    searchController = TextEditingController();
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
      searchBloc.add(SearchModule(page: page, query: searchController.text));
      isLoading = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                // elevation: 5,
                // shape: const RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(5)),),
                child: TextField(
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    articleList.clear();
                    searchBloc.add(
                      SearchModule(
                        page: page,
                        query: value,
                      ),
                    );
                  },
                  cursorColor: Colors.white,
                  decoration: const InputDecoration.collapsed(
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: 'Enter search text'),
                  controller: searchController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  articleList.clear();
                  searchBloc.add(
                    SearchModule(
                      page: page,
                      query: searchController.text,
                    ),
                  );
                },
                child: const Icon(Icons.search_outlined),
              ),
            ],
          ),
        ),
        body: const SearchState2()
        );
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("LoadingSearchState"),
                CircularProgressIndicator(),
              ],
            ),
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
              child: Text("Enter Search Text"),
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
