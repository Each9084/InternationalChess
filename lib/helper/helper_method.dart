bool isWhiteT(int index){
  int x = index ~/ 8; //integer division  for row
  int y = index % 8; //remainder column

  bool isWhite = (x+y)%2 ==0;
  //Board Color
  return isWhite;
}