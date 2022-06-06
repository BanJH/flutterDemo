import 'dart:async';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notes/utils/note_db_helper.dart';


import '/entity/note.dart';
import '/utils/event_bus.dart';
import 'read.dart';
import '/utils/time_utils.dart';

class ListPage extends StatefulWidget {
  //构造方法传入全局数据库操作类
  const ListPage({Key? key,
  @required this.noteDbHelper,
  }) : super(key: key);

  final NoteDbHelper? noteDbHelper;
  @override
  State<ListPage> createState() => _ListPageState();
}

//继承实现了AutomaticKeepAliveClientMixin用来保证切换页面后数据不会丢失销毁
class _ListPageState extends State<ListPage>
 with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 5,keepScrollOffset: true);
  //记录列表的数量
  int _size = 0;
  //记录列表的数量
  List<Note> _noteList = [];
  //EventBus通信类
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    //注册和监听t发送来的UserEven类型事件、数据
    subscription = eventBus.on<NoteEvent>().listen((NoteEvent event) {
      _onRefresh();
    });

    _scrollController.addListener(() {
      //滚动监听
    });
    //刷新加载数据
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        child: CustomScrollView(
          shrinkWrap: false,
          primary: false,
          //回弹效果
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: _scrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(height: 10,),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      //列表的Item布局和数据绑定
                      return InkWell(
                        child: index % 2 == 0?getItem(index) : getImageItem(index),
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return ReadPage(
                                  noteDbHelper: widget.noteDbHelper,
                                  id: _noteList.elementAt(index).id,
                              );
                            })
                          );
                        },
                        onLongPress: () {
                          _showBottomSheet(index, context);

                        },
                      );
                    },
                  childCount: _size,
                ),
            ),
          ],

        ),
        onRefresh: _onRefresh,
      ),
    );
  }

  //长按列表弹窗
  _showBottomSheet(int index, BuildContext c) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.content_copy),
                title: Text('复制'),
                onTap: () async {
                  Clipboard.setData(
                    ClipboardData(text: _noteList.elementAt(index).content));
                    Scaffold.of(c).showSnackBar(SnackBar(
                        content: Text('已经复制到剪贴板'),
                      backgroundColor: Colors.black87,
                      duration: Duration(seconds: 2,),
                    ),

                  );
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_sweep),
                title: Text('删除'),
                onTap: () async {
                  widget.noteDbHelper!.deleteById(_noteList.elementAt(index).id);
                  setState(() {
                    _noteList.removeAt(index);
                    _size = _noteList.length;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }

  //刷新
  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1),() {
      print('refresh');
      widget.noteDbHelper!.getDatabase().then((database) {
        database
        .query('notes',orderBy: 'time DESC')
            .then((List<Map<String,dynamic>> records) {
              _size = records.length;
              _noteList.clear();
              for(int i = 0; i< records.length; i++) {
                _noteList.add(Note.fromMap(records.elementAt(i)));
              }
              setState(() {
                print(_noteList.length);
              });
        });
      });
    });
  }


  Widget getItem(int index) {
    return Container(
      child: Card(
        margin:  EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Row(
                    children: <Widget>[
                      Text("${DateTime.fromMillisecondsSinceEpoch(_noteList.elementAt(index).time as int).day}",
                        style: TextStyle(
                          color:  Color.fromRGBO(52, 52, 54, 1),
                          fontSize: 50,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "星期${TimeUtils.getWeekday(DateTime.fromMillisecondsSinceEpoch(_noteList.elementAt(index).time as int).weekday)}",
                            style: TextStyle(
                              color: Color.fromRGBO(149, 149, 149, 1),
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            TimeUtils.getDate(
                              DateTime.fromMillisecondsSinceEpoch(
                                _noteList.elementAt(index).time as int
                              ),
                            ),
                            style: TextStyle(
                              color: Color.fromRGBO(149, 149, 149, 1),
                              fontSize: 18,
                            ),
                          ),
                        ],

                      ),

                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(0, 5, 20, 5),
                      child: Icon(
                        Icons.wb_sunny,
                        size: 50,
                        color: Color.fromRGBO(252, 205, 24, 1),
                      ),
                    ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                _noteList.elementAt(index).content as String,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color.fromRGBO(103, 103, 103, 1),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getImageItem(int index) {
    return Container(
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        _noteList.length == 0?"":"${DateTime.fromMillisecondsSinceEpoch((_noteList.elementAt(index).time as int)).day}",
                        style: TextStyle(
                          color: Color.fromRGBO(52, 52, 54, 1),
                          fontSize: 50,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _noteList.length == 0?"":"星期${TimeUtils.getWeekday(DateTime.fromMillisecondsSinceEpoch((_noteList.elementAt(index).time as int)).weekday)}",
                            style: TextStyle(
                              color: Color.fromRGBO(149, 149, 148, 1),
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            _noteList.length == 0?"":TimeUtils.getDate(DateTime.fromMillisecondsSinceEpoch((_noteList.elementAt(index).time as int))),
                            style: TextStyle(
                              color: Color.fromRGBO(149, 149, 148, 1),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(0, 5, 20, 5),
                      child: Icon(
                        Icons.wb_sunny,
                        size: 50,
                        color: Color.fromRGBO(252, 205, 24, 1),
                      ),
                    ),
                ),
              ],

            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image(
                      image: AssetImage('assets/images/123.png'),
                      height: 108,
                      width: 108,
                      fit: BoxFit.cover,
                    ),

                  ),
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          _noteList.elementAt(index).content as String,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromRGBO(103, 103, 103, 1),
                            fontSize: 18,
                          ),
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
        

      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

  }

  //保证数据留存
  @override
  bool get wantKeepAlive => true;




}
