// Widget لـ LectureChipsWidget
import 'dart:developer';

import 'package:edu_vista/models/course.dart';
import 'package:edu_vista/models/lecture.dart';
import 'package:edu_vista/utils/app_enums.dart';
import 'package:flutter/material.dart';

class LectureChipsWidget extends StatelessWidget {
  final CourseOptions selectedOption;
  final Function(CourseOptions) onChanged;

  const LectureChipsWidget({
    Key? key,
    required this.selectedOption,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: CourseOptions.values.map((option) {
        return ChoiceChip(
          label: Text(option.toString().split('.').last),
          selected: selectedOption == option,
          onSelected: (selected) {
            if (selected) onChanged(option);
          },
        );
      }).toList(),
    );
  }
}

// Widget لـ CourseOptionsWidgets
class CourseOptionsWidgets extends StatelessWidget {
  final Course course;
  final CourseOptions courseOption;
  final Function(Lecture) onLectureChosen;

  const CourseOptionsWidgets({
    super.key,
    required this.course,
    required this.courseOption,
    required this.onLectureChosen,
  });

  @override
  Widget build(BuildContext context) {
    if (course.lectures == null || course.lectures!.isEmpty) {
      return const Center(child: Text('No lectures available'));
    }
    return ListView.builder(
      itemCount: course.lectures!.length,
      itemBuilder: (context, index) {
        final lecture = course.lectures![index];
        final url = lecture.lecture_url;
        log(url ?? 'no urlllllllllllllllllllllllllllllllllllllllllll');
        return ListTile(
          title: Text(lecture.title ?? 'No Title'),
          onTap: () {
            onLectureChosen(lecture);
          },
        );
      },
    );
  }
}
