import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/api_lib/api_response_wrapper.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_response.dart';
import 'package:news_headlines/src/app/repository/news/news_repository.dart';

import 'home_events.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const InitialSearchState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield const LoadingSearchState();
    if (event is HomeModule) {
      try {
        final ApiResponseWrapper<NewsResponse> searchResponse =
            await NewsRepository().getNewsHeadlines(
                page: event.page,
// pageSize: pageSize,
                category: event.category?.toLowerCase() ?? 'general',
                country: event.country?.toLowerCase() ?? 'in');
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
