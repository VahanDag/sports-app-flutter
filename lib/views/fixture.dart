import 'package:flutter/material.dart';
import 'package:sports_app/core/extensions.dart';
import 'package:sports_app/core/padding_borders.dart';
import 'package:sports_app/views/match_detail.dart';

class Fixture extends StatefulWidget {
  const Fixture({super.key});

  @override
  State<Fixture> createState() => _FixtureState();
}

class _FixtureState extends State<Fixture> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MatchDetail(),
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
                        clubImageUrl: "assets/leagues/liverpool.png",
                        clubName: "Liverpool",
                        isLeft: true,
                      ),
                    ),
                    Expanded(
                      child: _matchSegment(
                        isLeft: false,
                        clubName: "Chelsea",
                        clubImageUrl: "assets/leagues/chelsea.png",
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: -20,
                  child: _matchInfoCircle(isPlaying: false, matchDate: "17:00"),
                )
              ],
            ),
          ),
        );
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
          color: const Color.fromARGB(255, 78, 82, 117),
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
      decoration:
          BoxDecoration(color: const Color.fromARGB(255, 78, 82, 117), borderRadius: PaddingBorderConstant.borderRadiusHigh),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: PaddingBorderConstant.paddingOnlyBottomLow,
            width: 60,
            height: 60,
            child: Image.asset(clubImageUrl),
          ),
          Text(clubName, style: context.textTheme.titleSmall?.copyWith(color: Colors.white))
        ],
      ),
    );
  }
}
