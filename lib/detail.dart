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
            _tile("サイト", true),
            _tile(site, false),
            _tile("ID", true),
            _tile(userId, false),
            _tile("メールアドレス", true),
            _tile(mail, false),
            _tile("パスワード", true),
            _tile(password, false)],
        )
      )
    );
  }

  Widget _tile (String text, bool gray) {
    return ListTile(
      tileColor: gray ? Colors.grey : Colors.white,
      title: Text(text),
      trailing: new IconButton(
          icon: Icon(
            Icons.content_copy,
            color: Colors.grey[500],
            size: 40.0,
          ),
          onPressed: () async {
            final data = ClipboardData(text: text);
            await Clipboard.setData(data);
          }),
    );
  }
}