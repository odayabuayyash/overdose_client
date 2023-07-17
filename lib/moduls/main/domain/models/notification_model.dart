class Notifi {
  int id;
  String title;
  String description;
  String created_at;
  Notifi(this.id, this.title, this.description, this.created_at);
}

class Notifications {
  List<Notifi>? notifications;
  Notifications(this.notifications);
}
