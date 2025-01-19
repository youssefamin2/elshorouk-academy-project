class Students {
  String? id; // Student ID
  String? name; // Student name
  List<AttendedLecture>? attendedLectures; // List of lectures the student attended

  // Constructor
  Students({
    this.id,
    this.name,
    this.attendedLectures,
  });

  // From JSON
  Students.fromJson(Map<String, dynamic> json) {
    id = json['ID']; // Firestore 'ID' field
    name = json['name']; // Firestore 'name' field
    if (json['attendedLectures'] != null) {
      attendedLectures = (json['attendedLectures'] as List)
          .map((lecture) => AttendedLecture.fromJson(lecture))
          .toList();
    }
  }

  // To Map (Firestore format)
  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'name': name,
      'attendedLectures': attendedLectures?.map((lecture) => lecture.toMap()).toList(),
    };
  }
}

class AttendedLecture {
  String? lectureID; // ID of the lecture
  String? courseID; // ID of the course

  // Constructor
  AttendedLecture({
    this.lectureID,
    this.courseID,
  });

  // From JSON
  AttendedLecture.fromJson(Map<String, dynamic> json) {
    lectureID = json['lectureID']; // Firestore 'lectureID' field
    courseID = json['courseID']; // Firestore 'courseID' field
  }

  // To Map (Firestore format)
  Map<String, dynamic> toMap() {
    return {
      'lectureID': lectureID,
      'courseID': courseID,
    };
  }
}
