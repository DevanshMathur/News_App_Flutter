import 'package:news_headlines/src/api_lib/api_response_wrapper.dart';
import 'package:news_headlines/src/api_lib/app_exception.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_response.dart';

abstract class HomeState {
  const HomeState();
}

class InitialSearchState extends HomeState {
  const InitialSearchState();

  List<Object> get props => [];
}

class LoadingSearchState extends HomeState {
  const LoadingSearchState();

  List<Object> get props => [];
}

class LoadedSearchState extends HomeState {
  final ApiResponseWrapper<NewsResponse> searchResponse;

  const LoadedSearchState(this.searchResponse);

  List<Object> get props => [searchResponse];
}

class SearchApiErrorState extends HomeState {
  final NullThrownError? error;

  const SearchApiErrorState(this.error);

  List<Object?> get props => [error];
}

class SearchErrorState extends HomeState {
  final ServerError? error;

  const SearchErrorState(this.error);

  List<Object?> get props => [error];
}
