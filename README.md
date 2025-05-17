# Shopping Cart App



## 🚀 Como executar o projeto

Siga os passos abaixo para executar o projeto em sua máquina local:

### 1. Clone o repositório

```bash
git clone https://github.com/Vinicius-b-oliveira/shopping_cart_app.git
cd shopping_cart_app
```

### 2. Instale as dependências

```bash
flutter pub get
```

### 3. Configure o arquivo .env

Crie um arquivo `.env` na raiz do projeto com as seguintes variáveis:

```
BASE_URL=seu_valor_aqui
ANON_KEY=seu_valor_aqui
```

### 4. Gere os arquivos necessários

```bash
dart run build_runner build -d
```

### 5. Execute o aplicativo

```bash
flutter run
```

## 📁 Estrutura do Projeto

O projeto está organizado seguindo uma arquitetura limpa e modular:

### Core

A pasta `core` contém as classes e funções fundamentais do aplicativo, como:

- **Tema**: Configuração do tema global da aplicação
- **Utilitários**: Funções auxiliares reutilizáveis

### Data/models

A pasta `data/models` contém as classes de modelo que representam os dados da aplicação (criadas usando Freezed)

### Data/repositories

A pasta `data/repositories` contém as implementações dos repositórios que fazem a comunicação com as fontes de dados:

### Presentation/viewmodels

A pasta `presentation/viewmodels` contém os ViewModels que gerenciam o estado da aplicação:

- Lógica de apresentação
- Gerenciamento de estado
- Mediação entre repositórios e views

### Presentation/views

A pasta `presentation/views` contém as telas da aplicação:

### Presentation/widgets

A pasta `presentation/widgets` contém os widgets reutilizáveis:

- Componentes de UI personalizados
- Widgets reutilizáveis entre diferentes telas
- Componentes estilizados específicos da aplicação


