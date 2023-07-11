class NotificationModel {
  int? id;
  String? userId;
  String? description;
  String? page;
  int? pageId;
  bool? viewed;
  String? createdAt;
  String? title;

  NotificationModel(
      {this.id,
      this.userId,
      this.description,
      this.page,
      this.pageId,
      this.viewed,
      this.title,
      this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    description = json['description'];
    page = json['page'];
    pageId = json['pageId'];
    title = json['title'];
    viewed = json['viewed'];
    createdAt = json['createdAt'];
  }
}

class AlertResponse {
  final int unViewed;

  final List<NotificationModel> alerts;

  AlertResponse({required this.unViewed, required this.alerts});

  factory AlertResponse.fromJson(Map<String, dynamic> json) => AlertResponse(
      unViewed: json["unViewed"],
      alerts: List<NotificationModel>.from((json["alerts"] as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList()));
}
