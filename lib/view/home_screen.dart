import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_channels_headlines_model.dart';
import 'package:news_app/view/categories_screen.dart';
import 'package:news_app/view/news_details_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';
import '../models/categories_news_model.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

enum FilterList { bbcNews, googleNewsIn, abcNews }

class _Home_ScreenState extends State<Home_Screen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  final format = DateFormat("MMMM dd, yy ");

  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesScreen()));
          },
          icon: Icon(Icons.menu),
        ),
        title: Text(
          "News",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton<FilterList>(
              initialValue: selectedMenu,
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                if (FilterList.abcNews.name == item.name) {
                  name = 'abc-news';
                }
                if(FilterList.googleNewsIn.name == item.name)
                  {
                    name = 'google-news-in';
                  }

                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem(
                        value: FilterList.bbcNews, child: Text('BBC News')),
                    const PopupMenuItem(
                        value: FilterList.abcNews,
                        child: Text('ABC News')),
                    const PopupMenuItem(
                        value: FilterList.googleNewsIn,
                        child: Text('News India'))
                  ])
        ],
        elevation: 20,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.indigoAccent,
                      size: 40,
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return InkWell(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsDetailsScreen(
                                newsImage: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                newsTitle: snapshot
                                    .data!.articles![index].title
                                    .toString(),
                                newsDate: snapshot
                                    .data!.articles![index].publishedAt
                                    .toString(),
                                author: snapshot
                                    .data!.articles![index].author
                                    .toString(),
                                description: snapshot
                                    .data!.articles![index].description
                                    .toString(),
                                content: snapshot
                                    .data!.articles![index].content
                                    .toString(),
                                source: snapshot
                                    .data!.articles![index].source!.name
                                    .toString())));
                          },
                          child: SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * 0.6,
                                  width: width * 0.9,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * .02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: spinkit2,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error,
                                              color: Colors.redAccent),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white54,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      height: height * 0.22,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width * 0.7,
                                            child: Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width * 0.75,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  snapshot.data!.articles![index]
                                                      .source!.name
                                                      .toString(),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi('general'),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.indigoAccent,
                      size: 40,
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return InkWell(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsDetailsScreen(
                                newsImage: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                newsTitle: snapshot
                                    .data!.articles![index].title
                                    .toString(),
                                newsDate: snapshot
                                    .data!.articles![index].publishedAt
                                    .toString(),
                                author: snapshot
                                    .data!.articles![index].author
                                    .toString(),
                                description: snapshot
                                    .data!.articles![index].description
                                    .toString(),
                                content: snapshot
                                    .data!.articles![index].content
                                    .toString(),
                                source: snapshot
                                    .data!.articles![index].source!.name
                                    .toString())));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    height: height * 0.18,
                                    width: width * 0.3,
                                    placeholder: (context, url) => Container(
                                      child: spinkit2,
                                    ),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error,
                                        color: Colors.redAccent),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                      height: height * 0.18,
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index].title
                                                .toString(),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  final spinkit2 = const SpinKitFadingCircle(
    color: Colors.amber,
    size: 50,
  );
}
