// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 2;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      id: fields[0] as String,
      taskGroup: fields[1] as String,
      taskIcon: fields[2] as String,
      taskGroupColor: fields[3] as int,
      taskName: fields[4] as String,
      taskDescription: fields[5] as String,
      startDate: fields[6] as String,
      startTime: fields[7] as String,
      endDate: fields[8] as String,
      endTime: fields[9] as String,
      status: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskGroup)
      ..writeByte(2)
      ..write(obj.taskIcon)
      ..writeByte(3)
      ..write(obj.taskGroupColor)
      ..writeByte(4)
      ..write(obj.taskName)
      ..writeByte(5)
      ..write(obj.taskDescription)
      ..writeByte(6)
      ..write(obj.startDate)
      ..writeByte(7)
      ..write(obj.startTime)
      ..writeByte(8)
      ..write(obj.endDate)
      ..writeByte(9)
      ..write(obj.endTime)
      ..writeByte(10)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
