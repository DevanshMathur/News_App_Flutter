import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchQueryEvent extends SearchEvent {
  final int page;
  // final int pageSize;
  final String? query;
  // final String? country;
  // final String? category;

  const SearchQueryEvent({
    required this.page,
    /*required this.pageSize,*/ required this.query,
    // this.category,
    // this.country
  });

  @override
  List<Object?> get props => [page];
}

class ResetSearchEvent extends SearchEvent {
  @override
  List<Object?> get props => [];

}
