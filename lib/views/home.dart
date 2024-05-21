import 'package:flutter/material.dart';
import 'package:sports_app/core/extensions.dart';
import 'package:sports_app/core/padding_borders.dart';
import 'package:sports_app/views/fixture.dart';
import 'package:sports_app/views/stats.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> with SingleTickerProviderStateMixin {
  final List<String> _leagues = ["premier-league", "turkish-super-league", "bundesliga", "league-1"];
  String _currentLeague = "premier-league";
  late final TabController _tabController;
  final List<Widget> _tabs = [
    Container(alignment: Alignment.center, height: 35, child: const Text("Fixtures")),
    Container(alignment: Alignment.center, height: 35, child: const Text("Stats")),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.red, Colors.blue])),
                height: 120,
                alignment: Alignment.center,
                padding: PaddingBorderConstant.paddingOnlyTopMedium,
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _leagues
                        .map((e) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentLeague = e;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                margin: const EdgeInsets.only(left: 20),
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: _currentLeague == e ? Border.all(color: Colors.blue, width: 3) : null,
                                  image: DecorationImage(
                                    image: AssetImage("assets/leagues/$e.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.red, Colors.blue])),
                child: TabBar(
                  overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                  tabs: _tabs,
                  controller: _tabController,
                  unselectedLabelColor: Colors.yellow,
                  labelColor: Colors.white,
                  indicatorColor: Colors.blue,
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: context.deviceWidth * 0.9,
                  child: TabBarView(
                    controller: _tabController,
                    children: const [Fixture(), Stats()],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
