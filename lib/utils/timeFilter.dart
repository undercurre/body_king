int calculateAge(DateTime birthday) {
  DateTime today = DateTime.now();
  int age = today.year - birthday.year;

  // 如果当前日期在生日之前，则年龄减去1
  if (today.month < birthday.month || (today.month == birthday.month && today.day < birthday.day)) {
    age--;
  }
  return age;
}
