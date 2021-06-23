import 'dart:convert';

import 'package:nomoca_flutter/constants/nomoca_urls.dart';
import 'package:nomoca_flutter/data/api/keyword_search_api.dart';
import 'package:nomoca_flutter/data/dao/user_dao.dart';
import 'package:nomoca_flutter/data/entity/remote/keyword_search_entity.dart';
import 'package:nomoca_flutter/data/repository/authenticated.dart';

// ignore: one_member_abstracts
abstract class KeywordSearchRepository with Authenticated {
  Future<List<KeywordSearchEntity>> fetchList({
    required String query,
    required int offset,
    required int limit,
    double? latitude,
    double? longitude,
  });
}

class KeywordSearchRepositoryImpl extends KeywordSearchRepository {
  KeywordSearchRepositoryImpl(
      {required this.keywordSearchApi, required this.userDao});

  final KeywordSearchApi keywordSearchApi;
  final UserDao userDao;

  @override
  Future<List<KeywordSearchEntity>> fetchList({
    required String query,
    required int offset,
    required int limit,
    double? latitude,
    double? longitude,
  }) async {
    final authenticationToken = getAuthenticationToken(userDao.get());
    try {
      final responseBody = await keywordSearchApi(
        authenticationToken: authenticationToken,
        query: query,
        offset: offset,
        limit: limit,
        latitude: latitude,
        longitude: longitude,
      );

      final decodedJson = json.decode(responseBody) as List<dynamic>;
      // Conversion json to entity.
      final list = decodedJson
          .map((dynamic itemJson) =>
              KeywordSearchEntity.fromJson(itemJson as Map<String, dynamic>))
          .toList();
      return list
          .map(
            (entity) => entity.copyWith(
              buildingName: entity.buildingName ?? '',
              image1: entity.image1 != null
                  ? '${NomocaUrls.contentsBaseUrl}/${entity.image1}'
                  : null,
              image2: entity.image2 != null
                  ? '${NomocaUrls.contentsBaseUrl}/${entity.image2}'
                  : null,
              image3: entity.image3 != null
                  ? '${NomocaUrls.contentsBaseUrl}/${entity.image3}'
                  : null,
              image4: entity.image4 != null
                  ? '${NomocaUrls.contentsBaseUrl}/${entity.image4}'
                  : null,
              image5: entity.image5 != null
                  ? '${NomocaUrls.contentsBaseUrl}/${entity.image5}'
                  : null,
            ),
          )
          .toList();
    } on Exception catch (error) {
      throw Exception(error);
    }
  }
}

