import 'package:flutter/material.dart';
import '../models/customer.dart';
import 'profile_screen.dart';
import 'cards_screen.dart';

class DashboardScreen extends StatelessWidget {
  final Customer customer;

  const DashboardScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileScreen(customer: customer),
              ),
            ),
          )
        ],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, ${customer.name}!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Bem-vindo ao Banco Isurus.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.indigo.shade400,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  _buildDashboardCard(
                    context,
                    icon: Icons.account_balance_wallet,
                    title: 'Contas',
                    subtitle: 'Veja suas contas',
                    color: Colors.indigo.shade400,
                    onTap: () {
                      // Navegação para tela de Contas (implementar)
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.credit_card,
                    title: 'Cartões',
                    subtitle: 'Gerencie seus cartões',
                    color: Colors.deepPurple.shade400,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CardsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.send,
                    title: 'Transferências',
                    subtitle: 'Faça transferências',
                    color: Colors.teal.shade400,
                    onTap: () {
                      // Navegação para transferências (implementar)
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.history,
                    title: 'Histórico',
                    subtitle: 'Veja suas transações',
                    color: Colors.orange.shade400,
                    onTap: () {
                      // Navegação para histórico (implementar)
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required Color color,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.85),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ],
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            Spacer(),
            Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(subtitle, style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
