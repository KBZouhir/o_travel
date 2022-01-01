import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/Models/StoriesCompany.dart';
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/Models/story.dart';
import 'package:o_travel/api/company/auth.dart';
import 'package:o_travel/api/company/story_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:o_travel/screens/profile/company/compay_profile.dart';
import 'package:o_travel/screens/profile/company/show_company_profile.dart';
import 'package:story_view/story_view.dart';

class StoriesList extends StatelessWidget {
  final List<StoryCompany> storyList;
  final int id;
  final bool isCompany;

  const StoriesList({
    required this.storyList,
    Key? key,
    required this.id,
    required this.isCompany,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: storyList.length,
        padding: EdgeInsets.symmetric(horizontal: 5),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return StoryItemWidget(
            story: storyList[index], id: id, isCompany: isCompany,);
        });
  }
}

class StoryItemWidget extends StatelessWidget {
  final StoryCompany story;
  final int id;
  final bool isCompany;

  const StoryItemWidget({
    Key? key,
    required this.story,
    required this.id,
    required this.isCompany,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return DetailStoryScreen(story, id, isCompany);
            });
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Theme
                    .of(context)
                    .primaryColor
                    .withOpacity(0.4),
                width: 4),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: CachedNetworkImage(
              imageUrl: story.image,
              fit: BoxFit.cover,
              width: 1000,
              height: 1000,
              placeholder: (context, url) =>
                  Center(
                      child: Container(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator(
                            color: Theme
                                .of(context)
                                .primaryColor,
                          ))),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailStoryScreen extends StatelessWidget {
  final StoryCompany story;
  final int id;
  final bool isCompany;

  DetailStoryScreen( this.story, this.id,
    this.isCompany);

  final fieldMessageController = TextEditingController();
  final storyController = StoryController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Container(
            child: StoryView(
              inline: true,
              storyItems: List.generate(story.stories.length, (index) {
                return StoryItem.pageImage(
                  url: story.stories[index].imageUrl,
                  controller: storyController,
                );
              }),
              onStoryShow: (s) {
                print("Showing a story");
              },
              onComplete: () {
                Navigator.pop(context, true);
              },
              progressPosition: ProgressPosition.top,
              repeat: false,
              controller: storyController,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 70,
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .backgroundColor
                    .withOpacity(0.69),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              width: size.width,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      /* getCompanyById();
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ShowCompanyProfile(company: story)));*/
                    },
                    child: Row(
                      children: [
                        Hero(
                          tag: 'company_img_${story.id}',
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(story.image),
                            maxRadius: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              story.name,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(1),
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  Spacer(),
                  (isCompany && id == story.id) ? Card(
                      color: Colors.redAccent.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                          height: 40,
                          width: 40,
                          child: IconButton(
                              onPressed: () {
                                deleteStory(story.id).then((value) {
                                  Navigator.pop(context, true);
                                  HomeScreen.setStories(context);
                                });
                              },
                              icon: Icon(
                                Icons.delete_outlined,
                                color: Colors.white,
                              )))) : SizedBox(),
                ],
              ),
            ),
          ),
          /* Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Theme.of(context).backgroundColor.withOpacity(0.5),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: fieldMessageController,
                    onSubmitted: (String str) {},
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary.withOpacity(1)),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      filled: false,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.zero,
                      hintText: getTranslated(context, 'write_message'),
                    ),
                  )),
            ),
          )*/
        ],
      ),
    );
  }
}

class AddStory extends StatefulWidget {
  const AddStory({Key? key, required this.image}) : super(key: key);
  final File image;

  @override
  _AddStoryState createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Stack(
        children: [
          ClipRRect(
            child: Image.file(
              widget.image,
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(raduice),
              ),
              child: MaterialButton(
                onPressed: () {
                  createStory(widget.image);
                  Navigator.pop(context,true);
                },
                color: Theme
                    .of(context)
                    .backgroundColor,
                child: Text(
                  getTranslated(context, 'add_story'),
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Card(
                color: Theme
                    .of(context)
                    .backgroundColor
                    .withOpacity(0.7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                    height: 40,
                    width: 40,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context,false);
                        },
                        icon: Icon(Icons.close)))),
          )
        ],
      ),
    );
  }
}
