import 'package:flutter/material.dart';

class GoalFieldService extends ChangeNotifier{
  List<List<bool>> fieldChooseStatus = List.generate(3, (index) => List.generate(4, (index) => false));

  void pressField(int y, int x){
    fieldChooseStatus[y][x] = ! fieldChooseStatus[y][x];
    notifyListeners();
  }

  String getFieldStatusToString(int y, int x) {
    if(fieldChooseStatus[y][x]){
      return "choose";
    }else{
      return "";
    }
  }

  Color getFieldStatusToColor(int y, int x){
    if(fieldChooseStatus[y][x]){
      return const Color.fromARGB(100, 55, 1, 200);
    }else{
      return Colors.white;
    }
  }
}