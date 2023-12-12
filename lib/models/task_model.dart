import 'dart:convert';

class TaskModel {
  int? id;
  String? title ;
  String? note;
  int? isCompleted ;
  String? date ;
  String? startTime ;
  String? endTime ;
  int? color;
  int? remind;
  String? repeat;

  TaskModel({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat
  });
  //object json
  Map<String,dynamic> toJson(){
    return {
      'id' : id,
      'title' : title,
      'note' : note,
      'isCompleted' : isCompleted,
      'date' : date,
      'startTime' : startTime,
      'endTime' : endTime,
      'color' : color,
      'remind' : remind,
      'repeat' : repeat,
    };
  }

  factory TaskModel.fromMap(Map<String,dynamic> map){
    return TaskModel(
      id: map['id'],
      title: map['title'],
      note: map['note'],
      isCompleted: map['isCompleted'],
      date: map['date'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      color: map['color'],
      remind: map['remind'],
      repeat: map['repeat']
    );
  }

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source));

}