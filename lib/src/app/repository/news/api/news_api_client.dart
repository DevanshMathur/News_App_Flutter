import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_headlines/src/constants/api_constants.dart';
import 'package:retrofit/http.dart';

import 'model/news_response.dart';

part 'news_api_client.g.dart';
// flutter pub run build_runner build


@RestApi(baseUrl: NewsApiConstants.kBaseUrl)
abstract class NewsApiClient {
  factory NewsApiClient(Dio dio) => _NewsApiClient(dio);

  @GET(NewsApiConstants.kTopHeadlinesUrl)
  Future<NewsResponse> getHeadlines({
    @required @Query(NewsApiConstants.kPageHeader) int? page,
    // @Query(NewsApiConstants.kPageSizeHeader) int pageSize,
    @Query(NewsApiConstants.kCountryHeader) String? country,
    @Query(NewsApiConstants.kCategoryHeader) String? category,
  });

  @GET(NewsApiConstants.kEverythingUrl)
  Future<NewsResponse> getSearchedNews({
    @required @Query(NewsApiConstants.kPageHeader) int? page,
    // @Query(NewsApiConstants.kPageSizeHeader) int pageSize,
    @Query(NewsApiConstants.kQueryHeader) String? query,
    // @Query(NewsApiConstants.kCountryHeader) String? country,
    // @Query(NewsApiConstants.kCategoryHeader) String? category,
  });
}
