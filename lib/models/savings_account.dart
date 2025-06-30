import 'account.dart';
import '../core/enums/account_status.dart';

class SavingsConta extends Conta {
  double cash;

  SavingsConta(String contaNumber, ContaStatus status, this.cash)
      : super(contaNumber, status);

  void aplicacoes() {
    // Lógica de aplicação futura
  }
}