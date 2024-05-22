final class Club {
  final String name;
  final String coach;
  final int marketCap;
  final String logo;
  final String stadium;
  final String country;
  final String leagueCode;

  Club({
    required this.name,
    required this.coach,
    required this.marketCap,
    required this.logo,
    required this.stadium,
    required this.country,
    required this.leagueCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'coach': coach,
      'marketCap': marketCap,
      'logo': logo,
      'stadium': stadium,
      'country': country,
      'leagueCode': leagueCode,
    };
  }

  factory Club.fromMap(Map<String, dynamic> map) {
    return Club(
      country: map['country'] as String,
      name: map['name'] as String,
      coach: map['coach'] as String,
      marketCap: map['marketCap'] as int,
      logo: map['logo'] as String,
      stadium: map['stadium'] as String,
      leagueCode: map['leagueCode'] as String,
    );
  }
}
