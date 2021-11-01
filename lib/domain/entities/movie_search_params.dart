import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class MovieSearchParams extends Equatable {
  final String searchTerms;

  MovieSearchParams({@required this.searchTerms});
  @override
  List<Object> get props => [searchTerms];
}
