abstract class TimeFormatingService {
  String formatTimeAgo(DateTime dateTime);
}

class TimeFormatingServiceImpl extends TimeFormatingService {
  @override
  String formatTimeAgo(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 1) {
      return 'just now';
    } else if (difference.inSeconds == 1) {
      return '1 second ago';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes == 1) {
      return '1 minute ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours == 1) {
      return '1 minute ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 7 && difference.inDays < 14) {
      return '1 week ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays >= 30 && difference.inDays < 60) {
      return '1 month ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} months ago';
    }
    if (difference.inDays >= 365 && difference.inDays < 730) {
      return '1 year ago';
    }
    return '${(difference.inDays / 365).floor()} years ago';
  }
}
