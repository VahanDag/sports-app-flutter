import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sports_app/core/extensions.dart';
import 'package:sports_app/core/padding_borders.dart';
import 'package:sports_app/core/useful_functions.dart';
import 'package:sports_app/models/club.dart';
import 'package:sports_app/views/club_detail.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late final TextEditingController _searchController;
  final List<Club> _clubs = [];

  @override
  void initState() {
    _searchController = TextEditingController();
    _fetchPopularClubs();
    super.initState();
  }

  String _searchValue = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<QueryDocumentSnapshot>> _search(String searchValue) async {
    if (_searchValue.isEmpty) {
      return [];
    } else {
      final response = await FirebaseFirestore.instance
          .collection("clubs")
          .where("name", isGreaterThanOrEqualTo: searchValue)
          .where("name", isLessThanOrEqualTo: '$searchValue\uf8ff')
          .get();
      print(response.docs);
      return response.docs;
    }
  }

  Future<void> _fetchPopularClubs() async {
    final response = await FirebaseFirestore.instance.collection("clubs").where("country", isEqualTo: "England").get();
    final data = response.docs;

    for (var club in data) {
      final clubElement = Club.fromMap(club.data());
      _clubs.add(clubElement);
      print(clubElement.name);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: context.deviceWidth * 0.9,
            child: Column(
              children: [
                Padding(
                  padding: PaddingBorderConstant.paddingOnlyTopMedium,
                  child: SearchBar(
                    controller: _searchController,
                    onSubmitted: (value) {
                      setState(() {
                        _searchValue = stringCapitalize(value);
                        _search(_searchValue);
                      });
                    },
                    textInputAction: TextInputAction.search,
                    hintText: "Search player or club",
                    hintStyle: const MaterialStatePropertyAll(TextStyle(color: Colors.grey, fontSize: 15)),
                    leading: const Icon(Icons.search),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _search(_searchValue),
                    initialData: const [],
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("Something went wrong :/"));
                      } else {
                        final data = snapshot.data as List;
                        if (data.isEmpty) {
                          return Padding(
                            padding: PaddingBorderConstant.paddingOnlyTopHigh,
                            child: Column(
                              children: [
                                const Text("Popular Clubs"),
                                const Divider(),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: _clubs.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final club = _clubs[index];
                                      return _clubTile(club);
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return ListView.builder(
                            padding: PaddingBorderConstant.paddingVertical,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final clubs = Club.fromMap(data[index].data());

                              return _clubTile(clubs);
                            },
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile _clubTile(Club club) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ClubDetail(club: club)));
      },
      trailing: const Icon(Icons.chevron_right_rounded),
      leading: SizedBox(height: 40, width: 40, child: DynamicImage(imageUrl: club.logo)),
      title: Text(club.name),
    );
  }
}

class DynamicImage extends StatelessWidget {
  final String imageUrl;

  const DynamicImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        placeholderBuilder: (context) => const CircularProgressIndicator(),
      );
    } else {
      return Image.network(
        imageUrl,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
      );
    }
  }
}
