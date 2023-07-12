// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:story/story.dart';
import '../modelview/storesmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StoryView extends StatefulWidget {
  const StoryView({super.key, required this.user});
  final UserModel user;
  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  List<UserModel> sampleUsers = [];
  @override
  void initState() {
    sampleUsers.add(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryPageView(
        itemBuilder: (context, pageIndex, storyIndex) {
          final user = sampleUsers[pageIndex];
          final story = user.stories[storyIndex];
          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: Colors.black,
                ),
              ),
         Positioned.fill(
      child:      _buildStoryImage(story),),
              Padding(
                padding: const EdgeInsets.only(top: 44, left: 8),
                child: Row(
                  children: [
                    _BuildUserImage(user),
                    const SizedBox(
                      width: 8,
                    ),
                    _BuildUsername(user),
                  ],
                ),
              ),
            ],
          );
        },
        gestureItemBuilder: (context, pageIndex, storyIndex) {
          return Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: IconButton(
                padding: EdgeInsets.zero,
                color: Colors.white,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
        },
        pageLength: sampleUsers.length,
        storyLength: (int pageIndex) {
          return sampleUsers[pageIndex].stories.length;
        },
        onPageLimitReached: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Text _BuildUsername(UserModel user) {
    return Text(
      user.userName,
      style: const TextStyle(
        fontSize: 17,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container _BuildUserImage(UserModel user) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(user.imageUrl),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );
  }

   _buildStoryImage(StoryModel story) {
    return CachedNetworkImage(
        imageUrl: story.imageUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            _buildCircleIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    
  }

   _buildCircleIndicator() {
    return
       Container(
          color: Colors.black,
          child: LoadingAnimationWidget.newtonCradle(
            color: Colors.white,
            size: 140,
          ));
  }
}
