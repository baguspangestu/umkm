import 'package:get/get.dart';

import '../models/umkm_model.dart';

class UmkmProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Umkm.fromJson(map);
      if (map is List) return map.map((item) => Umkm.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Umkm?> getUmkm(int id) async {
    final response = await get('umkm/$id');
    return response.body;
  }

  Future<Response<Umkm>> postUmkm(Umkm umkm) async => await post('umkm', umkm);
  Future<Response> deleteUmkm(int id) async => await delete('umkm/$id');
}
