import 'package:flutter/material.dart';
import 'package:flutter_notes/entity/note.dart';
import 'package:flutter_notes/ui/write.dart';
import 'package:flutter_notes/utils/time_utils.dart';
import '/utils/note_db_helper.dart';
import '/utils/event_bus.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({
    Key? key,
    @required this.noteDbHelper,
    @required this.id,
  }) : super(key: key);

  final NoteDbHelper? noteDbHelper;
  final int? id;
  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage>
 with WidgetsBindingObserver {

  String? note = "";
  late Note noteEntity;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    widget.noteDbHelper!.getNoteById(widget.id as int).then((notes) {

      setState(() {
        note = notes!.content;
        noteEntity = notes;

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        title: Text('日记详情'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) {
                        return WritePage(
                            noteDbHelper: widget.noteDbHelper,
                            id: widget.id,
                        );
                      }
                  ),
                );
              },
              icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Container(
        child: CustomScrollView(
          shrinkWrap: false,
          primary: false,
          //回弹效果
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(height: 10,),

            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(50, 5, 10, 5),
                        child: Icon(
                          Icons.wb_sunny,
                          size: 50,
                          color: Color.fromRGBO(252, 205, 24, 1),
                        ),
                      ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '星期${TimeUtils.getWeekday(DateTime
                              .fromMillisecondsSinceEpoch(noteEntity.time as int).weekday)}',
                          style: TextStyle(
                            color: Color.fromRGBO(149, 149, 149, 1),
                            fontSize: 18,
                          ),
                        ),
                        Text(
                            TimeUtils.getDateTime(
                              DateTime.fromMillisecondsSinceEpoch(
                                noteEntity.time as int
                              ),
                            ),
                          style: TextStyle(
                            color: Color.fromRGBO(149, 149, 149, 1),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  note as String,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }

  //当移除渲染树的时候调用
  @override
  void deactivate() {
    super.deactivate();
    var bool = ModalRoute.of(context)!.isCurrent;
    if(bool) {
      widget.noteDbHelper!.getNoteById(widget.id as int).then((notes) {
        setState(() {
          note = notes!.content;
        });
      } );
      //发送事件、数据
      eventBus.fire(NoteEvent(widget.id) );
    }
  }

  //APP生命周期监听
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if(state == AppLifecycleState.resumed) {
      //恢复可见
      widget.noteDbHelper!.getNoteById(widget.id as int).then((notes) {
        setState(() {
          note = notes!.content;
        });
      });
    }else if( state == AppLifecycleState.paused) {
      //处在并不活动状态，无法处理用户响应
      //例如来电，画中画，弹框
    } else if( state == AppLifecycleState.inactive) {
      //不可见，后台运行，无法处理用户响应
    } else if(state == AppLifecycleState.detached ) {
      //应用被立刻暂停挂起，ios上不会回调
    }
    super.didChangeAppLifecycleState(state);
  }

  //组件即将销毁时调用
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }



}
