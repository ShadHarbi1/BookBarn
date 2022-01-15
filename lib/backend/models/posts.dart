class Post {
  String author;
  String user;

  String id;
  String title;
  String content;
  String address;
  String category;
  String price;
  String photo;

  Post(
      {this.user,
      this.title,
      this.category,
      this.content,
      this.address,
      this.price,
      this.id,
      this.photo,
      this.author});

  Post.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    id = json['_id'];
    title = json['title'];
    price = json['price'];
    user = json['user'];
    content = json['content'];
    category = json['category'];
    address = json['address'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['user'] = this.user;
    data['content'] = this.content;
    data['category'] = this.category;
    data['address'] = this.address;
    return data;
  }
}

class PostsList {
  List<Post> postsLists;

  PostsList({this.postsLists});

  factory PostsList.fromJson(List<dynamic> json) {
    return new PostsList(
        postsLists: json.map((i) => Post.fromJson(i)).toList());
  }
}
