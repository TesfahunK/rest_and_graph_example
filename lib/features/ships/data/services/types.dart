class BasicFailure {
  final String message;
  final String? title;
  BasicFailure({
    required this.message,
    this.title,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BasicFailure &&
        other.message == message &&
        other.title == title;
  }

  @override
  int get hashCode => message.hashCode ^ title.hashCode;
}
