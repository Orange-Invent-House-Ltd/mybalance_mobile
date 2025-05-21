// class NotificationModel {
//   NotificationModel({
//     required this.title,
//     required this.description,
//     required this.isRead,
//     required this.timestamp,
//   });
//   final String title;
//   final String description;
//   final bool isRead;
//   final DateTime timestamp;
// }

// List<NotificationModel> notify = [
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: false,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: false,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: false,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: false,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: false,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: false,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
//   NotificationModel(
//     title: 'You have locked 10,000',
//     description: 'For White pair of Air Jordans For White pair of ',
//     isRead: true,
//     timestamp: DateTime.now(),
//   ),
// ];

class Notification {
  final int user;
  final String category;
  final String content;
  final String id;
  final String title;
  final bool isSeen;
  final String actionUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Notification({
    required this.user,
    required this.category,
    required this.content,
    required this.id,
    required this.title,
    required this.isSeen,
    required this.actionUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      user: json['user'],
      category: json['category'],
      content: json['content'],
      id: json['id'],
      title: json['title'],
      isSeen: json['isSeen'],
      actionUrl: json['actionUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
