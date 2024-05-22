import 'dart:convert';

class Standing {
  int? position;
  Team? team;
  int? playedGames;
  String? form;
  int? won;
  int? draw;
  int? lost;
  int? points;
  int? goalsFor;
  int? goalsAgainst;
  int? goalDifference;

  Standing(
      {this.position,
      this.team,
      this.playedGames,
      this.form,
      this.won,
      this.draw,
      this.lost,
      this.points,
      this.goalsFor,
      this.goalsAgainst,
      this.goalDifference});

  Standing.fromMap(Map<String, dynamic> json) {
    position = json['position'];
    team = json['team'] != null ? Team.fromMap(json['team']) : null;
    playedGames = json['playedGames'];
    form = json['form'];
    won = json['won'];
    draw = json['draw'];
    lost = json['lost'];
    points = json['points'];
    goalsFor = json['goalsFor'];
    goalsAgainst = json['goalsAgainst'];
    goalDifference = json['goalDifference'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['position'] = position;
    if (team != null) {
      data['team'] = team!.toJson();
    }
    data['playedGames'] = playedGames;
    data['form'] = form;
    data['won'] = won;
    data['draw'] = draw;
    data['lost'] = lost;
    data['points'] = points;
    data['goalsFor'] = goalsFor;
    data['goalsAgainst'] = goalsAgainst;
    data['goalDifference'] = goalDifference;
    return data;
  }

  factory Standing.fromJson(String source) => Standing.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Team {
  int? id;
  String? name;
  String? shortName;
  String? tla;
  String? crest;

  Team({this.id, this.name, this.shortName, this.tla, this.crest});

  Team.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    tla = json['tla'];
    crest = json['crest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['shortName'] = shortName;
    data['tla'] = tla;
    data['crest'] = crest;
    return data;
  }
}
