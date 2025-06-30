import 'package:flutter/material.dart';
import 'package:bank_app/models/customer.dart';
import 'package:bank_app/models/account.dart';
import 'package:bank_app/models/checking_account.dart';
import 'package:bank_app/models/savings_account.dart';
import 'package:bank_app/services/account_service.dart';
import 'package:bank_app/screens/statement_screen.dart';

class AccountsScreen extends StatefulWidget {
  final Customer customer;

  AccountsScreen({required this.customer});

  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  final AccountService _accountService = AccountService();
  List<Account> _accounts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    try {
      final accounts = await _accountService.getAccountsByCustomerId(widget.customer.customerId);
      setState(() {
        _accounts = accounts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar contas: $e')),
      );
    }
  }

  void _showTransactionDialog(Account account) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Transação'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.add, color: Colors.green),
                title: Text('Depósito'),
                onTap: () {
                  Navigator.pop(context);
                  _showAmountDialog(account, 'deposit');
                },
              ),
              ListTile(
                leading: Icon(Icons.remove, color: Colors.red),
                title: Text('Saque'),
                onTap: () {
                  Navigator.pop(context);
                  _showAmountDialog(account, 'withdraw');
                },
              ),
              ListTile(
                leading: Icon(Icons.swap_horiz, color: Colors.blue),
                title: Text('Transferência'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement transfer dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Transferência em desenvolvimento')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAmountDialog(Account account, String operation) {
    final TextEditingController amountController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(operation == 'deposit' ? 'Depósito' : 'Saque'),
          content: TextField(
            controller: amountController,
            decoration: InputDecoration(
              labelText: 'Valor',
              prefixText: 'R\$ ',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final amount = double.tryParse(amountController.text);
                if (amount != null && amount > 0) {
                  try {
                    if (operation == 'deposit') {
                      await _accountService.deposit(account, amount);
                    } else {
                      await _accountService.withdraw(account, amount);
                    }
                    Navigator.pop(context);
                    _loadAccounts();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Transação realizada com sucesso')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro na transação: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, insira um valor válido')),
                  );
                }
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Contas'),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _accounts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Nenhuma conta encontrada',
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
                  itemCount: _accounts.length,
                  itemBuilder: (context, index) {
                    final account = _accounts[index];
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  account is CheckingAccount ? 'Conta Corrente' : 'Conta Poupança',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  account is CheckingAccount 
                                      ? Icons.account_balance_wallet 
                                      : Icons.savings,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Conta: ${account.accountNumber}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Saldo: R\$ ${account.balance.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: account.balance >= 0 ? Colors.green : Colors.red,
                              ),
                            ),
                            if (account is CheckingAccount)
                              Text(
                                'Limite: R\$ ${account.overdraftLimit.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            if (account is SavingsAccount)
                              Text(
                                'Taxa de juros: ${(account.interestRate * 100).toStringAsFixed(2)}%',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () => _showTransactionDialog(account),
                                  icon: Icon(Icons.swap_horiz),
                                  label: Text('Transação'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StatementScreen(account: account),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.receipt_long),
                                  label: Text('Extrato'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}