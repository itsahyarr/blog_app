int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  // consider reading speed is 225 words per minute
  // speed = d/t
  // t = d/speed

  // final readingTime = 225 / wordCount;
  final readingTime = wordCount / 225;

  return readingTime.ceil();
}
