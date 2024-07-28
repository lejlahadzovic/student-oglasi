import 'dart:convert';

import 'package:studentoglasi_mobile/models/Like/like.dart';
import 'package:studentoglasi_mobile/models/Like/like_count.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';
import 'base_provider.dart';

class LikeProvider extends BaseProvider<Like> {
  LikeProvider() : super('Likes');

  List<Like> _likes = [];
  List<LikeCount> _likesCount = [];

  @override
  Like fromJson(data) {
    // TODO: implement fromJson
    return Like.fromJson(data);
  }

  List<Like> get likes => _likes;
  List<LikeCount> get likesCount => _likesCount;

  Future<void> likeItem(Like like) async {
    await insertJsonData(like.toJson());
    _likes.add(like);

    var likeCount = _likesCount.firstWhere(
        (l) =>
            l.itemId == like.itemId &&
            l.itemType == like.itemType.toShortString(),
        orElse: () => LikeCount(like.itemId, like.itemType.toShortString(), 0));

    if (likeCount.count == 0) {
      _likesCount.add(LikeCount(like.itemId, like.itemType.toShortString(), 1));
    } else {
      likeCount.count++;
    }

    notifyListeners();
  }

  Future<void> unlikeItem(Like like) async {
    var url = "${BaseProvider.baseUrl}${endPoint}";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(like.toJson(), toEncodable: myDateSerializer);
    var response =
        await ioClient.delete(uri, headers: headers, body: jsonRequest);

    if (response.statusCode == 200) {
      _likes.removeWhere(
          (l) => l.itemId == like.itemId && l.itemType == like.itemType);

      var likeCount = _likesCount.firstWhere(
          (l) =>
              l.itemId == like.itemId &&
              l.itemType == like.itemType.toShortString(),
          orElse: () =>
              LikeCount(like.itemId, like.itemType.toShortString(), 0));

      if (likeCount.count > 1) {
        likeCount.count--;
      } else {
        _likesCount.remove(likeCount);
      }

      notifyListeners();
    } else {
      throw Exception('Failed to unlike item');
    }
  }

  Future<void> getUserLikes() async {
    var url = "${BaseProvider.baseUrl}$endPoint/userLikes";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await ioClient.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body) as List;
      _likes = data.map((likeJson) => fromJson(likeJson)).toList();
      notifyListeners();
    } else {
      throw Exception("Failed to fetch user likes");
    }
  }

  bool isLiked(int itemId, String itemType) {
    return _likes.any((like) =>
        like.itemId == itemId && like.itemType.toShortString() == itemType);
  }

  Future<void> getAllLikesCount() async {
    var url = "${BaseProvider.baseUrl}$endPoint/allLikesCount";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await ioClient.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body) as List;
      _likesCount = data.map((item) => LikeCount.fromJson(item)).toList();
      notifyListeners();
    } else {
      throw Exception("Failed to fetch likes count");
    }
  }

  int getLikesCount(int itemId, String itemType) {
    var likeCount = _likesCount.firstWhere(
        (l) => l.itemId == itemId && l.itemType == itemType,
        orElse: () =>
            LikeCount(itemId, itemType, 0));
    return likeCount.count;
  }
}
