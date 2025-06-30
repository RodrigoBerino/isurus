# Isurus

Um aplicativo bancário completo desenvolvido em Flutter e Dart, seguindo arquitetura orientada a objetos e baseado em diagrama UML.

# Funcionalidades

- Registro e login de clientes
- Criação e gerenciamento de contas (corrente e poupança)
- Depósito, saque e transferência entre contas
- Visualização de extrato bancário
- Geração e gerenciamento de cartões (crédito, débito, múltiplo)
- Contratação e pagamento de empréstimos

# Arquitetura

O projeto segue uma arquitetura em camadas:

```
lib/
├── models/          # Modelos de dados e enums
├── services/        # Lógica de negócio
├── screens/         # Telas da interface
├── database/        # Persistência SQLite
├── widgets/         # Componentes reutilizáveis
└── main.dart        # Ponto de entrada
```

# Tecnologias

- **Flutter** - Framework de desenvolvimento
- **Dart** - Linguagem de programação
- **SQLite** - Banco de dados local
- **Crypto** - Hash de senhas
- **UUID** - Identificadores únicos

# Telas

1. **Login/Cadastro** - Autenticação de usuários
2. **Dashboard** - Painel principal com resumo
3. **Contas** - Gerenciamento de contas bancárias
4. **Extrato** - Histórico de transações
5. **Cartões** - Gerenciamento de cartões
6. **Empréstimos** - Solicitação e pagamento

# Como Executar

### Pré-requisitos
- Flutter SDK
- Dart SDK
- Emulador ou dispositivo físico

### Instalação
```bash
# Clone o repositório
git clone <repository-url>

# Navegue até o diretório
cd bank_app

# Instale as dependências
flutter pub get

# Execute o aplicativo
flutter run
```

## Banco de Dados

### Tabelas
- `tbl_customers` - Dados dos clientes
- `tbl_accounts` - Contas bancárias
- `tbl_transactions` - Histórico de transações
- `tbl_cards` - Cartões bancários
- `tbl_loans` - Empréstimos

##  Segurança

- Hash SHA-256 para senhas
- Validação de dados de entrada
- Controle de acesso por sessão
- Verificação de integridade

##  Melhorias Futuras

- [ ] Notificações push
- [ ] Autenticação biométrica
- [ ] Relatórios e gráficos
- [ ] Integração com APIs externas
- [ ] Modo offline

## Licença

Este projeto é desenvolvido para fins de desenvolvimento mobile.