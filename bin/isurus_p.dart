import 'dart:io';

void main() {
  int x = 0;
  int y = 0;
  String op = "";
  List<String> operacao = <String>["+", "-", "*", "/"]; 

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

  void calcular(){
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

  void getop()
  {

  } 

  print("Digite 1 valor:");
  String? entrada = stdin.readLineSync();
  if(entrada != null)
  {
    if(entrada != "")
    {
      x = int.parse(entrada);
    }
  }

  print("Digite 1 op:");

  entrada = stdin.readLineSync();
  if (entrada != null)
  {
    op = entrada;
  }

  print("Digite 2 valor:");
  entrada = stdin.readLineSync();
  if(entrada != null)
  {
    if(entrada != "")
    {
      y = int.parse(entrada);
    }
  }

  /*
  x =  int.parse(stdin.readLineSync()!);
  y = int.parse(stdin.readLineSync()!);
  op = stdin.readLineSync()!;
  */

}
