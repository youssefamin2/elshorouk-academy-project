class Courses {
  String? id;
  String? name;
  String? teacherName;
  Lectures? lectures;
  List<String>? studentsEnroll;

  Courses({
    this.id,
    this.name,
    this.teacherName,
    this.lectures,
    this.studentsEnroll,
  });

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['name'];
    teacherName = json['teacherName'];
    studentsEnroll = json['students'] != null ? List<String>.from(json['students']) : [];
    lectures = json['lectures'] != null ? Lectures.fromJson(json['lectures']) : Lectures(data: []);
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'name': name,
      'teacherName': teacherName,
      'students': studentsEnroll ?? [],
      'lectures': lectures?.toMap(),
    };
  }
}

class Lectures {
  List<LectureData> data;

  Lectures({required this.data});

  Lectures.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List<dynamic>?)
      ?.map((e) => LectureData.fromJson(e))
      .toList() ??
      [];

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((lecture) => lecture.toMap()).toList(),
    };
  }
}

class LectureData {
  String name;
  String date;
  int numStudents;
  List<String> students;

  LectureData({
    required this.name,
    required this.date,
    required this.numStudents,
    required this.students,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'numStudents': numStudents,
      'students': students,
    };
  }

  factory LectureData.fromJson(Map<String, dynamic> json) {
    return LectureData(
      name: json['name'] ?? '',
      date: json['date'] ?? '',
      numStudents: json['numStudents'] ?? 0,
      students: List<String>.from(json['students'] ?? []),
    );
  }
}
