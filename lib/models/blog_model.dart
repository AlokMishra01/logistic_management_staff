class BlogModel {
  int? id;
  String? title;
  String? permalink;
  String? description;
  String? image;
  String? file;
  String? link;
  String? isActive;
  String? publishDate;
  String? createdAt;
  String? updatedAt;

  BlogModel({
    this.id,
    this.title,
    this.permalink,
    this.description,
    this.image,
    this.file,
    this.link,
    this.isActive,
    this.publishDate,
    this.createdAt,
    this.updatedAt,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["title"] is String) this.title = json["title"];
    if (json["permalink"] is String) this.permalink = json["permalink"];
    if (json["description"] is String) this.description = json["description"];
    if (json["image"] is String) this.image = json["image"];
    if (json["file"] is String) this.file = json["file"];
    if (json["file"] is String) this.link = json["link"];
    if (json["is_active"] is String) this.isActive = json["is_active"];
    if (json["publish_date"] is String) this.publishDate = json["publish_date"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
  }
}
