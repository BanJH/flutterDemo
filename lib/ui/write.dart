import 'package:flutter/material.dart';
import 'package:flutter_notes/entity/note.dart';
import 'package:flutter_notes/ui/list.dart';
import 'package:flutter_notes/utils/event_bus.dart';
import 'package:oktoast/oktoast.dart';
import '/utils/note_db_helper.dart';
import '/utils/event_bus.dart';

class WritePage extends StatefulWidget {
  const WritePage({Key? key,
    @required this.noteDbHelper,
    @required this.id,
  }) : super(key: key);

  final NoteDbHelper? noteDbHelper;
  final int? id;
  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  String? notes = "";
  
  @override
  void initState() {
    super.initState();
    if(widget.id != -1) {
      widget.noteDbHelper!.getNoteById(widget.id!).then((note) {
        setState(() {
          notes = note!.content;
        });
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        title: Text("书写日记"),
        actions: <Widget>[
          FlatButton(
              onPressed: (){
                save(context);
              },
              child: Text(
                '保存',
                style: TextStyle(fontSize: 16),
              ),
             splashColor: Colors.white,
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                  color: Colors.white,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  padding: EdgeInsets.only(left: 16.0,right: 16.0,top: 8.0,bottom: 4.0),
                  child: TextField(
                    controller: TextEditingController.fromValue(TextEditingValue(
                      //设置内容
                      text: notes!,
                      //保持光标在最后
                      selection: TextSelection.fromPosition(
                        TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: notes!.length,
                        )
                      ),
                    )),
                    onChanged: (text){
                      setState(() {
                        notes = text;
                      });
                    },
                    maxLines: null,
                    style: TextStyle(),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration.collapsed(hintText: '点此输入你的内容'),
                  ),
                ),
            ),
            Row(
              children: <Widget>[
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.wb_sunny,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.star,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }





  void save(BuildContext context) {
    if(notes!.trim().length == 0){
      showToast('不能为空');
      return;
    }
    showToast('已经保存');
    Note note = Note();
    note.title = '日记';
    note.content = notes;
    note.time = DateTime.now().millisecondsSinceEpoch;
    note.star = 0;
    note.weather = 0;
    if(widget.id != -1) {
      note.id = widget.id;
      widget.noteDbHelper!.update(note);
    } else {
      widget.noteDbHelper!.insert(note);
      //发送事件、数据
      eventBus.fire(NoteEvent(widget.id));

    }
    Navigator.pop(context);

  }

  @override
  void dispose() {
    super.dispose();
  }

}
