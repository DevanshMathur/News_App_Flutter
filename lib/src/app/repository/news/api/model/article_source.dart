import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'article_source.g.dart';

@JsonSerializable()
class Source {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;

  Source(this.id, this.name);

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
