class RecipeModel {
  String label;
  String image;
  String source;
  String url;

  RecipeModel(
      {this.url = "url",
      this.source = "source",
      this.image = "image",
      this.label = "label"});

  factory RecipeModel.fromMap(Map<String, dynamic> parsedJson) {
    return RecipeModel(
        url: parsedJson["url"],
        source: parsedJson["source"],
        image: parsedJson["image"],
        label: parsedJson["label"]);
  }
}
