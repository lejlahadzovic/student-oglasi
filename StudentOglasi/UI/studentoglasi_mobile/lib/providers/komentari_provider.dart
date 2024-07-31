import 'dart:convert';
import 'package:studentoglasi_mobile/models/Komenatar/komentar.dart';
import 'package:studentoglasi_mobile/models/Komenatar/komentar_insert.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class KomentariProvider extends BaseProvider<Komentar> {
  KomentariProvider() : super("Komentari");

  @override
  Komentar fromJson(data) {
    return Komentar.fromJson(data);
  }

  Future<List<Komentar>> getCommentsByPost(int postId, String postType) async {
    var url = "${BaseProvider.baseUrl}$endPoint/$postId/$postType";
    var uri = Uri.parse(url);

    var response = await ioClient.get(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body) as List;
      return data.map((e) => Komentar.fromJson(e)).toList();
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<Komentar> insertComment(KomentarInsert komentar) async {
    return await insertJsonData(komentar.toJson());
  }
}