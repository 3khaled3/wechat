

class UserModel {
  UserModel(
      {required this.stories, required this.userName, required this.imageUrl});

  final List<StoryModel> stories;
  final String userName;
  final String imageUrl;
}

class StoryModel {
  StoryModel(this.imageUrl);

  final String imageUrl;
}