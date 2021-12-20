class UserProfile {
  UserInProfile user;

  UserProfile({this.user});

  UserProfile.fromJson(Map<String, dynamic> json) {
    user =
        json['user'] != null ? new UserInProfile.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class UserInProfile {
  String username;
  String email;
  bool isVipMember;
  List<Memberships> memberships;

  UserInProfile(
      {this.username, this.email, this.isVipMember, this.memberships});

  UserInProfile.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    isVipMember = json['isVipMember'];
    if (json['memberships'] != null) {
      memberships = new List<Memberships>();
      json['memberships'].forEach((v) {
        memberships.add(new Memberships.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['isVipMember'] = this.isVipMember;
    if (this.memberships != null) {
      data['memberships'] = this.memberships.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Memberships {
  int id;
  int planId;
  Plan plan;

  Memberships({this.id, this.planId, this.plan});

  Memberships.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json['plan_id'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_id'] = this.planId;
    if (this.plan != null) {
      data['plan'] = this.plan.toJson();
    }
    return data;
  }
}

class Plan {
  int id;
  String name;
  String slug;
  Post post;

  Plan({this.id, this.name, this.slug, this.post});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    if (this.post != null) {
      data['post'] = this.post.toJson();
    }
    return data;
  }
}

class Post {
  int iD;
  String postAuthor;
  String postDate;
  String postDateGmt;
  String postContent;
  String postTitle;
  String postExcerpt;
  String postStatus;
  String commentStatus;
  String pingStatus;
  String postPassword;
  String postName;
  String toPing;
  String pinged;
  String postModified;
  String postModifiedGmt;
  String postContentFiltered;
  int postParent;
  String guid;
  int menuOrder;
  String postType;
  String postMimeType;
  String commentCount;
  String filter;

  Post(
      {this.iD,
      this.postAuthor,
      this.postDate,
      this.postDateGmt,
      this.postContent,
      this.postTitle,
      this.postExcerpt,
      this.postStatus,
      this.commentStatus,
      this.pingStatus,
      this.postPassword,
      this.postName,
      this.toPing,
      this.pinged,
      this.postModified,
      this.postModifiedGmt,
      this.postContentFiltered,
      this.postParent,
      this.guid,
      this.menuOrder,
      this.postType,
      this.postMimeType,
      this.commentCount,
      this.filter});

  Post.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    postAuthor = json['post_author'];
    postDate = json['post_date'];
    postDateGmt = json['post_date_gmt'];
    postContent = json['post_content'];
    postTitle = json['post_title'];
    postExcerpt = json['post_excerpt'];
    postStatus = json['post_status'];
    commentStatus = json['comment_status'];
    pingStatus = json['ping_status'];
    postPassword = json['post_password'];
    postName = json['post_name'];
    toPing = json['to_ping'];
    pinged = json['pinged'];
    postModified = json['post_modified'];
    postModifiedGmt = json['post_modified_gmt'];
    postContentFiltered = json['post_content_filtered'];
    postParent = json['post_parent'];
    guid = json['guid'];
    menuOrder = json['menu_order'];
    postType = json['post_type'];
    postMimeType = json['post_mime_type'];
    commentCount = json['comment_count'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['post_author'] = this.postAuthor;
    data['post_date'] = this.postDate;
    data['post_date_gmt'] = this.postDateGmt;
    data['post_content'] = this.postContent;
    data['post_title'] = this.postTitle;
    data['post_excerpt'] = this.postExcerpt;
    data['post_status'] = this.postStatus;
    data['comment_status'] = this.commentStatus;
    data['ping_status'] = this.pingStatus;
    data['post_password'] = this.postPassword;
    data['post_name'] = this.postName;
    data['to_ping'] = this.toPing;
    data['pinged'] = this.pinged;
    data['post_modified'] = this.postModified;
    data['post_modified_gmt'] = this.postModifiedGmt;
    data['post_content_filtered'] = this.postContentFiltered;
    data['post_parent'] = this.postParent;
    data['guid'] = this.guid;
    data['menu_order'] = this.menuOrder;
    data['post_type'] = this.postType;
    data['post_mime_type'] = this.postMimeType;
    data['comment_count'] = this.commentCount;
    data['filter'] = this.filter;
    return data;
  }
}
