import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_headlines/src/constants/api_constants.dart';
import 'package:retrofit/http.dart';

import 'model/news_response.dart';

part 'news_api_client.g.dart';

@RestApi(baseUrl: NewsApiConstants.kBaseUrl)
abstract class NewsApiClient {
  factory NewsApiClient(Dio dio) => _NewsApiClient(dio);

  @GET(NewsApiConstants.kTopHeadlinesUrl)
  Future<NewsResponse> getHeadlines(
      {@required @Query(NewsApiConstants.kPageHeader) int? page,
      // @Queries(NewsApiConstants.kPageSizeHeader) int pageSize,
      @Query(NewsApiConstants.kCountryHeader) String? country,
      @Query(NewsApiConstants.kCategoryHeader) String? category});

  @GET(NewsApiConstants.kEverythingUrl)
  Future<NewsResponse> getSearchedNews(
      {@required @Query(NewsApiConstants.kPageHeader) int? page,
      // @Queries(NewsApiConstants.kPageSizeHeader) int pageSize,
      // @Queries(NewsApiConstants.kCountryHeader) String country,
      // @Queries(NewsApiConstants.kCategoryHeader) String category
      @Query(NewsApiConstants.kQueryHeader) String? query});
}
