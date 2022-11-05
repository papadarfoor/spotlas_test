import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:spotlas_test/provider/liked_provider.dart';
import 'package:spotlas_test/provider/list_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotlas_test/widgets/bold_text.dart';
import 'package:spotlas_test/widgets/custom_text.dart';
import 'package:jiffy/jiffy.dart';
import '../provider/saved_provider.dart';
import 'package:expandable_text/expandable_text.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    List feed = Provider.of<FeedListProvider>(context, listen: true).feed;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feed',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Consumer<FeedListProvider>(
        builder: ((context, value, child) {
          if (value.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SafeArea(
                child: ListView.builder(
                    itemCount: feed.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      List media = jsonDecode(feed[index].mediaImage);
                      List spots = jsonDecode(feed[index].spots);
                      List tags = [];

                      if ((feed[index].tags.isNotEmpty)) {
                        tags = jsonDecode(feed[index].tags);
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 500,
                            width: MediaQuery.of(context).size.width,
                            child: PageView.builder(
                                itemCount: media.length,
                                itemBuilder: (context, i) {
                                  return Stack(
                                    children: [
                                      SizedBox(
                                        height: 500,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: GestureDetector(
                                          onDoubleTap: () async {
                                            OverlayState? overlayState =
                                                Overlay.of(context);
                                            OverlayEntry overlayEntry =
                                                OverlayEntry(
                                              builder: (context) {
                                                return Center(
                                                  
                                                    child: SvgPicture.asset(
                                                      'developer-test_assets_2022-02-03_v7/Heart.svg',
                                                      color: Colors.pink,
                                                    ));
                                              },
                                            );
                                            context
                                                .read<LikedProvider>()
                                                .getLiked(context, feed[index],
                                                    index);
                                            if (feed[index].liked == false) {
                                              overlayState.insert(overlayEntry);
                                              await Future.delayed(
                                                  const Duration(seconds: 1));
                                              overlayEntry.remove();
                                            }
                                          },
                                          child: Image.network(
                                            media[i]['url'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.pink[600],
                                              radius: 25,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage:
                                                        NetworkImage(feed[index]
                                                            .authorProfilePicture)),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                BoldText(
                                                    text: feed[index]
                                                        .authorUsername),
                                                CustomText(
                                                    text: feed[index]
                                                        .authorFullName)
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 8,
                                        left: 8,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                255,
                                                                255,
                                                                255),
                                                        radius: 25,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: CircleAvatar(
                                                              radius: 20,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      feed[index]
                                                                          .logo)),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          BoldText(
                                                              text: feed[index]
                                                                  .spotName),
                                                          BoldText(
                                                            text: spots[0]
                                                                    ['name'] +
                                                                ' • ' +
                                                                feed[index]
                                                                    .location,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                208,
                                                                208,
                                                                208),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 24.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                SavedProvider>()
                                                            .getSaved(
                                                                context,
                                                                feed[index],
                                                                index);
                                                      },
                                                      child: Consumer<
                                                          SavedProvider>(
                                                        builder: (context,
                                                            value, child) {
                                                          return SvgPicture
                                                              .asset(
                                                            feed[index].saved
                                                                ? 'developer-test_assets_2022-02-03_v7/Star.svg'
                                                                : 'developer-test_assets_2022-02-03_v7/Star Border.svg',
                                                            color: feed[index]
                                                                    .saved
                                                                ? Colors.amber
                                                                : Colors.white,
                                                            width: 20,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 48, right: 48, top: 20, bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  'developer-test_assets_2022-02-03_v7/Map Border.svg',
                                  width: 20,
                                ),
                                SvgPicture.asset(
                                  'developer-test_assets_2022-02-03_v7/Comment.svg',
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<LikedProvider>()
                                        .getLiked(context, feed[index], index);
                                  },
                                  child: Consumer<LikedProvider>(
                                    builder: (context, value, child) {
                                      return SvgPicture.asset(
                                        feed[index].liked
                                            ? 'developer-test_assets_2022-02-03_v7/Heart.svg'
                                            : 'developer-test_assets_2022-02-03_v7/Heart Border.svg',
                                        color: feed[index].liked
                                            ? Colors.pink
                                            : Colors.black,
                                        width: 20,
                                      );
                                    },
                                  ),
                                ),
                                SvgPicture.asset(
                                  'developer-test_assets_2022-02-03_v7/Paper Plane Border.svg',
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: ExpandableText(
                              feed[index].caption,
                              prefixText: feed[index].authorUsername,
                              prefixStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              expandText: 'more...',
                              collapseText: 'less',
                              maxLines: 2,
                              linkColor: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                                itemCount: tags.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: ((context, e) {
                                  return tags[e]['display_text'].isEmpty
                                      ? Container()
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Card(
                                              elevation: 5,
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    tags[e]['display_text'],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )),
                                            )
                                          ],
                                        );
                                })),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              Jiffy(feed[index].createdAt).fromNow(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                      );
                    }));
          }
        }),
      ),
    );
  }
}
