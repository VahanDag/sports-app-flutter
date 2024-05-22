// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sports_app/core/enums.dart';
import 'package:sports_app/core/extensions.dart';
import 'package:sports_app/core/padding_borders.dart';
import 'package:sports_app/core/useful_functions.dart';
import 'package:sports_app/models/club.dart';
import 'package:sports_app/views/statistics.dart';
import 'package:sports_app/views/stats.dart';

class ClubDetail extends StatefulWidget {
  const ClubDetail({
    super.key,
    required this.club,
  });

  final Club club;

  @override
  State<ClubDetail> createState() => _ClubDetailState();
}

class _ClubDetailState extends State<ClubDetail> {
  @override
  Widget build(BuildContext context) {
    final marketCap = calculateMarketCap(widget.club.marketCap);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: context.deviceWidth * 0.9,
            child: Column(
              children: [
                Card(
                  margin: PaddingBorderConstant.paddingVerticalHigh,
                  child: Container(
                    alignment: Alignment.center,
                    margin: PaddingBorderConstant.paddingHorizontalMedium,
                    height: 180,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.club.name.toUpperCase(),
                              style:
                                  context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 2),
                            ),
                            Text(
                              widget.club.country.toUpperCase(),
                              style: context.textTheme.labelMedium,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: PaddingBorderConstant.paddingOnlyRightHigh,
                                height: 100,
                                width: 100,
                                child: DynamicImage(imageUrl: widget.club.logo)),
                            Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: PaddingBorderConstant.borderRadius,
                                  gradient:
                                      LinearGradient(colors: [Colors.purple.withAlpha(150), Colors.blue.withAlpha(100)])),
                              child: const Text("1rd"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Market Cap"),
                                Text(
                                  marketCap[0],
                                  style: context.textTheme.headlineMedium,
                                ),
                                Text(marketCap.last == MarketCapEnum.million ? "Million €" : "Billion €")
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: PaddingBorderConstant.paddingVerticalHigh,
                  child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: PaddingBorderConstant.borderRadius,
                          image: DecorationImage(fit: BoxFit.cover, image: randomStadium())),
                      padding: PaddingBorderConstant.paddingAll,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: GlassBox(
                          height: 75,
                          width: 250,
                          child: Text(
                            widget.club.stadium.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: context.textTheme.titleLarge
                                ?.copyWith(color: Colors.white, letterSpacing: 3, fontWeight: FontWeight.w500),
                          ))),
                ),
                Card(
                  margin: PaddingBorderConstant.paddingVerticalHigh,
                  child: Container(
                    alignment: Alignment.center,
                    padding: PaddingBorderConstant.paddingAll,
                    width: double.infinity,
                    child: Text(
                      widget.club.coach,
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                ),
                Stats(
                  leagueCode:
                      LeagueCode.values.firstWhere((e) => e.name == widget.club.leagueCode, orElse: () => LeagueCode.PL),
                  clubNameHome: widget.club.name,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GlassBox extends StatelessWidget {
  const GlassBox({
    super.key,
    this.height,
    this.width,
    required this.child,
  });
  final double? height;
  final double? width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.antiAlias,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: PaddingBorderConstant.borderRadiusHigh,
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.1),
                  ])),
            ),
            child
          ],
        ),
      ),
    );
  }
}
