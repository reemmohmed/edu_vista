import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/lecture.dart';

// تأكد من استيراد كلاس Lecture

class Course {
  String? id;
  String? title;
  String? image;
  String? currency;
  String? rank;
  bool? hasCertificate;
  double? price;
  double? rating;
  int? totalHours;
  DateTime? createdDate;
  String? videoUrl;
  String? description;
  List<Lecture>? lectures;

  // تعديل المنشئ ليشمل lectures
  Course.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    image = data['image'];
    currency = data['currency'];
    rank = data['rank'];
    hasCertificate = data['has_certificate'];
    price = data['price'] is int
        ? (data['price'] as int).toDouble()
        : data['price'];
    rating = data['rating'] is int
        ? (data['rating'] as int).toDouble()
        : data['rating'];
    totalHours = data['total_hours'];
    createdDate = data['created_date'] != null
        ? (data['created_date'] as Timestamp).toDate()
        : null;
    videoUrl = data['videoUrl'];
    //TODO: description not founded in firebase
    //description = data['description'];

    // هنا نتأكد من تحويل البيانات إلى List<Lecture> إذا كانت موجودة
    lectures = data['lectures'] != null
        ? List<Lecture>.from(
            data['lectures'].map((lecture) => Lecture.fromJson(lecture)))
        : [];
  }

  //TODO: The correct here to use this method to send data to firebase indsted of make it manually
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['currency'] = currency;
    data['rank'] = rank;
    data['has_certificate'] = hasCertificate;
    data['price'] = price;
    data['rating'] = rating;
    data['total_hours'] = totalHours;
    data['created_date'] = createdDate;
    data['video_url'] = videoUrl;
    data['description'] = description;

    // إضافة المحاضرات في قائمة JSON
    data['lectures'] = lectures != null
        ? lectures!.map((lecture) => lecture.toJson()).toList()
        : [];
    return data;
  }
}
