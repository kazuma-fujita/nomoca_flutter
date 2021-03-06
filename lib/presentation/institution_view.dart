import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:nomoca_flutter/constants/asset_paths.dart';
import 'package:nomoca_flutter/constants/google_api_properties.dart';
import 'package:nomoca_flutter/data/entity/remote/institution_entity.dart';
import 'package:nomoca_flutter/presentation/asset_image_path.dart';
import 'package:nomoca_flutter/presentation/common/launch_url.dart';
import 'package:nomoca_flutter/presentation/components/atoms/parallax_card.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/states/actions/favorite_list_action.dart';
import 'package:nomoca_flutter/states/actions/keyword_search_list_action.dart';
import 'package:nomoca_flutter/states/providers/get_institution_provider.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';
import 'package:nomoca_flutter/states/reducers/favorite_list_reducer.dart';
import 'package:nomoca_flutter/states/reducers/keyword_search_list_reducer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'components/molecules/images_slider.dart';

class InstitutionView extends HookConsumerWidget with AssetImagePath {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var institutionId = ModalRoute.of(context)!.settings.arguments as int?;
    institutionId = 90093;
    return ref.watch(getInstitutionProvider(institutionId)).when(
          data: (entity) {
            return Scaffold(
              floatingActionButton: entity.medicalDocumentUrl != null
                  ? SizedBox(
                      width: 168,
                      height: 60,
                      child: FloatingActionButton(
                        onPressed: () => launchUrl(entity.medicalDocumentUrl!),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Image.asset(
                          '${AssetPaths.iconImagePath}/ic_btn_medical_document.png',
                        ),
                      ),
                    )
                  : Container(),
              body: Scrollbar(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      // AppBar???elevation
                      elevation: 0,
                      // AppBar????????????
                      backgroundColor: Colors.white,
                      // AppBar???????????????????????????????????????????????????
                      stretch: true,
                      // AppBar?????????????????????
                      pinned: true,
                      // AppBar??????????????????????????????
                      expandedHeight:
                          entity.images != null && entity.images!.isNotEmpty
                              ? 320
                              : 240,
                      // AppBar????????????????????????????????????
                      actions: <Widget>[
                        LikeButton(
                          key: Key('like-${entity.id}'),
                          isLiked: entity.isFavorite,
                          onTap: (bool isLike) async {
                            // update API??????
                            return _updateFavorite(
                              isLike,
                              entity.id,
                              context,
                              ref,
                            );
                            // return !isLike;
                          },
                        ),
                      ],
                      flexibleSpace: _flexibleSpaceBar(entity, context),
                    ),
                    SliverList(
                      delegate: _sliverChildListDelegate(entity),
                    )
                  ],
                ),
              ),
            );
          },
          loading: () => Scaffold(
            body: _shimmerView(),
          ),
          error: (error, _) {
            return ErrorSnackBar(
              errorMessage: error.toString(),
              callback: () =>
                  ref.refresh(getInstitutionProvider(institutionId!)),
            );
          },
        );
  }

  Widget _flexibleSpaceBar(InstitutionEntity entity, BuildContext context) {
    return FlexibleSpaceBar(
      stretchModes: const <StretchMode>[
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
        StretchMode.fadeTitle,
      ],
      background: Stack(
        // StackFit.expand???????????????????????????????????????????????????????????????
        fit: StackFit.expand,
        children: <Widget>[
          entity.images != null && entity.images!.isNotEmpty
              // ???????????????????????????
              ? ImagesSlider(images: entity.images!)
              // ??????????????????????????????????????????????????????
              : Image(
                  fit: BoxFit.cover,
                  image: AssetImage(getRandomInstitutionImagePath()),
                ),
        ],
      ),
    );
  }

  SliverChildListDelegate _sliverChildListDelegate(InstitutionEntity entity) {
    return SliverChildListDelegate(
      <Widget>[
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _nameAndCategoryBlock(entity.name, entity.category),
              if (entity.feature != null)
                _detailBlock('?????????????????????', entity.feature!),
              if (entity.businessHour != null)
                _detailBlock('????????????', entity.businessHour!),
              if (entity.businessHoliday != null)
                _detailBlock('?????????', entity.businessHoliday!),
              _buildStaticMapView(entity),
              if (entity.access != null) _detailBlock('????????????', entity.access!),
              if (entity.title1 != null && entity.body1 != null)
                _detailBlock(entity.title1!, entity.body1!),
              if (entity.title2 != null && entity.body2 != null)
                _detailBlock(entity.title2!, entity.body2!),
              if (entity.title3 != null && entity.body3 != null)
                _detailBlock(entity.title3!, entity.body3!),
              if (entity.webSiteUrl != null)
                _launchApplicationBlock(
                  url: entity.webSiteUrl!,
                  title: '???????????????????????????',
                  trailingIcon: Icons.web_outlined,
                ),
              if (entity.reserveUrl != null)
                _launchApplicationBlock(
                  url: entity.reserveUrl!,
                  title: '?????????????????????',
                  trailingIcon: Icons.calendar_today,
                ),
              if (!entity.isPhoneButtonHidden)
                _launchApplicationBlock(
                  url: 'tel:${entity.phoneNumber}',
                  title: '?????????????????????????????????',
                  trailingIcon: Icons.phone,
                ),
              if (entity.medicalDocumentUrl != null)
                Column(
                  children: const [
                    Divider(),
                    SizedBox(height: 60),
                  ],
                ),
            ],
          ),
        )
      ],
    );
  }

  Widget _nameAndCategoryBlock(String subject, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(subject,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text(description, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _detailBlock(String subject, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Divider(),
        const SizedBox(height: 24),
        Text(subject,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text(description, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _launchApplicationBlock({
    required String url,
    required String title,
    required IconData trailingIcon,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => launchUrl(url),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Divider(),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(trailingIcon),
              Text(title, style: const TextStyle(fontSize: 18)),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStaticMapView(InstitutionEntity entity) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 24),
        GestureDetector(
          // GoogleMapApp??????
          onTap: () => _launchGoogleApp(
              latitude: entity.latitude, longitude: entity.longitude),
          child: _buildStaticMap(entity.longitude, entity.latitude),
        ),
        const SizedBox(height: 8),
        Text(
          entity.buildingName != null
              ? '${entity.address} ${entity.buildingName}'
              : entity.address,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          // GoogleMapApp??????
          onTap: () => _launchGoogleApp(
              latitude: entity.latitude,
              longitude: entity.longitude,
              isRoute: true),
          child: Row(
            children: const [
              Icon(Icons.map),
              Text('?????????????????????'),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Future<void> _launchGoogleApp(
          {required double latitude,
          required double longitude,
          bool isRoute = false}) async =>
      launchUrl(
          'https://maps.apple.com/?${isRoute ? 'daddr' : 'q'}=$latitude,$longitude');

  Widget _buildStaticMap(double longitude, double latitude) {
    const baseMapURL = 'https://maps.googleapis.com/maps/api/staticmap';
    const mapZoom = 'zoom=18';
    const mapSize = 'size=720x640';
    const scale = 'scale=2';
    const language = 'language=ja';
    final mapCenter = 'center=$latitude,$longitude';
    final mapMarkers = 'markers=$latitude,$longitude';
    const apiKey = 'key=${GoogleApiProperties.apiKey}';
    final imageUrl = '$baseMapURL?$mapCenter&$mapZoom'
        '&$mapMarkers&$mapSize&$scale&$language&$apiKey';
    return ParallaxCard(
      key: const Key('google-static-map'),
      builder: (GlobalKey _backgroundImageKey) => SizedBox(
        key: _backgroundImageKey,
        height: 240,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (context, url, dynamic error) =>
              const Center(child: Icon(Icons.error)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<bool> _updateFavorite(
    bool isLike,
    int institutionId,
    BuildContext context,
    WidgetRef ref,
  ) async {
    return await ref.read(updateFavoriteProvider(institutionId)).maybeWhen(
          data: (_) async {
            // ????????????????????????SnackBar??????
            if (!isLike) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('?????????????????????????????????')));
            }
            // ????????????????????????????????????????????????????????????
            ref.read(keywordSearchListActionDispatcher).state =
                KeywordSearchListAction.toggleFavorite(institutionId);
            // ???????????????????????????????????????
            ref.read(favoriteListActionDispatcher).state =
                const FavoriteListAction.fetchList();
            // ????????????????????????????????????
            return !isLike;
          },
          error: (error, _) {
            // SnackBar??????
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error.toString())));
            // error?????????????????????????????????????????????
            return isLike;
          },
          // ????????????????????????????????????????????????????????????
          orElse: () => !isLike,
        );
  }

  Widget _shimmerView() {
    return SingleChildScrollView(
      child: Shimmer(
        duration: const Duration(milliseconds: 1500),
        child: Column(
          children: [
            // ????????????ShimmerBlock
            Container(
              height: 320,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _shimmerViewNameAndCategoryBlock(),
                  _shimmerViewDetailBlock(),
                  _shimmerViewDetailBlock(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerViewNameAndCategoryBlock() {
    return Column(
      children: [
        Container(
          height: 24,
          color: Colors.grey[300],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 64, 24),
          child: Container(
            height: 12,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  Widget _shimmerViewDetailBlock() {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 24),
        Container(
          height: 21,
          color: Colors.grey[300],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 64, 24),
          child: Column(
            children: [
              Container(
                height: 14,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 8),
              Container(
                height: 14,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
