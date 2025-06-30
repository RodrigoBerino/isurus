import 'account.dart';
import '../core/enums/account_status.dart';

class CheckingConta extends Conta {
  double overdraftLimit;

  CheckingConta(String contaNumber, ContaStatus status, this.overdraftLimit)
      : super(contaNumber, status);
}
