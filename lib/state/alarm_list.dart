import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'alarm_list.freezed.dart';
part 'alarm_list.g.dart';

@freezed
class AlarmList with _$AlarmList {
  const factory AlarmList({@Default([]) List<Alarm> alarmList}) = _AlarmList;
}

@freezed
class Alarm with _$Alarm {
  const factory Alarm(
      {
        @JsonKey(name: "id") @Default(0) int id,
        @JsonKey(name: "site") @Default("") String site,
        @JsonKey(name: "userId") @Default("") String userId,
        @JsonKey(name: "mail") @Default("") String mail,
        @JsonKey(name: "password") @Default("") String password,
      }) = _Alarm;

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);
}

class AlarmListStateNotifier extends StateNotifier<AlarmList> {
  AlarmListStateNotifier() : super(AlarmList());

  void setAlarmList(List<Alarm> alarmList) {
    state = state.copyWith(alarmList: alarmList);
  }

  void addAlarmList(Alarm alarm) {
    final newAlarmList = List<Alarm>.from(state.alarmList);
    newAlarmList.add(alarm);
    state = state.copyWith(alarmList: newAlarmList);
  }

  void removeAlarmListItem(int index) {
    final newAlarmList = List<Alarm>.from(state.alarmList);
    newAlarmList.removeAt(index);
    state = state.copyWith(alarmList: newAlarmList);
  }
}
