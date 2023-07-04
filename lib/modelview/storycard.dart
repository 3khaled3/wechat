import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/modelview/storesmodel.dart';
import '../cubits/stores_cubit/stores_cubit.dart';
import '../views/story_view.dart';

// ignore: camel_case_types
class StoryCard extends StatelessWidget {
  const StoryCard({Key? key, required this.uid}) : super(key: key);
  final String uid;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoresCubit, StoresState>(builder: (context, state) {
      return FutureBuilder<Map<String, dynamic>?>(
          future: BlocProvider.of<StoresCubit>(context).getUserProfile(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {}

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            const profilimage =
                "https://firebasestorage.googleapis.com/v0/b/wechat-d43c1.appspot.com/o/new.png?alt=media&token=49771bf0-f6b9-4254-8e98-4f0b474f25d2";
            Map<String, dynamic>? userProfile = snapshot.data;

            if (userProfile != null &&
                FirebaseAuth.instance.currentUser != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 180,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(userProfile['storyURL'][0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      List<StoryModel> storyModels = [];
                      List listconvert = userProfile['storyURL'];
                      for (var i = 0; i < listconvert.length; i++) {
                        StoryModel storyurl =
                            StoryModel(userProfile['storyURL'][i]);
                        storyModels.add(storyurl);
                      }
                      UserModel user = UserModel(
                        imageUrl: userProfile['profileimage'] ?? profilimage,
                        stories: storyModels,
                        userName: userProfile['email'] ==
                                FirebaseAuth.instance.currentUser!.email
                            ? "You Story"
                            : userProfile['displayName'],
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoryView(user: user),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          CircleAvatar(
                            maxRadius: 26,
                            child: CircleAvatar(
                              backgroundImage: userProfile['profileimage'] ==
                                      null
                                  ? const AssetImage("assets/new.png")
                                  : NetworkImage(userProfile['profileimage'])
                                      as ImageProvider<Object>,
                              maxRadius: 23,
                            ),
                          ),
                          Card(
                            color: const Color.fromARGB(0, 255, 193, 7),
                            child: Text(
                              userProfile['email'] ==
                                      FirebaseAuth.instance.currentUser!.email
                                  ? "You Story"
                                  : userProfile['displayName'],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          });
    });
  }
}
