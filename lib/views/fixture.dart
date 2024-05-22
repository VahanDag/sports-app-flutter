import 'package:flutter/material.dart';
import 'package:sports_app/core/constants.dart';
import 'package:sports_app/core/enums.dart';
import 'package:sports_app/core/extensions.dart';
import 'package:sports_app/core/padding_borders.dart';
import 'package:sports_app/core/useful_functions.dart';
import 'package:sports_app/service/football_service.dart';
import 'package:sports_app/views/match_detail.dart';
import 'package:sports_app/views/statistics.dart';

class Fixture extends StatefulWidget {
  const Fixture({
    super.key,
    required this.leagueCode,
  });
  final LeagueCode leagueCode;

  @override
  State<Fixture> createState() => _MatchModeltate();
}

class _MatchModeltate extends State<Fixture> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FootballService.matchFixture(widget.leagueCode),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("ERROR"));
        } else {
          final data = snapshot.data;
          if (data?.isEmpty ?? true) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.sports_basketball, size: 100, color: Colors.grey),
                infoText(context: context, infoMessage: "The season is over")
              ],
            ));
          } else {
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                final match = data[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MatchDetail(
                            leagueCode: widget.leagueCode,
                            match: match,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _matchSegment(
                                clubImageUrl: match.homeTeam?.crest ?? "",
                                clubName: match.homeTeam?.name ?? "",
                                isLeft: true,
                              ),
                            ),
                            Expanded(
                              child: _matchSegment(
                                isLeft: false,
                                clubName: match.awayTeam?.name ?? "",
                                clubImageUrl: match.awayTeam?.crest ?? "",
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: -20,
                          child: _matchInfoCircle(
                              isPlaying: !AppConstants.statusList.contains(match.status),
                              matchDate: AppConstants.statusList.contains(match.status)
                                  ? extractHour(match.utcDate ?? "")
                                  : "${match.score?.halfTime?.home} - ${match.score?.halfTime?.away}"),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }
      },
    );
  }

  Container _matchInfoCircle({required bool isPlaying, String? score, String? matchDate}) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 10, strokeAlign: BorderSide.strokeAlignOutside),
          gradient: const LinearGradient(colors: [Color(0xff2C3E50), Color(0xff4CA1AF)]),
          shape: BoxShape.circle),
      child: Text(isPlaying ? score! : matchDate!, style: context.textTheme.titleSmall?.copyWith(color: Colors.white)),
    );
  }

  Container _matchSegment({
    required bool isLeft,
    required String clubName,
    required String clubImageUrl,
  }) {
    return Container(
      margin: isLeft ? PaddingBorderConstant.paddingOnlyRight : PaddingBorderConstant.paddingOnlyLeft,
      height: 125,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xff42275a), Color(0xff734b6d)]),
          borderRadius: PaddingBorderConstant.borderRadiusHigh),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: PaddingBorderConstant.paddingOnlyBottomLow,
            width: 60,
            height: 60,
            child: DynamicImage(imageUrl: clubImageUrl),
          ),
          Text(clubName, style: context.textTheme.titleSmall?.copyWith(color: Colors.white))
        ],
      ),
    );
  }
}
//Color(0xff2C3E50), Color(0xffFD746C)
