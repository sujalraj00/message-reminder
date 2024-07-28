import 'package:flutter/material.dart';
import 'package:message_reminder/res/consts/styles.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MyInputReminder extends StatelessWidget {
  const MyInputReminder(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget});

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles().titleStyle,
          ),
          Container(
            height: 52,
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      readOnly: widget == null ? false : true,
                        autofocus: false,
                        cursorColor: Get.isDarkMode
                            ? Colors.grey[100]
                            : Colors.grey[700],
                        controller: controller,
                        style: AppStyles().subTitleStyle,
                        decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: AppStyles().subTitleStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  // color: context.theme.backgroundColor    need to look after
                                  width: 0)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  // color: context.theme.backgroundColor    need to look after
                                  width: 0)),
                        ))),
                widget == null ? Container() : Container(child: widget,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
