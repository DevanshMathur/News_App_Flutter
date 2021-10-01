class NewsApiConstants {

  // API URLs
  static const String kBaseUrl = "https://newsapi.org/v2/";
  static const String kTopHeadlinesUrl = "top-headlines";
  static const String kEverythingUrl = "everything";
  static const String kSourceUrl = "top-headlines/sources";

  // API Key
  static const String kApiKey = "e57387b316ab4d11b810152f228fc7d4";

  //API CODEs
  static const int kSuccessCode = 200;
  static const int kBadRequestCode = 400;
  static const int kUnauthorizedCode = 401;
  static const int kTooManyRequestsCode = 2429;
  static const int kServerErrorCode = 500;

  //API Errors
  static const String kApiKeyDisabled = 'apiKeyDisabled';
  static const String kApiKeyExhausted = 'apiKeyExhausted';
  static const String kApiKeyInvalid = 'apiKeyInvalid';
  static const String kApiKeyMissing = 'ApiKeyMissing';
  static const String kParameterInvalid = 'ParameterInvalid';
  static const String kParametersMissing = 'ParametersMissing';
  static const String kRateLimited = 'RateLimited';
  static const String kSourcesTooMany = 'SourcesTooMany';
  static const String kSourceDoesNotExist = 'sourceDoesNotExist';
  static const String kUnexpectedError = 'UnexpectedError';

  // API Request Header Strings
  static const String kApiBaseUrlHeader = "baseUrl";
  static const String kApiKeyHeader = 'x-api-key';
  static const String kPageHeader = 'page';
  static const String kPageSizeHeader = 'pageSize';
  static const String kCountryHeader = 'country';
  static const String kCategoryHeader = 'category';
  static const String kQueryHeader = 'q';

  // API Response Strings
  static const String kStatusHeader = 'status';
  static const String kTotalResultsHeader = 'totalResults';
  static const String kArticlesHeader = 'articles';

}