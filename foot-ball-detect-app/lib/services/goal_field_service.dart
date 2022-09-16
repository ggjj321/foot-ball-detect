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

  String selectStatusConvertToTargetSquares(){
    String targetSquares = "";
    for(int y = 0; y < 3; y++){
      for(int x = 0; x < 4; x++){
        if(fieldChooseStatus[y][x]) {
          int coordinate = 1 + y * 4 + x;
          targetSquares += "$coordinate,";
        }
      }
    }

    int targetSquaresLength = targetSquares.length;

    if(targetSquares.substring(targetSquaresLength - 1) == ",") {
      targetSquares = targetSquares.substring(0, targetSquaresLength - 1);
    }

    return targetSquares;
  }
}