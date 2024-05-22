class MatchModel {
  Competition? competition;
  Season? season;
  int? id;
  String? utcDate;
  String? status;
  int? matchday;
  String? stage;
  String? lastUpdated;
  HomeTeam? homeTeam;
  HomeTeam? awayTeam;
  Score? score;
  List<String>? referees;

  MatchModel(
      {this.competition,
      this.season,
      this.id,
      this.utcDate,
      this.status,
      this.matchday,
      this.stage,
      this.lastUpdated,
      this.homeTeam,
      this.awayTeam,
      this.score,
      this.referees});

  MatchModel.fromMap(Map<String, dynamic> json) {
    competition = json['competition'] != null ? Competition.fromMap(json['competition']) : null;
    season = json['season'] != null ? Season.fromMap(json['season']) : null;
    id = json['id'];
    utcDate = json['utcDate'];
    status = json['status'];
    matchday = json['matchday'];
    stage = json['stage'];
    lastUpdated = json['lastUpdated'];
    homeTeam = json['homeTeam'] != null ? HomeTeam.fromMap(json['homeTeam']) : null;
    awayTeam = json['awayTeam'] != null ? HomeTeam.fromMap(json['awayTeam']) : null;
    score = json['score'] != null ? Score.fromMap(json['score']) : null;
    if (json['referees'] != null) {
      referees = <String>[];
      json['referees'].forEach((v) {
        referees!.add(v.toString());
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (competition != null) {
      data['competition'] = competition!.toJson();
    }
    if (season != null) {
      data['season'] = season!.toJson();
    }
    data['id'] = id;
    data['utcDate'] = utcDate;
    data['status'] = status;
    data['matchday'] = matchday;
    data['stage'] = stage;
    data['lastUpdated'] = lastUpdated;
    if (homeTeam != null) {
      data['homeTeam'] = homeTeam!.toJson();
    }
    if (awayTeam != null) {
      data['awayTeam'] = awayTeam!.toJson();
    }
    if (score != null) {
      data['score'] = score!.toJson();
    }
    if (referees != null) {
      data['referees'] = referees!.map((v) => v).toList();
    }
    return data;
  }
}

class Competition {
  int? id;
  String? name;
  String? code;
  String? type;
  String? emblem;

  Competition({this.id, this.name, this.code, this.type, this.emblem});

  Competition.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    emblem = json['emblem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['type'] = type;
    data['emblem'] = emblem;
    return data;
  }
}

class Season {
  int? id;
  String? startDate;
  String? endDate;
  int? currentMatchday;
  String? winner;

  Season({this.id, this.startDate, this.endDate, this.currentMatchday, this.winner});

  Season.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    currentMatchday = json['currentMatchday'];
    winner = json['winner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['currentMatchday'] = currentMatchday;
    data['winner'] = winner;
    return data;
  }
}

class HomeTeam {
  int? id;
  String? name;
  String? shortName;
  String? tla;
  String? crest;

  HomeTeam({this.id, this.name, this.shortName, this.tla, this.crest});

  HomeTeam.fromMap(Map<String, dynamic> json) {
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

class Score {
  String? winner;
  String? duration;
  FullTime? fullTime;
  FullTime? halfTime;

  Score({this.winner, this.duration, this.fullTime, this.halfTime});

  Score.fromMap(Map<String, dynamic> json) {
    winner = json['winner'];
    duration = json['duration'];
    fullTime = json['fullTime'] != null ? FullTime.fromMap(json['fullTime']) : null;
    halfTime = json['halfTime'] != null ? FullTime.fromMap(json['halfTime']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['winner'] = winner;
    data['duration'] = duration;
    if (fullTime != null) {
      data['fullTime'] = fullTime!.toJson();
    }
    if (halfTime != null) {
      data['halfTime'] = halfTime!.toJson();
    }
    return data;
  }
}

class FullTime {
  int? home;
  int? away;

  FullTime({this.home, this.away});

  FullTime.fromMap(Map<String, dynamic> json) {
    home = json['home'];
    away = json['away'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['home'] = home;
    data['away'] = away;
    return data;
  }
}
