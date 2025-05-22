import 'dart:io';

void main() {
  int x = 0;
  int y = 0;
  String op = "";

  String? entrada = stdin.readLineSync();
  if(entrada != null)
  {
    if(entrada != "")
    {
      x = int.parse(entrada);
    }
  }

  /*
  x =  int.parse(stdin.readLineSync()!);
  y = int.parse(stdin.readLineSync()!);
  op = stdin.readLineSync()!;
  */

  void sum()
  {
    print(x + y);    
  }
  
  void sub()
  {
    print(x - y);    
  }

  void mult()
  {
    print(x * y);    
  }

  void div()
  {
    print(x / y);    
  }

  if (op == "+")
  {
    sum();
  }

  switch (op)
  {
    case "+":
    sum();
    case "-":
    sub();
    case "*":
    mult();
    case "/":
    div();
    break;
  }
}
