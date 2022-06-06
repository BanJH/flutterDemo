import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TextPage extends StatefulWidget {
  const TextPage({Key? key}) : super(key: key);

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('textPage'),
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),//导航栏背景色
        elevation: 0.5,//导航栏下面的阴影
        leading: IconButton(//返回按钮的定制
          color:  Colors.red,
          icon: Icon(Icons.quick_contacts_mail_outlined),
          onPressed: (){
            Navigator.pop(context);
          },

        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(10, 10, 5, 20),
        child: Center(
          child:TextField(
            // controller = TextEditingController();
            //     controller.addListener(() {});
            //获取内容 controller.text
            controller: TextEditingController(),//控制器
            focusNode: FocusNode(),//unfocus()可以让软键盘消失的功能
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),//只允许输入数
                LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.deny(RegExp('[abF!.]')),//禁止abF!.
              ],
            style: TextStyle(
              backgroundColor: Colors.red,
              decoration: TextDecoration.lineThrough,

            ),
            decoration: InputDecoration(
              icon: Icon(Icons.start),
              hintText: '请输入',

            ),


          ),
        ),
      ),
    );
  }
}



/*
const TextField({
    Key key,
    this.controller,//控制器
    this.focusNode,//焦点
    this.decoration = const InputDecoration(),//装饰
    TextInputType keyboardType,//键盘类型，即输入类型
    this.textInputAction,//键盘按钮
    this.textCapitalization = TextCapitalization.none,//大小写
    this.style,//样式
    this.strutStyle,
    this.textAlign = TextAlign.start,//对齐方式
    this.textDirection,
    this.autofocus = false,//自动聚焦
    this.obscureText = false,//是否隐藏文本，即显示密码类型
    this.autocorrect = true,//自动更正
    this.maxLines = 1,//最多行数，高度与行数同步
    this.minLines,//最小行数
    this.expands = false,
    this.maxLength,//最多输入数，有值后右下角就会有一个计数器
    this.maxLengthEnforced = true,
    this.onChanged,//输入改变回调
    this.onEditingComplete,//输入完成时，配合TextInputAction.done使用
    this.onSubmitted,//提交时,配合TextInputAction
    this.inputFormatters,//输入校验
    this.enabled,//是否可用
    this.cursorWidth = 2.0,//光标宽度
    this.cursorRadius,//光标圆角
    this.cursorColor,//光标颜色
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection,
    this.onTap,//点击事件
    this.buildCounter,
    this.scrollPhysics,
  })
复制代码



 const InputDecoration({
    this.icon,//左侧外的图标
    this.labelText,//悬浮提示，可代替hintText
    this.labelStyle,//悬浮提示文字的样式
    this.helperText,//帮助文字
    this.helperStyle,
    this.hintText,//输入提示
    this.hintStyle,
    this.hintMaxLines,
    this.errorText,//错误提示
    this.errorStyle,
    this.errorMaxLines,
    this.hasFloatingPlaceholder = true,//是否显示悬浮提示文字
    this.isDense,
    this.contentPadding,//内填充
    this.prefixIcon,//左侧内的图标
    this.prefix,
    this.prefixText,//左侧内的文字
    this.prefixStyle,
    this.suffixIcon,//右侧内图标
    this.suffix,
    this.suffixText,
    this.suffixStyle,
    this.counter,//自定义计数器
    this.counterText,//计数文字
    this.counterStyle,//计数样式
    this.filled,//是否填充
    this.fillColor,//填充颜色
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.enabledBorder,
    this.border,//边框
    this.enabled = true,
    this.semanticCounterText,
    this.alignLabelWithHint,
  })

复制代码










 Text(
            'textAlign-对齐textAlign-对齐textAlign-对齐textAlign-对齐textAlign-对齐textAlign-对齐textAlign-对齐textAlign-对齐textAlign-对齐textAlign-对齐',
            textAlign: TextAlign.start,
            softWrap: true,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              wordSpacing: 5,
              //letterSpacing: 10,
              decoration: TextDecoration.lineThrough,//中划线
              decorationColor: Colors.orange,
              decorationStyle: TextDecorationStyle.double,

            ),
          ),



RichText(
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(text: "登陆即视为同意",
                style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                    text: "<xxx服务协议>",
                  style: TextStyle(color: Colors.red),
                  recognizer: TapGestureRecognizer()..onTap = (){
                      print('~~~~');
                  },
                ),

              ],
            ),
          ),

 */