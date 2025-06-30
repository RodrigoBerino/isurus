import 'package:flutter/material.dart';
import 'package:bank_app/models/account.dart';
import 'package:bank_app/models/transaction.dart';
import 'package:bank_app/services/transaction_service.dart';

class StatementScreen extends StatefulWidget {
  final Account account;

  StatementScreen({required this.account});

  @override
  _StatementScreenState createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  final TransactionService _transactionService = TransactionService();
  List<Transaction> _transactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    try {
      final transactions = await _transactionService.getTransactionsByAccountNumber(widget.account.accountNumber);
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar extrato: $e')),
      );
    }
  }

  IconData _getTransactionIcon(Transaction transaction) {
    switch (transaction.type) {
      case TransactionType.deposit:
        return Icons.add_circle;
      case TransactionType.withdrawal:
        return Icons.remove_circle;
      case TransactionType.transfer:
        return Icons.swap_horiz;
      case TransactionType.payment:
        return Icons.payment;
      default:
        return Icons.monetization_on;
    }
  }

  Color _getTransactionColor(Transaction transaction) {
    switch (transaction.type) {
      case TransactionType.deposit:
        return Colors.green;
      case TransactionType.withdrawal:
        return Colors.red;
      case TransactionType.transfer:
        return Colors.blue;
      case TransactionType.payment:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getTransactionTypeText(Transaction transaction) {
    switch (transaction.type) {
      case TransactionType.deposit:
        return 'Depósito';
      case TransactionType.withdrawal:
        return 'Saque';
      case TransactionType.transfer:
        return 'Transferência';
      case TransactionType.payment:
        return 'Pagamento';
      default:
        return 'Transação';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extrato'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            color: Colors.blue[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Conta: ${widget.account.accountNumber}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Saldo atual: R\$ ${widget.account.balance.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: widget.account.balance >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _transactions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Nenhuma transação encontrada',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16.0),
                        itemCount: _transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = _transactions[index];
                          return Card(
                            elevation: 2,
                            margin: EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: _getTransactionColor(transaction),
                                child: Icon(
                                  _getTransactionIcon(transaction),
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                _getTransactionTypeText(transaction),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(transaction.description),
                                  SizedBox(height: 4),
                                  Text(
                                    '${transaction.date.day}/${transaction.date.month}/${transaction.date.year} ${transaction.date.hour}:${transaction.date.minute.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                '${transaction.type == TransactionType.withdrawal ? '-' : '+'} R\$ ${transaction.amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: transaction.type == TransactionType.withdrawal 
                                      ? Colors.red 
                                      : Colors.green,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}