import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;
  const NewsDetailsScreen(
      {required this.newsImage,
      required this.newsTitle,
      required this.newsDate,
      required this.author,
      required this.description,
      required this.content,
      required this.source,
      super.key});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    final format = DateFormat("MMMM dd, yy ");
    DateTime dateTime = DateTime.parse(widget.newsDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 20,
        title: Text(
          widget.source,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 27),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Container(
              height: height * 0.45,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: widget.newsImage,
                  fit: BoxFit.cover,
                  placeholder: (context, ulr) =>
                      Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ),
          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .4),
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: ListView(
              children: [
                Text(
                  widget.newsTitle,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.red),
                ),
                SizedBox(height: height * .02),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      widget.source,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueAccent),
                    )),
                    Text(
                      format.format(dateTime),
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueAccent),
                    ),
                  ],
                ),
                SizedBox(height: height * .03),
                Text(
                  widget.description,
                  style: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: height * .02),
                Text(
                  widget.content,
                  style: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: height * .02),
                Text(
                  widget.author,
                  style: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
