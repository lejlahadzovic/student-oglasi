import 'package:json_annotation/json_annotation.dart';

part 'ocjena_average.g.dart';

@JsonSerializable()
class OcjenaAverage {
  int postId;
  double averageOcjena;

  OcjenaAverage(
    this.postId,
    this.averageOcjena,
    );

  factory OcjenaAverage.fromJson(Map<String, dynamic> json) =>
      _$OcjenaAverageFromJson(json);

  Map<String, dynamic> toJson() => _$OcjenaAverageToJson(this);
}
