import 'dart:io';
import 'dart:math';


List<List<String>> board = [
  ['1','2','3'],
  ['4','5','6'],
  ['7','8','9']
];


void PrintBoard (){
  for(var item in board)
  {
    print(item.join('|'));
    print('------');
  }
}

void PlayerTurn(int position){
  if(position>=1 && position<=3 && board[0][(position-1)%3] != 'O' && board[0][(position-1)%3] != 'X')
      board[0][(position-1)%3] = 'X';
    else if(position>=4 && position<=6 && board[1][(position-1)%3] != 'O' && board[1][(position-1)%3] != 'X')
       board[1][(position-1)%3] = 'X';
    else if(position>=7 && position<=9 && board[2][(position-1)%3] != 'O' && board[2][(position-1)%3] != 'X')   
        board[2][(position-1)%3] = 'X';
    else { print('Invalid input...Try again:');
     position = int.parse(stdin.readLineSync()!);
     PlayerTurn(position);
    }
 PrintBoard();
}

void ComputerTurn(){
 sleep(Duration(seconds: 1));

 //check if computer can win
 for(int i = 0; i < 3; i++)
 {
  for(int j = 0; j < 3; j++)
  {
    if(board[i][j] != 'X' && board[i][j] != 'O')
    {
      String position = board[i][j];
      board[i][j] = 'O';
      if(CheckIfWin('O')){
        PrintBoard();
        return;
      }
      board[i][j] = position;
    }
  }
 }
 //check if player can win
 for(int i = 0; i < 3; i++)
 {
  for(int j = 0; j < 3; j++)
  {
    if(board[i][j] != 'X' && board[i][j] != 'O')
    {
      String position = board[i][j];
      board[i][j] = 'X';
      if(CheckIfWin('X')){
        board[i][j] = 'O';
        PrintBoard();
        return;
      }
      board[i][j] = position;
    }
  }
 }
 //random move
 while(true){
  int row = Random().nextInt(3);
  int col = Random().nextInt(3);
  if(board[row][col] != 'X' && board[row][col] != 'O')
  {
    board[row][col] = 'O';
    PrintBoard();
    break;
  }
 }

}

bool CheckIfWin(String player){
  for(int i = 0; i < 3; i++){
    if((board[i][0] == player && board[i][1] == player && board[i][2] == player) ||
       (board[0][i] == player && board[1][i] == player && board[2][i] == player))
       return true;
  }
  for(int i = 0; i < 3; i++)
  {
    if((board[0][0] == player && board[1][1] == player && board[2][2] == player) ||
      (board[0][2] == player && board[1][1] == player && board[2][0] == player))
      return true;
  }
  return false;
}




void main() {
 
 print('Welcome to Tic Tac Toe...You are X and the computer is O');
 PrintBoard();
 int i = 1;
 while(i <= 9){
 print(i == 1?'Choose a position to put X': i%2 != 0?'Your Turn':'Computer Turn');

  if(i % 2 == 0) {
    ComputerTurn();
    if(CheckIfWin('O')){
      print('Computer Win!');
      print('Game Over!😢');
    }
  }
  else {
    int position = int.parse(stdin.readLineSync()!);
    PlayerTurn(position);
    if(CheckIfWin('X')){
        print('You Win!🎉🎉');
        return;
    }
 }
 i++;
}
  print('It\'s a draw! 🤝');

}
