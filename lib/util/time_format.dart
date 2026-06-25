String convertTimestamp(DateTime timestamp) {
  final diffTime = DateTime.now().difference(timestamp);

  if (diffTime.inDays > 0) {
    return "${diffTime.inDays} วันที่แล้ว";
  } else if (diffTime.inHours > 0) {
    return "${diffTime.inHours} ชั่วโมงที่แล้ว";
  } else if (diffTime.inMinutes > 0) {
    return "${diffTime.inMinutes} นาทีที่แล้ว";
  } else if (diffTime.inSeconds > 0) {
    return "${diffTime.inSeconds} วินาที";
  } else {
    return "เมื่อซักครู่";
  }
}
