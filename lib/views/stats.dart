// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sports_app/core/enums.dart';
import 'package:sports_app/core/extensions.dart';
import 'package:sports_app/models/standings.dart';
import 'package:sports_app/service/football_service.dart';

class Stats extends StatefulWidget {
  const Stats({
    super.key,
    this.textColor,
    this.clubNameHome,
    this.clubNameAway,
    required this.leagueCode,
  });

  final Color? textColor;
  final String? clubNameHome;
  final String? clubNameAway;
  final LeagueCode leagueCode;

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FootballService.standings(widget.leagueCode),
      builder: (context, AsyncSnapshot<List<Standing>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("ERROR"));
        } else {
          final data = snapshot.data;
          if (data?.isEmpty ?? true) {
            return const Center(child: Text("No Standing table"));
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                    columnSpacing: 10,
                    columns: <DataColumn>[
                      DataColumn(label: _text(text: 'Club')),
                      DataColumn(label: _text(text: 'MP')),
                      DataColumn(label: _text(text: 'W')),
                      DataColumn(label: _text(text: 'D')),
                      DataColumn(label: _text(text: 'L')),
                      DataColumn(label: _text(text: 'GF')),
                      DataColumn(label: _text(text: 'GA')),
                      DataColumn(label: _text(text: 'GD')),
                      DataColumn(label: _text(text: 'Pts')),
                    ],
                    rows: List.generate(18, (index) {
                      final standing = data![index];
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _text(
                                    style: context.textTheme.titleSmall?.copyWith(color: widget.textColor),
                                    text: "${standing.position}- "),
                                _text(
                                    text: standing.team!.name!.trim(),
                                    style: context.textTheme.titleSmall?.copyWith(
                                        color: [widget.clubNameHome, widget.clubNameAway].contains(standing.team!.name!)
                                            ? Colors.blue
                                            : widget.textColor))
                              ],
                            ),
                          )), // 1'den başlayan indeks
                          DataCell(_text(text: standing.playedGames)),
                          DataCell(_text(text: standing.won)),
                          DataCell(_text(text: standing.draw)),
                          DataCell(_text(text: standing.lost)),
                          DataCell(_text(text: standing.goalsFor)),
                          DataCell(_text(text: standing.goalsAgainst)),
                          DataCell(_text(text: standing.goalDifference)),
                          DataCell(_text(
                            text: standing.points,
                            style: context.textTheme.titleSmall?.copyWith(color: widget.textColor),
                          )),
                        ],
                      );
                    })),
              ),
            );
          }
        }
      },
    );
  }

  Text _text({dynamic text, TextStyle? style}) => Text(text.toString(), style: style ?? TextStyle(color: widget.textColor));
}
