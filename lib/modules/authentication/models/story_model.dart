class StoryModel {
  StoryModel(this.stories);

  final List<StoryData> stories;
}

class StoryData {
  StoryData(
      this.imageUrl,
      this.title,
      this.subTitle,
      );

  final String imageUrl;
  final String title;
  final String subTitle;
}