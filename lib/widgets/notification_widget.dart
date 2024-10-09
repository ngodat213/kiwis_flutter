import 'package:flutter/material.dart';

/// A widget that displays a notification with two states: read and unread.
///
/// This widget can be used to show notifications in the application,
/// with the ability to customize colors based on the read state, as well as
/// handle actions when the user interacts with the notification.
class NotificationWidget extends StatelessWidget {
  /// The title of the notification.
  final String title;

  /// The detailed content of the notification.
  final String content;

  /// The read state of the notification.
  /// `true` if the notification has been read, `false` if unread.
  final bool isRead;

  /// Callback function called when the user taps the Dismiss button.
  final VoidCallback? onDismiss;

  /// Callback function called when the user taps the Comment button.
  final VoidCallback? onComment;

  /// Creates a [NotificationWidget].
  ///
  /// [title] and [content] are required.
  /// [isRead] defaults to `false`.
  /// [onDismiss] and [onComment] are optional and can be used
  /// to handle corresponding actions.
  const NotificationWidget({
    Key? key,
    required this.title,
    required this.content,
    this.isRead = false,
    this.onDismiss,
    this.onComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isRead ? Colors.grey[300] : Colors.green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications_none, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: onDismiss,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: onDismiss,
                  child: Text('Dismiss'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: isRead ? Colors.grey[600] : Colors.green,
                    backgroundColor: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: onComment,
                  child: Text('Comment'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: isRead ? Colors.grey[600] : Colors.green,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
