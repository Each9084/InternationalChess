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

  //The currently selected piece on the chessboard,
  //if no piece is selected ,this is null
  ChessPiece? selectedPiece;

  //The row index of the selected piece
  //Default value -1 indicated no piece is currently
  int selectedRow = -1;

  //The col index of the selected piece
  //Default value -1 indicated no piece is currently
  int selectedCol = -1;

  //a list of valid moves for the currently selected piece
  //each move is represented as a list with 2 elements:row and col
  List<List<int>> validMoves = [];

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
    newBoard[0][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/rook.png');

    newBoard[0][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/rook.png');

    newBoard[7][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/rook.png');

    newBoard[7][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/rook.png');
    //place knights
    newBoard[0][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: 'lib/images/knight.png');
    newBoard[0][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: 'lib/images/knight.png');

    newBoard[7][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: 'lib/images/knight.png');

    newBoard[7][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: 'lib/images/knight.png');
    //place bishops
    newBoard[0][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: 'lib/images/bishop.png');
    newBoard[0][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: 'lib/images/bishop.png');

    newBoard[7][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: 'lib/images/bishop.png');
    newBoard[7][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: 'lib/images/bishop.png');
    //place queens
    newBoard[0][3] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: false,
        imagePath: 'lib/images/queen.png');

    newBoard[7][4] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: true,
        imagePath: 'lib/images/queen.png');
    //place kings
    newBoard[0][4] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: false,
        imagePath: 'lib/images/king.png');

    newBoard[7][3] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: true,
        imagePath: 'lib/images/king.png');
    board = newBoard;
  }

  /* //create a piece but now we  need _initializeBoard fore the initial one
  ChessPiece myPawn = ChessPiece(
    type: ChessPieceType.pawn,
    isWhite: true,
    imagePath: 'lib/images/pawn.png',
  );*/

  //USER SELECTED A PIECE
  void pieceSelected(int row, int col) {
    setState(() {
      // selected a piece if there is a piece in that position
      if (board[row][col] != null) {
        //if there is not null,
        // means there is a piece in this position
        //let us select it
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }

      //选择棋子后 计算有效的动作,将调用validMoves这个方法
      //计算有效动作,调用这个方法
      validMoves =
          calculateRawValidMoves(selectedRow, selectedCol, selectedPiece);
    });
  }

  //calculate raw valid moves 计算有效的移动,有些动作时非法的,负责非法动作的是另一个模块
  //calculateRawValidMoves里我们需要知道位置
  List<List<int>> calculateRawValidMoves(
      int row, int col, ChessPiece? piece) {
    //创建一个候选移动列表
    List<List<int>> candidateMoves = [];

    //基于颜色的directions
    //如果是白色,那就减少,向上移动;如果是黑色,就增加,向下移动;
    int direction = piece!.isWhite?-1:1;

    //check当前棋子的类型
    switch(piece.type){
      case ChessPieceType.pawn:
        //pawns向前移动 前提是没有阻挡

      //初始化时,可以向前走两格

      //捕获对角线的棋子
      break;
      case ChessPieceType.rook:
        break;
      case ChessPieceType.knight:
        break;
      case ChessPieceType.bishop:
        break;
      case ChessPieceType.queen:
        break;
      case ChessPieceType.king:
        break;
      default:

    }
  }

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
          int row = index ~/ 8;
          int col = index % 8;
          //check if this square is selected

          bool isSelected = selectedRow == row && selectedCol == col;
          return Square(
            isWhite: isWhiteT(index),
            piece: board[row][col],
            isSelected: isSelected,
            onTap: () {
              pieceSelected(row, col);
            },
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
