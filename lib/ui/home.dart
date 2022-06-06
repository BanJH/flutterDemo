import 'package:flutter/material.dart';
import 'package:flutter_notes/ui/center.dart';
import 'package:flutter_notes/ui/list.dart';
import 'package:flutter_notes/utils/note_db_helper.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';

import 'search.dart';
import 'write.dart';
import 'calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //默认选中第一项
  int _selectedIndex = 0;
  var _pageController = new PageController(initialPage: 0,);
  int last = 0;
  int index = 0;

  late NoteDbHelper noteDbHelper;

  @override
  void initState() {
    super.initState();
    noteDbHelper = NoteDbHelper();
    getDatabasesPath().then((string) {
      String path = join(string ,'noteDb.db');
      noteDbHelper.open(path);
    });
    _pageController.addListener(() { });
  }

  //返回键拦截执行方法
  Future<bool> _onWillPop(){
    int now = DateTime.now().microsecondsSinceEpoch;
    print(now - last);
    if(now - last > 1000) {
      last = now;
      showToast('再按一次返回键退出');
      return Future.value(false);//不退出
    } else {
      return Future.value(true);//退出
    }
  }
  @override
  Widget build(BuildContext context) {
    //要用WillPopScope包裹
    return WillPopScope(
      onWillPop: _onWillPop,
        child: Material(
          child: SafeArea(
              child: Scaffold(
                appBar: PreferredSize(
                  //Offstage来控制AppBar的显示与隐藏
                  child: Offstage(
                    offstage: _selectedIndex == 2 ? true : false,
                    child: AppBar(
                      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
                      title: Text('备忘录'),
                      primary: true,
                      automaticallyImplyLeading: false,
                      actions: <Widget>[
                        IconButton(
                            onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) {
                                      return SearchPage(
                                        noteDbHelper: noteDbHelper,
                                      );
                                    }
                                ),
                              );
                            },
                            icon: Icon(Icons.search),
                          tooltip: '搜索',
                        ),
                        IconButton(
                            onPressed: (){
                              Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context){
                                    return WritePage(
                                        noteDbHelper: noteDbHelper,
                                        id: -1,
                                    );
                                  }
                              ),
                              );
                            },
                            icon: Icon(Icons.add),
                          tooltip: '写日记',
                        ),
                      ],
                    ),
                  ),
                  preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
                ),

                //绑定数据
                body: SafeArea(
                  child: PageView(
                    //监听控制器
                    controller: _pageController,
                    onPageChanged: _onItemTapped,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      //三个页面已经进行了封装
                      ListPage(noteDbHelper: noteDbHelper),
                      CalendarPage(noteDbHelper: noteDbHelper),
                      CenterPage(noteDbHelper: noteDbHelper),

                    ],

                  ),
                ),

                //底部导航栏用CupertinoTabBar
                bottomNavigationBar: CupertinoTabBar(
                  //导航集合
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        activeIcon: Icon(
                          Icons.event_note,
                          color: Colors.blue[300],
                        ),
                      icon: Icon(Icons.event_note),
                      label: '主页',

                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.calendar_today),
                      label: '日历',
                      activeIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.blue[300],
                      ),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                      label: '个人中心',
                      activeIcon: Icon(
                        Icons.person,
                        color: Colors.blue[300],
                      ),
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: setPageViewItemSelect,
                ),
              ),
          ),
        ),

    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //底部点击切换
  void setPageViewItemSelect(int indexSelect) {

    _pageController.animateToPage(indexSelect,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
  }
}
