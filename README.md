# Isurus

Isurus Project é um aplicativo de streaming de vídeo desenvolvido em Flutter e Dart. Seu principal objetivo é criar uma plataforma de mídia com foco em uma arquitetura robusta, escalável, modular, testável e orientada a objetos, seguindo princípios como Clean Architecture.

## Estrutura do Projeto

O código é organizado em uma estrutura de pastas clara:

* **`app/`**: Configurações centrais, widgets globais e ponto de entrada.
* **`features/`**: Cada funcionalidade principal (autenticação, home, player) é um módulo separado, contendo suas próprias camadas:
    * **`data/`**: Modelos, fontes de dados (API, local) e implementações de repositórios.
    * **`domain/`**: Lógica de negócios pura, com entidades, contratos de repositórios e casos de uso.
    * **`presentation/`**: UI (telas, widgets) e gerenciamento de estado (Cubit/BLoC, etc.).
* **`core/`** (opcional): Lógica compartilhada como tratamento de erros.
* **`injection_container.dart`**: Para injeção de dependência.

## Princípios de POO e S.O.L.I.D.

O projeto aplica ativamente encapsulamento, abstração, herança, polimorfismo e os cinco princípios S.O.L.I.D. para garantir um código limpo e de fácil manutenção.

## Como Começar

1.  **Pré-requisitos**: Flutter SDK.
2.  Clone o repositório.
3.  Instale as dependências (`flutter pub get`).
4.  (Opcional) Configure variáveis de ambiente/chaves de API.
5.  Execute o aplicativo (`flutter run`).

## Funcionalidades Planejadas (Exemplos)

Autenticação, home com destaques/categorias, player de vídeo, busca, detalhes de mídia, favoritos, histórico e perfil.

## Tecnologias Chave

* **Linguagem**: Dart, **Framework**: Flutter.
* **Gerenciamento de Estado**: (a definir: BLoC/Cubit, Provider, etc.).
* **Navegação**: (a definir).
* **Requisições HTTP**: `http` ou `dio`.
* **Injeção de Dependência**: `get_it`.
* Outros pacotes para tratamento de resultados, player de vídeo, armazenamento local, etc.

## 🤝 Contribuições

São bem-vindas, seguindo o fluxo padrão de Fork, Branch, Commit, Push e Pull Request.

## Licença

MIT (ver arquivo `LICENSE`).

---

*Este é um resumo do README principal do projeto.*