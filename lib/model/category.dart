import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  Categories({
    this.status,
    this.count,
    this.pages,
    this.category,
    this.posts,
  });

  String ? status;
  int ? count;
  int ? pages;
  Category ? category;
  List<Post> ? posts;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    status: json["status"],
    count: json["count"],
    pages: json["pages"],
    category: Category.fromJson(json["category"]),
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "count": count,
    "pages": pages,
    "category": category!.toJson(),
    "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.slug,
    this.title,
    this.description,
    this.parent,
    this.postCount,
  });

  int ? id;
  String? slug;
  String ?title;
  String ?description;
  int ? parent;
  int ?postCount;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    slug: json["slug"],
    title: json["title"],
    description: json["description"],
    parent: json["parent"] == null ? null : json["parent"],
    postCount: json["post_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "title": title,
    "description": description,
    "parent": parent == null ? null : parent,
    "post_count": postCount,
  };
}

class Post {
  Post({
    this.id,
    this.type,
    this.slug,
    this.url,
    this.status,
    this.title,
    this.titlePlain,
    this.content,
    this.excerpt,
    this.date,
    this.modified,
    this.categories,
    this.tags,
    this.author,
    this.comments,
    this.attachments,
    this.commentCount,
    this.commentStatus,
    this.thumbnail,
    this.customFields,
    this.thumbnailSize,
    this.thumbnailImages,
  });

  int ? id;
  Type ?type;
  String ?slug;
  String ?url;
  Status ?status;
  String ?title;
  String ?titlePlain;
  String ?content;
  String ?excerpt;
  DateTime ? date;
  DateTime ? modified;
  List<Category> ? categories;
  List<Category> ?tags;
  Author ? author;
  List<dynamic> ?comments;
  List<Attachment>? attachments;
  int ? commentCount;
  CommentStatus ? commentStatus;
  String ?thumbnail;
  Map<String, List<String>> ?customFields;
  ThumbnailSize ? thumbnailSize;
  Map<String, image>? thumbnailImages;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    type: typeValues.map![json["type"]],
    slug: json["slug"],
    url: json["url"],
    status: statusValues.map![json["status"]],
    title: json["title"],
    titlePlain: json["title_plain"],
    content: json["content"],
    excerpt: json["excerpt"],
    date: DateTime.parse(json["date"]),
    modified: DateTime.parse(json["modified"]),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    tags: List<Category>.from(json["tags"].map((x) => Category.fromJson(x))),
    author: Author.fromJson(json["author"]),
    comments: List<dynamic>.from(json["comments"].map((x) => x)),
    attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
    commentCount: json["comment_count"],
    commentStatus: commentStatusValues.map![json["comment_status"]],
    customFields: Map.from(json["custom_fields"]).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": typeValues.reverse[type],
    "slug": slug,
    "url": url,
    "status": statusValues.reverse[status],
    "title": title,
    "title_plain": titlePlain,
    "content": content,
    "excerpt": excerpt,
    "date": date!.toIso8601String(),
    "modified": modified!.toIso8601String(),
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags!.map((x) => x.toJson())),
    "author": author!.toJson(),
    "comments": List<dynamic>.from(comments!.map((x) => x)),
    "attachments": List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "comment_count": commentCount,
    "comment_status": commentStatusValues.reverse[commentStatus],
    "thumbnail": thumbnail,
    "custom_fields": Map.from(customFields!).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
    "thumbnail_size": thumbnailSizeValues.reverse[thumbnailSize],
    "thumbnail_images": Map.from(thumbnailImages!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Attachment {
  Attachment({
    this.id,
    this.url,
    this.slug,
    this.title,
    this.description,
    this.caption,
    this.parent,
    this.mimeType,
    this.images,
  });

  int ?id;
  String ?url;
  String ?slug;
  String ?title;
  Description? description;
  String ?caption;
  int ?parent;
  MimeType ?mimeType;
  Map<String, image> ?images;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["id"],
    url: json["url"],
    slug: json["slug"],
    title: json["title"],
    description: descriptionValues.map![json["description"]],
    caption: json["caption"],
    parent: json["parent"],
    mimeType: mimeTypeValues.map![json["mime_type"]],
    images: Map.from(json["images"]).map((k, v) => MapEntry<String, image>(k, image.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "slug": slug,
    "title": title,
    "description": descriptionValues.reverse[description],
    "caption": caption,
    "parent": parent,
    "mime_type": mimeTypeValues.reverse[mimeType],
    "images": Map.from(images!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

enum Description { THE_SUICIDE_SQUAD, EMPTY, THE_75172022 }

final descriptionValues = EnumValues({
  "": Description.EMPTY,
  "مهرجان كان السينمائى .. إقامة الدورة الـ 75 17 مايو 2022": Description.THE_75172022,
  "سيلفستر ستالون وجون سينا في صورة من كواليس The Suicide Squad": Description.THE_SUICIDE_SQUAD
});

class image {
  image({
    this.url,
    this.width,
    this.height,
  });

  String? url;
  int ?width;
  int ?height;

  factory image.fromJson(Map<String, dynamic> json) => image(
    url: json["url"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
  };
}

enum MimeType { IMAGE_JPEG }

final mimeTypeValues = EnumValues({
  "image/jpeg": MimeType.IMAGE_JPEG
});

class Author {
  Author({
    this.id,
    this.slug,
    this.name,
    this.firstName,
    this.lastName,
    this.nickname,
    this.url,
    this.description,
  });

  int ?id;
  String ?slug;
  String ?name;
  String ?firstName;
  String ?lastName;
  String ?nickname;
  String ?url;
  String ?description;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    nickname: json["nickname"],
    url: json["url"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "first_name": firstName,
    "last_name": lastName,
    "nickname": nickname,
    "url": url,
    "description": description,
  };
}

enum CommentStatus { CLOSED }

final commentStatusValues = EnumValues({
  "closed": CommentStatus.CLOSED
});

enum Status { PUBLISH }

final statusValues = EnumValues({
  "publish": Status.PUBLISH
});

enum ThumbnailSize { THUMBNAIL }

final thumbnailSizeValues = EnumValues({
  "thumbnail": ThumbnailSize.THUMBNAIL
});

enum Type { POST }

final typeValues = EnumValues({
  "post": Type.POST
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String> ?reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
