import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:news_headlines/src/api_lib/lib_api_manager.dart';
import 'package:news_headlines/src/constants/api_constants.dart';
import 'api/model/news_response.dart';
import 'api/news_api_client.dart';

class NewsRepository {
  late NewsApiClient _newsApiClient;
  final Logger _logger = Logger("NewsRepository");

  NewsRepository() {
    HashMap<String,String> hashMap = HashMap();
    hashMap[NewsApiConstants.kApiKeyHeader] = NewsApiConstants.kApiKey;
    final dio = ServiceManager.get().getDioClient(baseUrl: NewsApiConstants.kBaseUrl,moreHeaders: hashMap);
    _newsApiClient = NewsApiClient(dio);
  }

  Future<ApiResponseWrapper<NewsResponse>> getNewsHeadlines(
      {required int page,
      required String? country,
      required String? category}) async {
    NewsResponse response;
    try {
      response = await _newsApiClient.getHeadlines(
          page: page, country: country, category: category);
    } on DioError catch (e) {
      _logger.log(Level.INFO, "Exception occurred: getNewsHeadlines", e);
        return ApiResponseWrapper()..setException(ServerError.withError(e));
    } catch (error, stacktrace) {
      _logger.log(Level.INFO, stacktrace);
      return ApiResponseWrapper()..setException(ServerError());
    }
    return ApiResponseWrapper()..data = response;
  }

}
