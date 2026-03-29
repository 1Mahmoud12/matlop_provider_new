class NotificationModel {
  int? currentPage;
  List<NotificationData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<PageLink>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  NotificationModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      currentPage: json['current_page'] ?? -1,
      data: (json['data'] as List?)?.map((item) => NotificationData.fromJson(item)).toList() ?? [],
      firstPageUrl: json['first_page_url'] ?? '',
      from: json['from'] ?? -1,
      lastPage: json['last_page'] ?? -1,
      lastPageUrl: json['last_page_url'] ?? '',
      links: (json['links'] as List?)?.map((item) => PageLink.fromJson(item)).toList() ?? [],
      nextPageUrl: json['next_page_url'] ?? '',
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? -1,
      prevPageUrl: json['prev_page_url'] ?? '',
      to: json['to'] ?? -1,
      total: json['total'] ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data?.map((item) => item.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links?.map((item) => item.toJson()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

class NotificationData {
  int? id;
  int? userId;
  String? title;
  String? comment;
  String? url;
  int? seen;
  int? isAdmin;
  String? createdAt;
  String? updatedAt;
  String? createdAtHumanDate;

  NotificationData({
    this.id,
    this.userId,
    this.title,
    this.comment,
    this.url,
    this.seen,
    this.isAdmin,
    this.createdAt,
    this.updatedAt,
    this.createdAtHumanDate,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'] ?? -1,
      userId: json['user_id'] ?? -1,
      title: json['title'] ?? '',
      comment: json['comment'] ?? '',
      url: json['url'] ?? '',
      seen: json['seen'] ?? -1,
      isAdmin: json['is_admin'] ?? -1,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAtHumanDate: json['created_at_human_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'comment': comment,
      'url': url,
      'seen': seen,
      'is_admin': isAdmin,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_at_human_date': createdAtHumanDate,
    };
  }
}

class PageLink {
  String? url;
  String? label;
  bool? active;

  PageLink({
    this.url,
    this.label,
    this.active,
  });

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
      url: json['url'] ?? '',
      label: json['label'] ?? '',
      active: json['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}
