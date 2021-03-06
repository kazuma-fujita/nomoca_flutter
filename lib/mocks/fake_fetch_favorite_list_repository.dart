import 'package:nomoca_flutter/data/entity/remote/favorite_entity.dart';
import 'package:nomoca_flutter/data/repository/fetch_favorite_list_repository.dart';

class FakeFetchFavoriteListRepositoryImpl extends FetchFavoriteListRepository {
  FakeFetchFavoriteListRepositoryImpl();

  static const contentsBaseUrl = 'https://contents.nomoca.com';
  final entities = [
    const FavoriteEntity(
      institutionId: 92506,
      type: 'clinic',
      name: '渋谷リーフクリニック',
      images: null,
      userIds: [199, 200, 201],
    ),
    const FavoriteEntity(
      institutionId: 90093,
      type: 'dentistry',
      name: '小笠原歯科',
      images: [
        '$contentsBaseUrl/institutions/100027/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg',
        '$contentsBaseUrl/institutions/100027/image4/8191a0e68a83a305c1f5c007b3ae1225.jpg',
        '$contentsBaseUrl/institutions/100027/image5/149e69d2d9726d61c98a05329e57bea6.jpg',
        '$contentsBaseUrl/institutions/100620/image5/f6d2d5248c0e35a9b094ed1c0d092102.jpg',
        '$contentsBaseUrl/institutions/102125/image3/bccffca6b7d7b44e951a0d80d6ab6586.jpg',
      ],
      userIds: [199, 200, 201],
    ),
  ];

  @override
  Future<List<FavoriteEntity>> fetchList() async =>
      Future.delayed(const Duration(seconds: 0), () => entities);
}
