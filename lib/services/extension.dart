import 'http_helper.dart';
import 'local_storage_service.dart';

class AccessToken extends LocalStorage<Map<String, dynamic>> {
  static AccessToken accessToken = AccessToken();
  final Map<String, dynamic> map;
  AccessToken({this.map = const {}})
      : super(fileName: 'access_token', value: map);
  @override
  Future<void> clear() async {
    await clearLocal();
  }

  @override
  Future<void> init() async {
    accessToken = AccessToken(map: await readFromFile());
    HttpHelper.ins.initializeDio();
  }

  String get token => map['access_token'] as String? ?? '';
}
