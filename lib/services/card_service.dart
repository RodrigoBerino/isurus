import 'package:bank_app/database/database_helper.dart';
import 'package:bank_app/models/card.dart';

class CardService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addCard(Card card) async {
    await _dbHelper.insertCard(card);
  }

  Future<List<Card>> getCardsByCustomerId(String customerId) async {
    return await _dbHelper.getCardsByCustomerId(customerId);
  }

  Future<void> updateCardStatus(Card card) async {
    await _dbHelper.updateCard(card);
  }
}