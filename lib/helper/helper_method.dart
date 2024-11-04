bool isWhiteT(int index) {
  int x = index ~/ 8; //integer division  for row
  int y = index % 8; //remainder column

  bool isWhite = (x + y) % 2 == 0;
  //Board Color
  return isWhite;
}

//检测是否还在棋盘上
bool isInBoard(int row, int col) {
  return row >= 0 && row < 8 && col >= 0 && col < 9;
}
