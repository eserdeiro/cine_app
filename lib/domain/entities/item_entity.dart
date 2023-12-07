
import 'package:hive/hive.dart';

part 'item_entity.g.dart';
//@collection
@HiveType(typeId: 1)
class ItemEntity {
  //Id? isarId = Isar.autoIncrement;
  @HiveField(0)
  final bool adult;
  @HiveField(1)
  final String backdropPath;
  @HiveField(2)
  final List<String> genreIds;
  @HiveField(3)
  final int id;
  @HiveField(4)
  final String originalLanguage;
  @HiveField(5)
  final String originalTitle;
  @HiveField(6)
  final String overview;
  @HiveField(7)
  final double popularity;
  @HiveField(8)
  final String posterPath;
  @HiveField(9)
  final DateTime? releaseDate;
  @HiveField(10)
  final String title;
  @HiveField(11)
  final bool video;
  @HiveField(12)
  final double voteAverage;
  @HiveField(13)
  final int voteCount;

  ItemEntity({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount
  });
}