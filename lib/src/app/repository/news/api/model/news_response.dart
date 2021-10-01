import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import 'news_article.dart';

part 'news_response.g.dart';

@JsonSerializable()
class NewsResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'totalResults')
  int? totalResults;
  @JsonKey(name: 'articles')
  List<Article>? articles;

  NewsResponse(this.status, this.totalResults, this.articles);

  factory NewsResponse.fromJson(Map<String, dynamic> json) => _$NewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}
