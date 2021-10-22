import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeFetchEvent extends HomeEvent {
  final int page;
  // final int pageSize;
  final String? country;
  final String? category;

  const HomeFetchEvent(
      {required this.page,
      /*required this.pageSize,*/ this.category,
      this.country});

  @override
  List<Object?> get props => [page];
}
