// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['source'] == null
        ? null
        : Source.fromJson(json['source'] as Map<String, dynamic>),
    json['author'] as String?,
    json['title'] as String?,
    json['description'] as String?,
    json['url'] as String?,
    json['urlToImage'] as String?,
    json['publishedAt'] as String?,
    json['content'] as String?,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };
