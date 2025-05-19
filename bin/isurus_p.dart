import 'dart:io';

void main() {
  int trend =  int.parse(stdin.readLineSync()!);
  int obj = int.parse(stdin.readLineSync()!);

  void sum()
  {
    print(trend + obj);    
  }
  
  void sub()
  {
    print(trend - obj);    
  }

  void mult()
  {
    print(trend * obj);    
  }

  void div()
  {
    print(trend / obj);    
  }

  sum();
  sub();
  mult();
  div();
}
