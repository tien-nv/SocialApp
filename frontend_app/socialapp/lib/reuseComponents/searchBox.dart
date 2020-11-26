import 'package:flutter/material.dart';

Container searchBox({onTapFunction,onChangedFunction,onEditingCompleteFunction,onSubmittedFunction,autoFocus = false,hintText = 'Tìm kiếm'}) {
  return Container(
    height: 38,
    decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Color(0xFFFFFFFF), width: 0.0)),
    child: TextField(
      autofocus: autoFocus,
      onTap: onTapFunction,
      onChanged: onChangedFunction,
      onEditingComplete: onEditingCompleteFunction,
      onSubmitted: onSubmittedFunction,
      style: TextStyle(
        fontSize: 16,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 6),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFFFFFF),
            width: 0.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.0,
            color: Color(0xFFFFFFFF),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gapPadding: 0,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Color(0xFF757575),
        ),
        hintText: '$hintText',
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0.0),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gapPadding: 0,
        ),
      ),
    ),
  );
}
