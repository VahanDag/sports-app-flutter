import 'package:flutter/material.dart';
import 'package:sports_app/core/extensions.dart';
import 'package:sports_app/core/padding_borders.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: context.deviceWidth * 0.9,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: PaddingBorderConstant.paddingVerticalHigh,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: PaddingBorderConstant.borderRadiusHigh),
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: PaddingBorderConstant.borderRadiusHigh,
                              image: const DecorationImage(
                                  fit: BoxFit.cover, image: AssetImage("assets/leagues/champions-league.png"))),
                          height: 200,
                          width: double.infinity,
                        ),
                        ListTile(
                          title: Text("GALA won UCL!", style: context.textTheme.titleLarge),
                          subtitle: const Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              "Magna officia et incididunt dolore. Sit incididunt ipsum sunt aliqua dolor labore adipisicing adipisicing consectetur consectetur."),
                          trailing: IconButton(
                              enableFeedback: false, onPressed: () {}, icon: const Icon(Icons.bookmark_border_rounded)),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
