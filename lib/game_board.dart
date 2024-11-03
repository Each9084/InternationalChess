import 'package:chess/components/piece.dart';
import 'package:chess/components/square.dart';
import 'package:chess/helper/helper_method.dart';
import 'package:chess/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //2-dimensional list representing the chessboard
  //最外层得到List表示棋盘的行
  //内层List<ChessPiece?> 即表示每一行是一个包含多个 ChessPiece? 对象的列表,也就是列
  //?则是表示可空,毕竟有的时候没有棋子

  late List<List<ChessPiece?>> board;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  //initialize
  void _initializeBoard() {
    List<List<ChessPiece?>> newBoard =
        List.generate(8, (index) => List.generate(8, (index) => null));

    //place pawns
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: false,
        imagePath: 'lib/images/pawn.png',
      );
    }

    for (int i = 0; i < 8; i++) {
      newBoard[6][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: true,
        imagePath: 'lib/images/pawn.png',
      );
    }

    //place rooks
    //place knights
    //place bishops
    //place queens
    //place kings

    board = newBoard;
  }

 /* //create a piece but now we  need _initializeBoard fore the initial one
  ChessPiece myPawn = ChessPiece(
    type: ChessPieceType.pawn,
    isWhite: true,
    imagePath: 'lib/images/pawn.png',
  );*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GridView.builder(
        itemCount: 8 * 8,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemBuilder: (context, index) {
          //get the row and column position of this square
          int row = index ~/ 8 ;
          int col = index %8;
          return Square(
            isWhite: isWhiteT(index),
            piece: board[row][col],
          );
          /*if(index%2==0){
           return Square(isWhite: false);
          }else{
            return Square(isWhite: true);
          }*/
        },
      ),
    );
  }
}
