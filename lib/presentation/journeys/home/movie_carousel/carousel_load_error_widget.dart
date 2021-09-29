import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/widgets/button.dart';
import 'package:wiredash/wiredash.dart';

class CarouselLoadErrorWidget extends StatelessWidget {
  final AppErrorType errorType;
  final MovieCarouselBloc bloc;
  const CarouselLoadErrorWidget(
      {Key key, @required this.errorType, @required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorType == AppErrorType.api
                ? TranslationConstants.somethingWentWrong.translate(context)
                : TranslationConstants.checkNetwork.translate(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          ButtonBar(
            children: [
              Button(
                onPressed: () => bloc.add(
                  CarouselLoadEvent(),
                ),
                text: TranslationConstants.retry.translate(context),
              ),
              Button(
                onPressed: () => Wiredash.of(context).show(),
                text: TranslationConstants.feedback.translate(context),
              ),
            ],
          )
        ],
      ),
    );
  }
}
