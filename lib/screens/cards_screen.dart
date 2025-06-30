import 'package:flutter/material.dart';
import 'package:bank_app/models/customer.dart';
import 'package:bank_app/models/card.dart';
import 'package:bank_app/services/card_service.dart';

class CardsScreen extends StatefulWidget {
  final Customer customer;

  CardsScreen({required this.customer});

  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final CardService _cardService = CardService();
  List<Card> _cards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    try {
      final cards = await _cardService.getCardsByCustomerId(widget.customer.customerId);
      setState(() {
        _cards = cards;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar cartões: $e')),
      );
    }
  }

  void _showCardActions(Card card) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ações do Cartão'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (card.status != CardStatus.active)
                ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text('Ativar'),
                  onTap: () {
                    Navigator.pop(context);
                    _updateCardStatus(card, CardStatus.active);
                  },
                ),
              if (card.status != CardStatus.blocked)
                ListTile(
                  leading: Icon(Icons.block, color: Colors.red),
                  title: Text('Bloquear'),
                  onTap: () {
                    Navigator.pop(context);
                    _updateCardStatus(card, CardStatus.blocked);
                  },
                ),
              if (card.status != CardStatus.inactive)
                ListTile(
                  leading: Icon(Icons.pause_circle, color: Colors.orange),
                  title: Text('Desativar'),
                  onTap: () {
                    Navigator.pop(context);
                    _updateCardStatus(card, CardStatus.inactive);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _updateCardStatus(Card card, CardStatus newStatus) async {
    try {
      card.status = newStatus;
      await _cardService.updateCardStatus(card);
      _loadCards();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status do cartão atualizado')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar cartão: $e')),
      );
    }
  }

  String _getCardTypeText(Card card) {
    switch (card.cardType) {
      case CardType.debit:
        return 'Débito';
      case CardType.credit:
        return 'Crédito';
      case CardType.multiple:
        return 'Múltiplo';
      default:
        return 'Cartão';
    }
  }

  String _getCardStatusText(Card card) {
    switch (card.status) {
      case CardStatus.active:
        return 'Ativo';
      case CardStatus.inactive:
        return 'Inativo';
      case CardStatus.blocked:
        return 'Bloqueado';
      default:
        return 'Desconhecido';
    }
  }

  Color _getCardStatusColor(Card card) {
    switch (card.status) {
      case CardStatus.active:
        return Colors.green;
      case CardStatus.inactive:
        return Colors.orange;
      case CardStatus.blocked:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getCardColor(Card card) {
    switch (card.cardType) {
      case CardType.debit:
        return Colors.blue;
      case CardType.credit:
        return Colors.purple;
      case CardType.multiple:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Cartões'),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _cards.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Nenhum cartão encontrado',
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
                  itemCount: _cards.length,
                  itemBuilder: (context, index) {
                    final card = _cards[index];
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.only(bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              _getCardColor(card),
                              _getCardColor(card).withOpacity(0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Cartão ${_getCardTypeText(card)}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: _getCardStatusColor(card),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      _getCardStatusText(card),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                '**** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Validade: ${card.expirationDate}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.customer.name.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => _showCardActions(card),
                                    child: Text('Gerenciar'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: _getCardColor(card),
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}