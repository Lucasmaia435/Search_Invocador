import 'package:search_invocador/models/league.dart';

class Summoner {
  final String id;
  final String accountId;
  final String puuid;
  final String name;
  final int profileIconId;
  final int summonerLevel;
  final List<League> ranks;

  Summoner({
    this.id,
    this.accountId,
    this.puuid,
    this.name,
    this.profileIconId,
    this.summonerLevel,
    this.ranks,
  });

  factory Summoner.fromJson(Map<String, dynamic> json) {
    List<League> ranks = [];
    for (int i = 0; i < json['ranks'].length; i++) {
      ranks.add(League.fromJson(json['ranks'][i]));
    }
    return Summoner(
      id: json['id'],
      accountId: json['accountId'],
      puuid: json['puuid'],
      name: json['name'],
      profileIconId: json['profileIconId'],
      summonerLevel: json['summonerLevel'],
      ranks: ranks,
    );
  }

  setElo(Map<String, dynamic> json) {}
}
