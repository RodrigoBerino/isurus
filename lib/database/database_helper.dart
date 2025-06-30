import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bank_app/models/customer.dart';
import 'package:bank_app/models/account.dart';
import 'package:bank_app/models/checking_account.dart';
import 'package:bank_app/models/savings_account.dart';
import 'package:bank_app/models/transaction.dart';
import 'package:bank_app/models/card.dart';
import 'package:bank_app/models/loan.dart';
import 'package:bank_app/models/account_status.dart';
import 'package:bank_app/models/transaction_type.dart';
import 'package:bank_app/models/card_type.dart';
import 'package:bank_app/models/card_status.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bank_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tbl_customers(
        customerId TEXT PRIMARY KEY,
        name TEXT,
        document TEXT,
        address TEXT,
        email TEXT UNIQUE,
        passwordHash TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE tbl_accounts(
        accountNumber TEXT PRIMARY KEY,
        customerId TEXT,
        balance REAL,
        openDate TEXT,
        status TEXT,
        type TEXT,
        overdraftLimit REAL,
        interestRate REAL,
        FOREIGN KEY (customerId) REFERENCES tbl_customers(customerId)
      )
    ''');

    await db.execute('''
      CREATE TABLE tbl_transactions(
        transactionId TEXT PRIMARY KEY,
        accountNumber TEXT,
        date TEXT,
        amount REAL,
        type TEXT,
        description TEXT,
        FOREIGN KEY (accountNumber) REFERENCES tbl_accounts(accountNumber)
      )
    ''');

    await db.execute('''
      CREATE TABLE tbl_cards(
        cardNumber TEXT PRIMARY KEY,
        customerId TEXT,
        accountNumber TEXT,
        expirationDate TEXT,
        cvv TEXT,
        cardType TEXT,
        status TEXT,
        FOREIGN KEY (customerId) REFERENCES tbl_customers(customerId),
        FOREIGN KEY (accountNumber) REFERENCES tbl_accounts(accountNumber)
      )
    ''');

    await db.execute('''
      CREATE TABLE tbl_loans(
        loanId TEXT PRIMARY KEY,
        customerId TEXT,
        principalAmount REAL,
        interestRate REAL,
        termMonths INTEGER,
        outstandingBalance REAL,
        FOREIGN KEY (customerId) REFERENCES tbl_customers(customerId)
      )
    ''');
  }

  // Customer CRUD operations
  Future<int> insertCustomer(Customer customer) async {
    final db = await database;
    return await db.insert('tbl_customers', customer.toMap());
  }

  Future<Customer?> getCustomerByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'tbl_customers',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return Customer.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateCustomer(Customer customer) async {
    final db = await database;
    return await db.update(
      'tbl_customers',
      customer.toMap(),
      where: 'customerId = ?',
      whereArgs: [customer.customerId],
    );
  }

  Future<int> deleteCustomer(String customerId) async {
    final db = await database;
    return await db.delete(
      'tbl_customers',
      where: 'customerId = ?',
      whereArgs: [customerId],
    );
  }

  // Account CRUD operations
  Future<int> insertAccount(Account account, String customerId) async {
    final db = await database;
    Map<String, dynamic> accountMap = account.toMap();
    accountMap['customerId'] = customerId;
    if (account is CheckingAccount) {
      accountMap['type'] = 'checking';
      accountMap['overdraftLimit'] = account.overdraftLimit;
    } else if (account is SavingsAccount) {
      accountMap['type'] = 'savings';
      accountMap['interestRate'] = account.interestRate;
    }
    return await db.insert('tbl_accounts', accountMap);
  }

  Future<List<Account>> getAccountsByCustomerId(String customerId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'tbl_accounts',
      where: 'customerId = ?',
      whereArgs: [customerId],
    );
    return List.generate(maps.length, (i) {
      if (maps[i]['type'] == 'checking') {
        return CheckingAccount(
          accountNumber: maps[i]['accountNumber'],
          balance: maps[i]['balance'],
          openDate: DateTime.parse(maps[i]['openDate']),
          overdraftLimit: maps[i]['overdraftLimit'] ?? 0.0,
        );
      } else {
        return SavingsAccount(
          accountNumber: maps[i]['accountNumber'],
          balance: maps[i]['balance'],
          openDate: DateTime.parse(maps[i]['openDate']),
          interestRate: maps[i]['interestRate'] ?? 0.0,
        );
      }
    });
  }

  Future<int> updateAccount(Account account) async {
    final db = await database;
    Map<String, dynamic> accountMap = account.toMap();
    if (account is CheckingAccount) {
      accountMap['type'] = 'checking';
      accountMap['overdraftLimit'] = account.overdraftLimit;
    } else if (account is SavingsAccount) {
      accountMap['type'] = 'savings';
      accountMap['interestRate'] = account.interestRate;
    }
    return await db.update(
      'tbl_accounts',
      accountMap,
      where: 'accountNumber = ?',
      whereArgs: [account.accountNumber],
    );
  }

  Future<int> deleteAccount(String accountNumber) async {
    final db = await database;
    return await db.delete(
      'tbl_accounts',
      where: 'accountNumber = ?',
      whereArgs: [accountNumber],
    );
  }

  // Transaction CRUD operations
  Future<int> insertTransaction(Transaction transaction) async {
    final db = await database;
    return await db.insert('tbl_transactions', transaction.toMap());
  }

  Future<List<Transaction>> getTransactionsByAccountNumber(String accountNumber) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'tbl_transactions',
      where: 'accountNumber = ?',
      whereArgs: [accountNumber],
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) {
      return Transaction.fromMap(maps[i]);
    });
  }

  // Card CRUD operations
  Future<int> insertCard(Card card) async {
    final db = await database;
    return await db.insert('tbl_cards', card.toMap());
  }

  Future<List<Card>> getCardsByCustomerId(String customerId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'tbl_cards',
      where: 'customerId = ?',
      whereArgs: [customerId],
    );
    return List.generate(maps.length, (i) {
      return Card.fromMap(maps[i]);
    });
  }

  Future<int> updateCard(Card card) async {
    final db = await database;
    return await db.update(
      'tbl_cards',
      card.toMap(),
      where: 'cardNumber = ?',
      whereArgs: [card.cardNumber],
    );
  }

  // Loan CRUD operations
  Future<int> insertLoan(Loan loan) async {
    final db = await database;
    return await db.insert('tbl_loans', loan.toMap());
  }

  Future<List<Loan>> getLoansByCustomerId(String customerId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'tbl_loans',
      where: 'customerId = ?',
      whereArgs: [customerId],
    );
    return List.generate(maps.length, (i) {
      return Loan.fromMap(maps[i]);
    });
  }

  Future<int> updateLoan(Loan loan) async {
    final db = await database;
    return await db.update(
      'tbl_loans',
      loan.toMap(),
      where: 'loanId = ?',
      whereArgs: [loan.loanId],
    );
  }
}