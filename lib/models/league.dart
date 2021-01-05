class League {
  final String leagueId;
  final String queueType;
  final String tier;
  final String rank;
  final String summonerId;
  final String summonerName;
  final int leaguePoints;
  final int wins;
  final int losses;
  final bool veteran;
  final bool inactive;
  final bool freshBlood;
  final bool hotStreak;

  League({
    this.leagueId,
    this.queueType,
    this.tier,
    this.rank,
    this.summonerId,
    this.summonerName,
    this.leaguePoints,
    this.wins,
    this.losses,
    this.veteran,
    this.inactive,
    this.freshBlood,
    this.hotStreak,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      leagueId: json['leagueId'],
      queueType: json['queueType'],
      tier: json['tier'],
      rank: json['rank'],
      summonerId: json['summonerId'],
      summonerName: json['summonerName'],
      leaguePoints: json['leaguePoints'],
      wins: json['wins'],
      losses: json['losses'],
      veteran: json['veteran'],
      inactive: json['inactive'],
      freshBlood: json['freshBlood'],
      hotStreak: json['hotStreak'],
    );
  }
}
