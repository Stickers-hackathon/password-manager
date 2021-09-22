// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Alarm _$_$_AlarmFromJson(Map<String, dynamic> json) {
  return _$_Alarm(
    id: json['id'] as int,
    site: json['site'] as String,
    userId: json['userId'] as String,
    mail: json['mail'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$_$_AlarmToJson(_$_Alarm instance) => <String, dynamic>{
      'id': instance.id,
      'site': instance.site,
      'userId': instance.userId,
      'mail': instance.mail,
      'password': instance.password,
    };
