import '../models/account.dart';
import '../models/transaction.dart';

class ContaService {
  final List<Conta> _contas = [];

  void addConta(Conta conta) {
    _contas.add(conta);
  }

  void deposit(String contaNumber, double value) {
    final conta = _contas.firstWhere((c) => c.contaNumber == contaNumber);
    conta.deposit(value);
  }

  void transfer(String fromNumber, String toNumber, double value) {
    final from = _contas.firstWhere((c) => c.contaNumber == fromNumber);
    final to = _contas.firstWhere((c) => c.contaNumber == toNumber);
    from.transfer(to, value);
  }

  List<Transaction> getTransactions(String contaNumber) {
    return _contas.firstWhere((c) => c.contaNumber == contaNumber).transactions;
  }

  List<Conta> getAll() => _contas;
}
