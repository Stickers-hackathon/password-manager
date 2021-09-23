import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:mezamashi_denwa/state/alarm_list.dart';
import 'package:mezamashi_denwa/storage/alarm_list.dart';
import 'package:provider/provider.dart';
import 'detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<AlarmListStateNotifier, AlarmList>(
      create: (context) => AlarmListStateNotifier(),
      child: MaterialApp(
        home: _ChangeFormState(),
      ),
    );
  }
}

class _ChangeFormState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var initialState = context.read<AlarmListStateNotifier>().state.alarmList;
    if (initialState.isEmpty) {
      () async {
        final storage = new Storage();
        initialState = await storage.getAlarmList();
        context.read<AlarmListStateNotifier>().setAlarmList(initialState);
      }();
    }

    return Scaffold(
        appBar: AppBar(title: Text('Password Manager'), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addPopUp(context)
          )
        ]),
        body: _buildList(context));
  }

  Widget _buildList(BuildContext context) {
    final alarmListState =
        context.select<AlarmList, List<Alarm>>((state) => state.alarmList);

    return Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: alarmListState.length,
          itemBuilder: (context, index) {
            return Builder(builder: (context) {
              return _buildTile(alarmListState[index], index, context);
            });
          },
        ));
  }

  Widget _buildTile(Alarm alarm, int i, BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
        decoration: new BoxDecoration(
        border: new Border(bottom: new BorderSide(color: Colors.grey),),),
    child: ListTile(
        leading: new IconButton(
            icon: Icon(
              Icons.block,
              color: Colors.grey[500],
              size: 40.0,
            ),
            onPressed: () async {
              final storage = Storage();
              storage.deleteAlarm(alarm.id);
              context.read<AlarmListStateNotifier>().removeAlarmListItem(i);
            }),
        title: Text("${alarm.site}"),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Detail(alarm.site, alarm.userId, alarm.mail, alarm.password)),
      )
    ));
  }
}

void _addPopUp(BuildContext context) {
  String site="", id ="", mail="", password="";

  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("追加"),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 24,
          ),
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "サイト名",
              ),
              onChanged: (string) {
                site = string;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "ID",
              ),
              onChanged: (string) {
                id = string;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "メールアドレス",
              ),
              onChanged: (string) {
                mail = string;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "パスワード",
              ),
              onChanged: (string) {
                password = string;
              },
            ),
            InkWell(
              child: Container(
                  margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("OK",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  )),
              onTap: () async {
                final storage = new Storage();
                final nextId = await storage.getNextAlarmId();
                final newAlarm = Alarm().copyWith(id: nextId, site: site, userId: id, mail: mail, password: password);
                final successful = await storage.addAlarm(newAlarm);
                if (successful) context.read<AlarmListStateNotifier>().addAlarmList(newAlarm);
                Navigator.pop(context);
                },
            ),
          ],
        );
      });
}