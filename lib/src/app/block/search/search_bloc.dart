import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/api_lib/api_response_wrapper.dart';
import 'package:news_headlines/src/app/block/search/search_event.dart';
import 'package:news_headlines/src/app/block/search/search_state.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_response.dart';
import 'package:news_headlines/src/app/repository/news/news_repository.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const InitialSearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    yield const LoadingSearchState();
    if (event is SearchModule) {
      try {
        final ApiResponseWrapper<NewsResponse> searchResponse =
        await NewsRepository().getSearchedQuery(
            page: event.page,
// pageSize: pageSize,
            query: event.query?.toLowerCase() ?? '',
            // category: event.category?.toLowerCase() ?? 'general',
            // country: event.country?.toLowerCase() ?? 'in'
        );
        if (searchResponse.data == null ||
            searchResponse.data!.status == 'error') {
          yield SearchErrorState(searchResponse.getException);
        } else {
          yield LoadedSearchState(searchResponse);
        }
      } on NullThrownError {
        yield const SearchApiErrorState(null);
      } catch (e) {
        yield const SearchApiErrorState(null);
      }
    }
  }
}