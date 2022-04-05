String getEmoji(int val) {
  String path = 'assets/emoji/';
  if (val >= 80) {
    return path + 'surprised.png';
  } else if (val >= 60) {
    return path + 'smiley.png';
  } else if (val >= 40) {
    return path + 'worried.png';
  } else if (val >= 20) {
    return path + 'sad.png';
  } else {
    return path + 'crying.png';
  }
}
