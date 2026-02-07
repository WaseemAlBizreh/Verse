import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:verse/core/ui/resources/font_manager.dart';

import '../../../../../core/ui/resources/asset_manger.dart';
import '../../../../../core/ui/resources/color_manager.dart';
import '../../../../../core/ui/resources/values_manager.dart';
import '../../../../../core/ui/widgets/custom_cached_image.dart';
import '../../../models/movie_model.dart';

/// Web-only vertical list for Top Movies (right sidebar): poster + details per row.
class WebTopMoviesListWidget extends StatelessWidget {
  const WebTopMoviesListWidget({
    super.key,
    required this.movies,
    this.onMovieTap,
    this.onFavouriteTap,
  });

  final List<MovieModel> movies;
  final void Function(MovieModel movie)? onMovieTap;
  final void Function(MovieModel movie)? onFavouriteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.colorPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(AppSize.s16, AppSize.s20, AppSize.s16, AppSize.s12),
            child: Text(
              'top_movies'.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorManager.colorFontPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
              itemCount: movies.length,
              separatorBuilder: (_, __) => SizedBox(height: AppSize.s16),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return _WebTopMovieTile(
                  movie: movie,
                  onTap: onMovieTap != null ? () => onMovieTap!(movie) : null,
                  onFavouriteTap: onFavouriteTap != null
                      ? () => onFavouriteTap!(movie)
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WebTopMovieTile extends StatelessWidget {
  const _WebTopMovieTile({
    required this.movie,
    this.onTap,
    this.onFavouriteTap,
  });

  final MovieModel movie;
  final VoidCallback? onTap;
  final VoidCallback? onFavouriteTap;

  static const double _posterWidth = 80;
  static const double _posterHeight = 120;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s10),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSize.s8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s8),
                child: SizedBox(
                  width: _posterWidth,
                  height: _posterHeight,
                  child: CustomCachedNetworkImage(
                    imageUrl: movie.posterUrl,
                    width: _posterWidth,
                    height: _posterHeight,
                    fit: BoxFit.cover,
                    borderRadius: 0,
                  ),
                ),
              ),
              SizedBox(width: AppSize.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (movie.certification.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: AppSize.s4),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSize.s6,
                            vertical: AppSize.s2,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.colorGrey2.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(AppSize.s4),
                          ),
                          child: Text(
                            movie.certification,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: ColorManager.colorFontPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.s10,
                                ),
                          ),
                        ),
                      ),
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: ColorManager.colorFontPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: FontSize.s14,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (movie.genres.isNotEmpty) ...[
                      SizedBox(height: AppSize.s4),
                      Text(
                        movie.genresDisplay,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorManager.colorFontPrimary
                                  .withValues(alpha: 0.8),
                              fontSize: FontSize.s12,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    SizedBox(height: AppSize.s6),
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconsAssets.starIcon,
                          width: AppSize.s18,
                          colorFilter: const ColorFilter.mode(
                            ColorManager.colorThird,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: AppSize.s4),
                        Text(
                          movie.rating,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: ColorManager.colorFontPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize.s12,
                              ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: onFavouriteTap,
                          child: SvgPicture.asset(
                            IconsAssets.favouriteIcon,
                            width: AppSize.s22,
                            colorFilter: ColorFilter.mode(
                              movie.isFavourite
                                  ? ColorManager.colorThird
                                  : ColorManager.colorGrey2,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
