import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/resources/color_manager.dart';
import '../../../../core/ui/resources/values_manager.dart';
import '../../models/movie_model.dart';
import 'movie_card_widget.dart';

class TopMoviesSectionWidget extends StatelessWidget {
  const TopMoviesSectionWidget({
    super.key,
    required this.movies,
    this.onMovieTap,
    this.onFavouriteTap,
  });

  final List<MovieModel> movies;
  final void Function(MovieModel movie)? onMovieTap;
  final void Function(MovieModel movie)? onFavouriteTap;

  static double get _cardWidth => AppSize.sWidth * 0.75;
  static double get _cardHeight => AppSize.sHeight * 0.2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            AppSize.s16,
            AppSize.s20,
            AppSize.s16,
            AppSize.s12,
          ),
          child: Text(
            'top_movies'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: ColorManager.colorFontPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(
          height: _cardHeight + AppSize.s12,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
            itemCount: movies.length,
            separatorBuilder: (_, __) => SizedBox(width: AppSize.s12),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return SizedBox(
                width: _cardWidth,
                child: MovieCardWidget(
                  movie: movie,
                  width: _cardWidth,
                  height: _cardHeight,
                  isHorizontalListItem: true,
                  onTap: onMovieTap != null ? () => onMovieTap!(movie) : null,
                  onFavouriteTap: onFavouriteTap != null
                      ? () => onFavouriteTap!(movie)
                      : null,
                ),
              );
            },
          ),
        ),
        SizedBox(height: AppSize.s24),
      ],
    );
  }
}
