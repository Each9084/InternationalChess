import 'package:chess/components/piece.dart';
import 'package:chess/values/colors.dart';
import 'package:flutter/material.dart';

//负责棋盘的转换
class Square extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final void Function()? onTap;


  const Square({super.key,
    required this.isWhite,
    required this.piece,
    required this.isSelected,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    Color?squareColor;

    //if selected, square will be green
    if (isSelected) {
      squareColor = Colors.green;
    } else { //otherwise will be white or black
      squareColor = isWhite ? foregroundColor : backgroundColor;
    }

    return GestureDetector(
      onTap:onTap,
      child: Container(
        color: squareColor,
        child: piece != null
            ? Image.asset(
          piece!.imagePath,
          //在这里绑定的 颜色判定
          color: piece!.isWhite ? Colors.white : Colors.black,
        )
            : null,
      ),
    );
  }
}
