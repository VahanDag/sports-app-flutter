import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sports_app/core/extensions.dart';
import 'package:sports_app/core/padding_borders.dart';
import 'package:sports_app/views/stats.dart';

class MatchDetail extends StatefulWidget {
  const MatchDetail({super.key});

  @override
  State<MatchDetail> createState() => MatchDetailState();
}

class MatchDetailState extends State<MatchDetail> with TickerProviderStateMixin {
  late final TabController _tabInfoController;
  late final PageController _pageController;
  final List<String> _info = ["Timeline", "Lineups", "Stats", "News"];
  late String _currentInfo;

  final List<Widget> _pages = [
    const Timeline(),
    const Lineups(),
    Stats(textColor: Colors.white),
    const Text("data4"),
  ];

  @override
  void initState() {
    _tabInfoController = TabController(length: _info.length, vsync: this);
    _currentInfo = _info[0];
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xff780206), Color(0xff061161)])),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 60, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage("assets/leagues/chelsea.png")))),
                        ClipRect(
                          clipBehavior: Clip.antiAlias,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: PaddingBorderConstant.paddingAll,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: PaddingBorderConstant.borderRadiusHigh),
                              child: Row(
                                children: [
                                  const Text("3",
                                      style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding: PaddingBorderConstant.paddingHorizontal,
                                    child: CircularPercentIndicator(
                                        radius: 30,
                                        lineWidth: 5,
                                        percent: 0.75,
                                        circularStrokeCap: CircularStrokeCap.round,
                                        progressColor: Colors.amber.shade700,
                                        center: const Text("63",
                                            style:
                                                TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500))),
                                  ),
                                  const Text("2",
                                      style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage("assets/leagues/liverpool.png")))),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.keyboard_double_arrow_left_sharp),
                      label: const Text("Fixtures"))
                ],
              )),
          Positioned(
            left: 0,
            right: 0,
            top: context.deviceHeight * 0.35,
            bottom: 0,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  gradient: LinearGradient(
                      end: Alignment.topRight, begin: Alignment.bottomLeft, colors: [Color(0xff283048), Color(0xff859398)])),
              child: Column(
                children: [
                  Container(
                    margin: PaddingBorderConstant.paddingAll,
                    height: 35,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _info.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: PaddingBorderConstant.paddingHorizontalLow,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(_currentInfo == _info[index] ? Colors.amber : null)),
                              onPressed: () {
                                setState(() {
                                  _currentInfo = _info[index];
                                  _pageController.jumpToPage(index);
                                });
                              },
                              child: Text(_info[index])),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          _currentInfo = _info[value];
                        });
                      },
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return _pages[index];
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Lineups extends StatefulWidget {
  const Lineups({super.key});

  @override
  State<Lineups> createState() => _LineupsState();
}

class _LineupsState extends State<Lineups> with TickerProviderStateMixin {
  late final TabController _tabLineupsController;
  final List<Widget> _tabs = [
    const Text("Liverpool"),
    const Text("Chelsea"),
  ];
  @override
  void initState() {
    _tabLineupsController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 35,
            width: context.deviceWidth * 0.75,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.red, borderRadius: PaddingBorderConstant.borderRadiusMedium),
            child: TabBar(
                dividerHeight: 0,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(color: Colors.deepPurple, borderRadius: PaddingBorderConstant.borderRadius),
                controller: _tabLineupsController,
                splashBorderRadius: PaddingBorderConstant.borderRadius,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                tabs: _tabs),
          ),
          Container(
            width: context.deviceWidth * 0.75,
            height: 350,
            decoration: BoxDecoration(color: Colors.green, borderRadius: PaddingBorderConstant.borderRadiusMedium),
            child: TabBarView(controller: _tabLineupsController, children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(backgroundColor: Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(backgroundColor: Colors.white),
                      CircleAvatar(backgroundColor: Colors.white),
                      CircleAvatar(backgroundColor: Colors.white),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(backgroundColor: Colors.white),
                      CircleAvatar(backgroundColor: Colors.white),
                      CircleAvatar(backgroundColor: Colors.white),
                      CircleAvatar(backgroundColor: Colors.white),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(backgroundColor: Colors.white),
                      CircleAvatar(backgroundColor: Colors.white),
                      CircleAvatar(backgroundColor: Colors.white),
                    ],
                  )
                ],
              ),
              Container(
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(backgroundColor: Colors.white),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(backgroundColor: Colors.white),
                        CircleAvatar(backgroundColor: Colors.white),
                        CircleAvatar(backgroundColor: Colors.white),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(backgroundColor: Colors.white),
                        CircleAvatar(backgroundColor: Colors.white),
                        CircleAvatar(backgroundColor: Colors.white),
                        CircleAvatar(backgroundColor: Colors.white),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(backgroundColor: Colors.white),
                        CircleAvatar(backgroundColor: Colors.white),
                        CircleAvatar(backgroundColor: Colors.white),
                      ],
                    )
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class Timeline extends StatelessWidget {
  const Timeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingBorderConstant.paddingVerticalHigh,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const VerticalDivider(
            color: Colors.grey,
            thickness: 3,
            width: 4,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _timelineContainer(context: context, isLeft: false),
                _timelineContainer(context: context, isLeft: true),
                _timelineContainer(context: context, isLeft: false),
                _timelineContainer(context: context, isLeft: true),
                _timelineContainer(context: context, isLeft: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _timelineContainer({required BuildContext context, required bool isLeft}) {
    return Align(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isLeft) _timelineTimeCircle(minute: 17, isLeft: true),
          Container(
            height: 40,
            width: context.deviceWidth / 3.5,
            margin: PaddingBorderConstant.paddingVerticalHigh,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.grey, Color(0xff373B44)]),
              borderRadius: isLeft
                  ? const BorderRadius.horizontal(right: Radius.circular(10))
                  : const BorderRadius.horizontal(left: Radius.circular(10)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Icardi", style: TextStyle(color: Colors.white)),
                Icon(
                  Icons.sports_soccer,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          if (isLeft) _timelineTimeCircle(minute: 49, isLeft: false)
        ],
      ),
    );
  }

  Container _timelineTimeCircle({required int minute, required bool isLeft}) {
    return Container(
      alignment: Alignment.center,
      margin: isLeft ? PaddingBorderConstant.paddingOnlyRightHigh : PaddingBorderConstant.paddingOnlyLeftHigh,
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
          shape: BoxShape.circle),
      child: Text("$minute'", style: const TextStyle(color: Colors.white)),
    );
  }
}
