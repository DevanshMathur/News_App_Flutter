import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/app/block/theme/theme_event.dart';
import 'package:news_headlines/src/app/block/theme/theme_state.dart';
import 'package:news_headlines/src/app_utils/app_utils.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: AppUtils.getAppTheme()));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeEvent) {
      yield ThemeState(themeData: event.themeData);
    }
  }
}
