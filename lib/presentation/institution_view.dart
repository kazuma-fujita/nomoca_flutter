import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:nomoca_flutter/constants/google_api_properties.dart';
import 'package:nomoca_flutter/data/entity/remote/institution_entity.dart';
import 'package:nomoca_flutter/presentation/asset_image_path.dart';
import 'package:nomoca_flutter/presentation/components/atoms/parallax_card.dart';
import 'package:nomoca_flutter/presentation/components/molecules/error_snack_bar.dart';
import 'package:nomoca_flutter/states/providers/get_institution_provider.dart';
import 'package:nomoca_flutter/states/providers/update_favorite_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/molecules/images_slider.dart';

class InstitutionView extends HookWidget with AssetImagePath {
  @override
  Widget build(BuildContext context) {
    var institutionId = ModalRoute.of(context)!.settings.arguments as int?;
    institutionId = 90093;
    return useProvider(getInstitutionProvider(institutionId)).when(
      data: (entity) {
        return Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                // AppBarのelevation
                elevation: 0,
                // AppBarの背景色
                backgroundColor: Colors.white,
                // AppBarの画像を下に引き伸ばせるようにする
                stretch: true,
                // AppBarを固定表示する
                pinned: true,
                // AppBarの画像表示部分の高さ
                expandedHeight:
                    entity.images != null && entity.images!.isNotEmpty
                        ? 320
                        : 240,
                // AppBarにお気に入りボタンを設置
                actions: <Widget>[
                  LikeButton(
                    key: Key('like-${entity.id}'),
                    isLiked: entity.isFavorite,
                    onTap: (bool isLike) async {
                      // update API実行
                      return _updateFavorite(isLike, entity.id, context);
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
        );
      },
      loading: () => Container(),
      error: (error, _) {
        return ErrorSnackBar(
          errorMessage: error.toString(),
          callback: () =>
              context.refresh(getInstitutionProvider(institutionId!)),
          // backScreenWidget: _emptyListView(),
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
        // StackFit.expandで画像を下にスワイプした時に画像が拡大する
        fit: StackFit.expand,
        children: <Widget>[
          entity.images != null && entity.images!.isNotEmpty
              // 施設画像スライダー
              ? ImagesSlider(images: entity.images!)
              // 施設画像が無ければデフォルト画像表示
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
              // _nameAndCategoryBlock(entity.name, entity.category,
              //     entity.phoneNumber, entity.webSiteUrl!),
              _nameAndCategoryBlock(entity.name, entity.category),
              if (entity.feature != null)
                _detailBlock('こだわり・特徴', entity.feature!),
              if (entity.businessHour != null)
                _detailBlock('診療時間', entity.businessHour!),
              if (entity.businessHoliday != null)
                _detailBlock('休診日', entity.businessHoliday!),
              _buildStaticMapView(entity),
              if (entity.access != null) _detailBlock('アクセス', entity.access!),
              if (entity.title1 != null && entity.body1 != null)
                _detailBlock(entity.title1!, entity.body1!),
              if (entity.title2 != null && entity.body2 != null)
                _detailBlock(entity.title2!, entity.body2!),
              if (entity.title3 != null && entity.body3 != null)
                _detailBlock(entity.title3!, entity.body3!),
              // TODO: websiteUrlがnullの時の処理追加 架電ボタンのテスト追加
              _buttonBlock(entity.phoneNumber, entity.webSiteUrl!),
            ],
          ),
        )
      ],
    );
  }

  // Widget _nameAndCategoryBlock(String subject, String description,
  //     String phoneNumber, String websiteUrl) {
  Widget _nameAndCategoryBlock(String subject, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(subject,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text(description, style: const TextStyle(fontSize: 12)),
        // const SizedBox(height: 16),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     _phoneButton(phoneNumber),
        //     _websiteButton(websiteUrl),
        //   ],
        // ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buttonBlock(String phoneNumber, String websiteUrl) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Divider(),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _phoneButton(phoneNumber),
            _websiteButton(websiteUrl),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // TODO: OutlinedButtonの共通化
  Widget _phoneButton(String phoneNumber) {
    return OutlinedButton.icon(
      label: const Text('電話をかける'),
      icon: const Icon(Icons.phone),
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(),
      ),
      onPressed: () => _launchURL('tel:$phoneNumber'),
    );
  }

  Widget _websiteButton(String url) {
    return OutlinedButton.icon(
      label: const Text('ウェブサイトを見る'),
      icon: const Icon(Icons.web),
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(),
      ),
      onPressed: () => _launchURL(url),
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

  Widget _buildStaticMapView(InstitutionEntity entity) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 24),
        GestureDetector(
          // GoogleMapApp起動
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
          // GoogleMapApp起動
          onTap: () => _launchGoogleApp(
              latitude: entity.latitude,
              longitude: entity.longitude,
              isRoute: true),
          child: Row(
            children: const [
              Icon(Icons.map),
              Text('行き方を調べる'),
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
      _launchURL(
          'https://maps.apple.com/?${isRoute ? 'daddr' : 'q'}=$latitude,$longitude');

  Future<void> _launchURL(String url) async => await canLaunch(url)
      ? await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
        )
      : throw Exception('Could not launch $url');

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
      bool isLike, int institutionId, BuildContext context) async {
    return await context.read(updateFavoriteProvider(institutionId)).maybeWhen(
          data: (_) async {
            // TODO: このデータブロックに処理が入らないので調査
            // お気に入り登録時SnackBar表示
            if (!isLike) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('お気に入り登録しました')));
            }
            // お気に入りボタン反転処理
            return !isLike;
          },
          error: (error, _) {
            // SnackBar表示
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error.toString())));
            // error時お気に入りボタンは変更しない
            return isLike;
          },
          // ローディング中はお気に入りボタン反転処理
          orElse: () => !isLike,
        );
  }
}