class FakeKeywordSearchRepositoryImpl extends KeywordSearchRepository {
  FakeKeywordSearchRepositoryImpl();
  @override
  Future<List<KeywordSearchEntity>> fetchList({
    required String query,
    required int offset,
    required int limit,
    double? latitude,
    double? longitude,
  }) async {
    const contentsBaseUrl = 'https://contents.nomoca.com';
    return [
      const KeywordSearchEntity(
        id: 92506,
        name: '渋谷リーフクリニック',
        address: '渋谷区道玄坂2-23-14',
        isFavorite: false,
        buildingName: '道玄坂225ビル4F',
        image1: '$contentsBaseUrl/institutions/test/image1/top1.jpg',
        image2: '$contentsBaseUrl/institutions/test/image2/2.jpg',
        images: null,
      ),
      const KeywordSearchEntity(
        id: 90093,
        name: '小笠原歯科',
        address: '渋谷区道玄坂2-25-5',
        isFavorite: true,
        buildingName: '島田ビル4F',
        image1:
            '$contentsBaseUrl/institutions/100027/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg',
        image2:
            '$contentsBaseUrl/institutions/100027/image4/8191a0e68a83a305c1f5c007b3ae1225.jpg',
        image3:
            '$contentsBaseUrl/institutions/100027/image5/149e69d2d9726d61c98a05329e57bea6.jpg',
        image4:
            '$contentsBaseUrl/institutions/100620/image5/f6d2d5248c0e35a9b094ed1c0d092102.jpg',
        image5:
            '$contentsBaseUrl/institutions/102125/image3/bccffca6b7d7b44e951a0d80d6ab6586.jpg',
        images: [
          '$contentsBaseUrl/institutions/100027/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg',
          '$contentsBaseUrl/institutions/100027/image4/8191a0e68a83a305c1f5c007b3ae1225.jpg',
          '$contentsBaseUrl/institutions/100027/image5/149e69d2d9726d61c98a05329e57bea6.jpg',
          '$contentsBaseUrl/institutions/100620/image5/f6d2d5248c0e35a9b094ed1c0d092102.jpg',
          '$contentsBaseUrl/institutions/102125/image3/bccffca6b7d7b44e951a0d80d6ab6586.jpg',
        ],
      ),
      const KeywordSearchEntity(
        id: 82951,
        name: '代々木ステーションクリニック',
        address: '渋谷区代々木1-35-4',
        isFavorite: false,
        buildingName: '代々木クリスタルビル4F',
        image1:
            '$contentsBaseUrl/institutions/82951/image1/c95f76e81d63a799bec4a786cdb07ba1.jpg',
        image2:
            '$contentsBaseUrl/institutions/82951/image2/0265923501297e04c70ed1aa247e601a.jpg',
        image3:
            '$contentsBaseUrl/institutions/82951/image3/31807331c1da6a75eaa7fc0173775120.jpg',
        image4:
            '$contentsBaseUrl/institutions/82951/image4/7d62c4be320407d96f58032acc059cdd.jpg',
        images: [
          '$contentsBaseUrl/institutions/82951/image1/c95f76e81d63a799bec4a786cdb07ba1.jpg',
          '$contentsBaseUrl/institutions/82951/image2/0265923501297e04c70ed1aa247e601a.jpg',
          '$contentsBaseUrl/institutions/82951/image3/31807331c1da6a75eaa7fc0173775120.jpg',
          '$contentsBaseUrl/institutions/82951/image4/7d62c4be320407d96f58032acc059cdd.jpg',
        ],
      ),
      const KeywordSearchEntity(
        id: 252718,
        name: 'N.S.DENTAL 　CLINIC',
        address: '渋谷区笹塚1-24-2',
        isFavorite: false,
        buildingName: 'トーシンフェニックス笹塚参番館104',
        image1:
            '$contentsBaseUrl/institutions/252718/image1/041e127182040f5cf340af571dc4107f.jpg',
        image2:
            '$contentsBaseUrl/institutions/252718/image2/a91ca940c0142f0fd94fe3efa5efba7d.jpg',
        images: [
          '$contentsBaseUrl/institutions/252718/image1/041e127182040f5cf340af571dc4107f.jpg',
          '$contentsBaseUrl/institutions/252718/image2/a91ca940c0142f0fd94fe3efa5efba7d.jpg',
        ],
      ),
      const KeywordSearchEntity(
        id: 120,
        name: 'タカデンタルクリニック',
        address: '渋谷区恵比寿1-19-18',
        isFavorite: false,
        buildingName: '石渡ビル3F',
        image1:
            '$contentsBaseUrl/institutions/120/image1/2ac467ca7fec709b12ae312efd83dea9.jpg',
        image2:
            '$contentsBaseUrl/institutions/120/image2/ed8e976d057a014575cee7730d120717.jpg',
        image4:
            '$contentsBaseUrl/institutions/120/image4/e907cf5540089bcdb1787a2d979e6a7b.jpg',
        image5: null,
        images: [
          '$contentsBaseUrl/institutions/120/image1/2ac467ca7fec709b12ae312efd83dea9.jpg',
          '$contentsBaseUrl/institutions/120/image2/ed8e976d057a014575cee7730d120717.jpg',
          '$contentsBaseUrl/institutions/120/image4/e907cf5540089bcdb1787a2d979e6a7b.jpg',
        ],
      ),
      const KeywordSearchEntity(
        id: 72148,
        name: '渋谷塚田クリニック',
        address: '渋谷区桜丘町11-2',
        isFavorite: false,
        buildingName: 'フィオーレ桜丘ビル1F',
        image1:
            '$contentsBaseUrl/institutions/72148/image1/63f0f0d279c2f513a827567a1b96808a.jpg',
        image2:
            '$contentsBaseUrl/institutions/72148/image2/fe64bf8a8de34f651ae6997595032af5.jpg',
        image3:
            '$contentsBaseUrl/institutions/72148/image3/941b732f99ad22201c56abf5c4ed286a.jpg',
        image4:
            '$contentsBaseUrl/institutions/72148/image4/e67e053e3e3eec5538a189a5779136f5.jpg',
        image5:
            '$contentsBaseUrl/institutions/72148/image5/28cdc32cacb94b767d086d6fecd2fc1a.jpg',
        images: [
          '$contentsBaseUrl/institutions/72148/image1/63f0f0d279c2f513a827567a1b96808a.jpg',
          '$contentsBaseUrl/institutions/72148/image2/fe64bf8a8de34f651ae6997595032af5.jpg',
          '$contentsBaseUrl/institutions/72148/image3/941b732f99ad22201c56abf5c4ed286a.jpg',
          '$contentsBaseUrl/institutions/72148/image4/e67e053e3e3eec5538a189a5779136f5.jpg',
          '$contentsBaseUrl/institutions/72148/image5/28cdc32cacb94b767d086d6fecd2fc1a.jpg',
        ],
      ),
      const KeywordSearchEntity(
        id: 92008,
        name: '渋谷笹塚循環器HDクリニック',
        address: '渋谷区笹塚1-30-3',
        isFavorite: false,
        buildingName: 'ビラージュ笹塚III403',
        image1:
            '$contentsBaseUrl/institutions/92008/image1/25b72c4355cdb65343d43d1a2cfff068.jpg',
        image3:
            '$contentsBaseUrl/institutions/92008/image3/586999f5d40bc7b6ea749b5ed67ac521.jpg',
        image4:
            '$contentsBaseUrl/institutions/92008/image4/ed8e976d057a014575cee7730d120717.jpg',
        image5:
            '$contentsBaseUrl/institutions/92008/image5/e907cf5540089bcdb1787a2d979e6a7b.jpg',
        images: [
          '$contentsBaseUrl/institutions/92008/image1/25b72c4355cdb65343d43d1a2cfff068.jpg',
          '$contentsBaseUrl/institutions/92008/image3/586999f5d40bc7b6ea749b5ed67ac521.jpg',
          '$contentsBaseUrl/institutions/92008/image4/ed8e976d057a014575cee7730d120717.jpg',
          '$contentsBaseUrl/institutions/92008/image5/e907cf5540089bcdb1787a2d979e6a7b.jpg',
        ],
      ),
      const KeywordSearchEntity(
        id: 63109,
        name: '渋谷プライムクリニック',
        address: '渋谷区渋谷1-24-5',
        isFavorite: false,
        buildingName: 'ドクターズビル6F',
        image1:
            '$contentsBaseUrl/institutions/63109/image1/3449b879d11005d384bbfaf51fc568bc.jpg',
        image2:
            '$contentsBaseUrl/institutions/63109/image2/3449b879d11005d384bbfaf51fc568bc.jpg',
        image3:
            '$contentsBaseUrl/institutions/63109/image3/3449b879d11005d384bbfaf51fc568bc.jpg',
        image4:
            '$contentsBaseUrl/institutions/63109/image4/3449b879d11005d384bbfaf51fc568bc.jpg',
        image5:
            '$contentsBaseUrl/institutions/63109/image5/3449b879d11005d384bbfaf51fc568bc.jpg',
        images: [
          '$contentsBaseUrl/institutions/63109/image1/3449b879d11005d384bbfaf51fc568bc.jpg',
          '$contentsBaseUrl/institutions/63109/image2/3449b879d11005d384bbfaf51fc568bc.jpg',
          '$contentsBaseUrl/institutions/63109/image3/3449b879d11005d384bbfaf51fc568bc.jpg',
          '$contentsBaseUrl/institutions/63109/image4/3449b879d11005d384bbfaf51fc568bc.jpg',
          '$contentsBaseUrl/institutions/63109/image5/3449b879d11005d384bbfaf51fc568bc.jpg',
        ],
      ),
      const KeywordSearchEntity(
        id: 252763,
        name: '渋谷分析療法室',
        address: '渋谷区道玄坂１丁目１５−３ プリメーラ道玄坂',
        isFavorite: false,
        buildingName: '',
        image1:
            '$contentsBaseUrl/institutions/252763/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg',
        image4:
            '$contentsBaseUrl/institutions/252763/image4/537220273b5ced18ba6f1cb3081619a2.jpg',
        image5:
            '$contentsBaseUrl/institutions/252763/image5/231b10bad75c73a59e524e1080c187ea.jpg',
        images: [
          '$contentsBaseUrl/institutions/252763/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg',
          '$contentsBaseUrl/institutions/252763/image4/537220273b5ced18ba6f1cb3081619a2.jpg',
          '$contentsBaseUrl/institutions/252763/image5/231b10bad75c73a59e524e1080c187ea.jpg',
        ],
      ),
      const KeywordSearchEntity(
        id: 252779,
        name: 'アットホーム渋谷クリニック',
        address: '東京都渋谷区渋谷3-7-1',
        isFavorite: false,
        buildingName: '第1ヒラゼンビル3階4階',
        image1:
            '$contentsBaseUrl/institutions/252779/image1/3447ee16f741490136c6eca85058d0bf.jpg',
        image2:
            '$contentsBaseUrl/institutions/252779/image2/6019631efae68e396ed11570dbda2e7c.jpg',
        image3:
            '$contentsBaseUrl/institutions/252779/image3/9a4e6bb8822f7e7b5fefe2558166a927.jpg',
        image4:
            '$contentsBaseUrl/institutions/252779/image4/826593816b2013e9627d7a8595e16048.jpg',
        image5:
            '$contentsBaseUrl/institutions/252779/image5/62a31f4ffb3f46bf57bc15a73552b00a.jpg',
        images: [
          '$contentsBaseUrl/institutions/252779/image1/3447ee16f741490136c6eca85058d0bf.jpg',
          '$contentsBaseUrl/institutions/252779/image2/6019631efae68e396ed11570dbda2e7c.jpg',
          '$contentsBaseUrl/institutions/252779/image3/9a4e6bb8822f7e7b5fefe2558166a927.jpg',
          '$contentsBaseUrl/institutions/252779/image4/826593816b2013e9627d7a8595e16048.jpg',
          '$contentsBaseUrl/institutions/252779/image5/62a31f4ffb3f46bf57bc15a73552b00a.jpg',
        ],
      ),
      const KeywordSearchEntity(
        id: 16756,
        name: '渋谷ステーションクリニック',
        address: '渋谷区渋谷1-13-7',
        isFavorite: false,
        buildingName: 'ヒューリック渋谷ビル2F',
        image1:
            '$contentsBaseUrl/institutions/16756/image1/f950e290972d87e3accf04fbceb201b8.jpg',
        image2:
            '$contentsBaseUrl/institutions/16756/image2/642f8b8242d884cc5febbe0d99c914cf.jpg',
        image3:
            '$contentsBaseUrl/institutions/16756/image3/f3302285c47a6f1ca44a20b07b3d9421.jpg',
        image4:
            '$contentsBaseUrl/institutions/16756/image4/77dbe4189160281c40b6b33281d7bd9c.jpg',
        images: [
          '$contentsBaseUrl/institutions/16756/image1/f950e290972d87e3accf04fbceb201b8.jpg',
          '$contentsBaseUrl/institutions/16756/image2/642f8b8242d884cc5febbe0d99c914cf.jpg',
          '$contentsBaseUrl/institutions/16756/image3/f3302285c47a6f1ca44a20b07b3d9421.jpg',
          '$contentsBaseUrl/institutions/16756/image4/77dbe4189160281c40b6b33281d7bd9c.jpg',
        ],
      ),
      const KeywordSearchEntity(
          id: 51,
          name: '渋谷メトロプラザ歯科',
          address: '渋谷区渋谷1-16-14',
          isFavorite: false,
          buildingName: '渋谷地下鉄ビル1F',
          image1:
              '$contentsBaseUrl/institutions/51/image1/b567cc9986f163664e7852693852eb42.jpg',
          image2:
              '$contentsBaseUrl/institutions/51/image2/af2707e8b5ae4d67398e3746c30f8bf2.jpg',
          image3:
              '$contentsBaseUrl/institutions/51/image3/af95d6f602e2d7a71036d05525354223.jpg',
          image4:
              '$contentsBaseUrl/institutions/51/image4/99a3af1078c268864de43c0a05e86c8b.jpg',
          image5:
              '$contentsBaseUrl/institutions/51/image5/2930c6b6ee8868c03967fa57ef2d47ba.jpg'),
      const KeywordSearchEntity(
          id: 63141,
          name: '渋谷南口稲見眼科',
          address: '渋谷区道玄坂1-3-3',
          isFavorite: false,
          buildingName: '楠本ビル9F',
          image1:
              '$contentsBaseUrl/institutions/63141/image1/8382640183d165d6fe0b4e48a87dabb1.jpg',
          image2:
              '$contentsBaseUrl/institutions/63141/image2/586999f5d40bc7b6ea749b5ed67ac521.jpg',
          image3:
              '$contentsBaseUrl/institutions/63141/image3/149e69d2d9726d61c98a05329e57bea6.jpg',
          image4:
              '$contentsBaseUrl/institutions/63141/image4/7c99d8da8b989fd2d5396b5d2ca3bfae.jpg',
          image5:
              '$contentsBaseUrl/institutions/63141/image5/e907cf5540089bcdb1787a2d979e6a7b.jpg'),
      const KeywordSearchEntity(
          id: 143682,
          name: 'スマイルコンセプト矯正歯科・渋谷クリニック',
          address: '渋谷区渋谷1-14-14',
          isFavorite: false,
          buildingName: 'TK渋谷東口ビル7F',
          image1:
              '$contentsBaseUrl/institutions/143682/image1/410c77ab59c0328eabc17381f997eaef.jpg',
          image4:
              '$contentsBaseUrl/institutions/143682/image4/53fa5fe0750645e7be01c3941d4e5d78.jpg',
          image5:
              '$contentsBaseUrl/institutions/143682/image5/e5d011c502a9bd5d58188b59ad47060b.jpg'),
      const KeywordSearchEntity(
          id: 144,
          name: '新宿新都心歯科口腔外科クリニック',
          address: '新宿区西新宿8-5-4',
          isFavorite: false,
          buildingName: 'STビル2F',
          image1:
              '$contentsBaseUrl/institutions/144/image1/e907cf5540089bcdb1787a2d979e6a7b.jpg',
          image2:
              '$contentsBaseUrl/institutions/144/image2/affdeadffe19b1df2513c2102adf4635.JPG',
          image3:
              '$contentsBaseUrl/institutions/144/image3/18e291b8256c685ff650af1ee8005794.JPG',
          image4:
              '$contentsBaseUrl/institutions/144/image4/ec9b4b37ec1b3ec1bc1f0c14f5c7b0be.JPG',
          image5:
              '$contentsBaseUrl/institutions/144/image5/121ac35307a05c264e1ab838979e3122.JPG'),
      const KeywordSearchEntity(
        id: 100590,
        name: '吉井矯正歯科新宿クリニック',
        address: '渋谷区代々木2-10-10',
        isFavorite: false,
        buildingName: '東京プラザビル6F',
        image1:
            '$contentsBaseUrl/institutions/100590/image1/5929bd4e5d73a2f23d7e8adbfcc0d8e8.jpg',
        image2:
            '$contentsBaseUrl/institutions/100590/image2/e907cf5540089bcdb1787a2d979e6a7b.jpg',
        image3:
            '$contentsBaseUrl/institutions/100590/image3/ed8e976d057a014575cee7730d120717.jpg',
      ),
      const KeywordSearchEntity(
          id: 54894,
          name: '南新宿整形外科リハビリテーションクリニック',
          address: '渋谷区代々木2-16-7',
          isFavorite: false,
          buildingName: '山葉メディカルセンタービル4F',
          image1:
              '$contentsBaseUrl/institutions/54894/image1/367cf315cf2b38b6a01c0d3dc0a26b09.jpg',
          image2:
              '$contentsBaseUrl/institutions/54894/image2/62ece6e0accbd71ab81844a2d91c3917.jpg',
          image3:
              '$contentsBaseUrl/institutions/54894/image3/0ee6113c4ac63562c15ca748771f25f5.jpg',
          image4:
              '$contentsBaseUrl/institutions/54894/image4/f1c30ae59868fff1925a2af9e9489d4a.jpg',
          image5:
              '$contentsBaseUrl/institutions/54894/image5/e67e053e3e3eec5538a189a5779136f5.jpg'),
      const KeywordSearchEntity(
        id: 93611,
        name: '三田こころの健康クリニック　新宿',
        address: '新宿区新宿2-1-2',
        isFavorite: false,
        buildingName: '白鳥ビル2F',
        image1:
            '$contentsBaseUrl/institutions/93611/image1/2b1a47fb2f19ac3d10114c6f8f34355a.jpg',
        image2:
            '$contentsBaseUrl/institutions/93611/image2/c8e921f376ad8079aafb8c050c2e8486.jpg',
        image3:
            '$contentsBaseUrl/institutions/93611/image3/c8811eea06fe757a0d10bbc4c1ee7079.jpg',
      ),
      const KeywordSearchEntity(
          id: 252579,
          name: '池袋ハート整骨院',
          address: '豊島区東池袋3-11-7',
          isFavorite: false,
          buildingName: '',
          image1:
              '$contentsBaseUrl/institutions/252579/image1/d78f473f72eaf9407bf76922fced9ceb.jpg',
          image4:
              '$contentsBaseUrl/institutions/252579/image4/8382640183d165d6fe0b4e48a87dabb1.jpg',
          image5:
              '$contentsBaseUrl/institutions/252579/image5/a6a75baac993f9eb7a3bf77c7d2291b6.jpg'),
      const KeywordSearchEntity(
          id: 17404,
          name: '池袋藤久ビルクリニック',
          address: '豊島区西池袋1-18-2',
          isFavorite: false,
          buildingName: '藤久ビル西1号館9F',
          image1:
              '$contentsBaseUrl/institutions/17404/image1/7ba40a771886509fe50371e7deb8a31f.jpg',
          image2:
              '$contentsBaseUrl/institutions/17404/image2/19c8873a9ff847b971cde74e8490a094.jpg',
          image3:
              '$contentsBaseUrl/institutions/17404/image3/bd101573f9c2bbe4d172dbdecab4f1ba.jpg',
          image4:
              '$contentsBaseUrl/institutions/17404/image4/e4b400b6a96ac15db7caee842db42ff5.jpg',
          image5:
              '$contentsBaseUrl/institutions/17404/image5/c850d7140f4b46cd8ba0e9eeb370bbcd.jpg'),
      const KeywordSearchEntity(
          id: 175,
          name: '松山矯正歯科新宿御苑クリニック',
          address: '新宿区新宿1丁目14-10',
          isFavorite: false,
          buildingName: '松山ビル3F',
          image1:
              '$contentsBaseUrl/institutions/175/image1/1b0ecd1a8bafbb0d4e765d5f163ec0b0.jpg',
          image2:
              '$contentsBaseUrl/institutions/175/image2/7cfeff71889e6adfb38a61636e3934e0.jpg',
          image3:
              '$contentsBaseUrl/institutions/175/image3/ed8e976d057a014575cee7730d120717.jpg',
          image4:
              '$contentsBaseUrl/institutions/175/image4/92accadca9fb24aba3dd3f22cc3f1234.jpg',
          image5:
              '$contentsBaseUrl/institutions/175/image5/c55b19771b1edaf1867fbb0ca9ebccdb.jpg'),
      const KeywordSearchEntity(
          id: 15409,
          name: 'タカナシクリニック新宿',
          address: '新宿区新宿4-3-15',
          isFavorite: false,
          buildingName: 'レイフラット新宿201',
          image1:
              '$contentsBaseUrl/institutions/15409/image1/b40be9b4353e02885dec6d805ef18b95.jpg',
          image2:
              '$contentsBaseUrl/institutions/15409/image2/e907cf5540089bcdb1787a2d979e6a7b.jpg',
          image3:
              '$contentsBaseUrl/institutions/15409/image3/ed8e976d057a014575cee7730d120717.jpg',
          image4:
              '$contentsBaseUrl/institutions/15409/image4/8382640183d165d6fe0b4e48a87dabb1.jpg',
          image5:
              '$contentsBaseUrl/institutions/15409/image5/d76191c1b16c1e282f2ef86f0d43caa2.jpg'),
      const KeywordSearchEntity(
          id: 85683,
          name: '西新宿さいとう眼科',
          address: '新宿区西新宿1-5-11',
          isFavorite: false,
          buildingName: '新宿三葉ビル7F',
          image1:
              '$contentsBaseUrl/institutions/85683/image1/d78f473f72eaf9407bf76922fced9ceb.jpg',
          image2:
              '$contentsBaseUrl/institutions/85683/image2/bc7426fac2ef41a508ae15e0f0ec87b0.jpg',
          image4:
              '$contentsBaseUrl/institutions/85683/image4/e907cf5540089bcdb1787a2d979e6a7b.jpg',
          image5:
              '$contentsBaseUrl/institutions/85683/image5/ed8e976d057a014575cee7730d120717.jpg'),
    ];
  }
}
