String upperFirstLetter(String string) {
  List<String> s = string.toLowerCase().split('');
  s[0] = s[0].toUpperCase();
  return s.join();
}
