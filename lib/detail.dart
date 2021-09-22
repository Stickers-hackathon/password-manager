import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:mezamashi_denwa/state/alarm_list.dart';
import 'package:flutter/services.dart';

class Detail extends StatelessWidget {
  Detail(this.site, this.userId, this.mail, this.password);
  String site, userId, mail, password;

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<AlarmListStateNotifier, AlarmList>(
      create: (context) => AlarmListStateNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
        ),
        body: ListView(
          children: [
            _tile(site),
            _tile(userId),
          _tile(mail),
          _tile(password)],
        )
      )
    );
  }

  Widget _tile (String text) {
    return ListTile(
      title: Text(text),
      trailing: new IconButton(
          icon: Icon(
            Icons.content_copy,
            color: Colors.grey[500],
            size: 45.0,
          ),
          onPressed: () async {
            final data = ClipboardData(text: text);
            await Clipboard.setData(data);
          }),
    );
  }
}