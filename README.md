# 💝 Lista de Desejos com Supabase

Uma lista de desejos moderna e interativa que salva todos os dados na nuvem usando Supabase.

## ✨ Características

- 🎨 Design moderno com Tailwind CSS
- 🔴 Cores vermelhas e brancas
- ☁️ Dados salvos na nuvem (Supabase)
- 📱 Interface responsiva
- 🖼️ Suporte a imagens e links
- 📊 Estatísticas em tempo real
- ✅ Marcação de itens comprados
- 🛒 Links diretos para compra

## 🚀 Configuração do Supabase

### 1. Criar conta no Supabase
1. Acesse [supabase.com](https://supabase.com)
2. Clique em "Start your project"
3. Faça login com GitHub ou crie uma conta
4. Clique em "New Project"

### 2. Configurar o projeto
1. Escolha um nome para o projeto (ex: "wishlist-app")
2. Escolha uma senha forte para o banco
3. Escolha uma região (recomendo São Paulo)
4. Clique em "Create new project"
5. Aguarde a criação (pode demorar alguns minutos)

### 3. Criar a tabela
1. No painel do Supabase, vá para "Table Editor"
2. Clique em "New Table"
3. Configure a tabela:

```sql
Table name: wishlist_items
Columns:
- id (int8, primary key, auto-increment)
- title (text, not null)
- description (text, nullable)
- price (text, nullable)
- image_url (text, nullable)
- buy_link (text, nullable)
- completed (bool, default: false)
- created_at (timestamptz, default: now())
```

4. Clique em "Save"

### 4. Configurar RLS (Row Level Security)
1. Vá para "Authentication" > "Policies"
2. Clique em "New Policy"
3. Escolha "Create a policy from scratch"
4. Configure:
   - Policy name: `Enable all operations for all users`
   - Target roles: `public`
   - Using expression: `true`
5. Clique em "Review" e depois "Save policy"

### 5. Obter as credenciais
1. Vá para "Settings" > "API"
2. Copie:
   - **Project URL** (ex: `https://abcdefghijklmnop.supabase.co`)
   - **anon public** key (começa com `eyJ...`)

### 6. Atualizar o código
1. Abra o arquivo `index.html`
2. Procure por estas linhas:
```javascript
const SUPABASE_URL = 'https://xbafnxgtsdatgttoaydl.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhiYWZueGd0c2RhdGd0dG9heWRsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUwODc3MTcsImV4cCI6MjA3MDY2MzcxN30._PDz1hhAxPMa2NNEJSEc30lkAtt18BRtsoqUFA545Aw';
```

3. Substitua pelos valores reais do seu projeto:
```javascript
const SUPABASE_URL = 'https://xbafnxgtsdatgttoaydl.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhiYWZueGd0c2RhdGd0dG9heWRsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUwODc3MTcsImV4cCI6MjA3MDY2MzcxN30._PDz1hhAxPMa2NNEJSEc30lkAtt18BRtsoqUFA545Aw';
```

## 🌐 Como usar

### Adicionar itens
1. Preencha o formulário com:
   - Nome do item (obrigatório)
   - Descrição (opcional)
   - Preço (opcional)
   - URL da imagem (opcional)
   - Link para compra (opcional)

2. Clique em "🎁 Adicionar à Lista"

### Visualizar itens
1. Clique em "👁️ Ver Detalhes" em qualquer item
2. Modal abre com informações completas
3. Clique em "🛒 Comprar Agora" para ir ao link de compra

### Gerenciar itens
- **Marcar como comprado**: Use o botão verde no modal
- **Remover item**: Clique no botão 🗑️
- **Ver estatísticas**: Painel superior mostra totais

## 📁 Estrutura dos arquivos

```
wishlist/
├── index.html          # Arquivo principal
├── README.md           # Este arquivo
└── .gitignore          # Arquivos para ignorar no Git
```

## 🔧 Personalização

### Cores
As cores principais estão definidas no Tailwind config:
- Vermelho principal: `#dc2626`
- Vermelho secundário: `#ef4444`
- Fundo: gradiente de vermelho claro para branco

### Estilo
- Modifique as classes Tailwind no HTML
- Ajuste o CSS customizado na seção `<style>`
- Personalize as animações e transições

## 🚀 Deploy

### GitHub Pages
1. Faça push do código para o GitHub
2. Vá em Settings > Pages
3. Escolha a branch main
4. Acesse o link gerado

### Netlify
1. Conecte seu repositório GitHub
2. Deploy automático a cada push
3. URL personalizada disponível

### Vercel
1. Importe o projeto do GitHub
2. Deploy automático
3. Domínio personalizado

## ⚠️ Importante

- **Nunca compartilhe** suas chaves do Supabase
- **Mantenha** o arquivo `.gitignore` atualizado
- **Teste** sempre antes de fazer deploy
- **Backup** dos dados importantes

## 🆘 Suporte

Se encontrar problemas:
1. Verifique o console do navegador (F12)
2. Confirme as credenciais do Supabase
3. Verifique se a tabela foi criada corretamente
4. Teste a conexão com o banco

## 🚀 **Funcionalidades Implementadas:**

### ✅ **Sistema de Categorias**
- 7 categorias pré-definidas (Eletrônicos, Roupas, Livros, Casa, Esportes, Beleza, Outros)
- Filtros por categoria
- Badges visuais para cada categoria

### ✅ **Sistema de Filtros e Busca**
- Busca por texto em tempo real
- Filtros por categoria e status
- Interface responsiva e intuitiva

### ✅ **Sistema de Usuários (Login/Registro)**
- Autenticação completa com Supabase Auth
- Página de login/registro separada (`auth.html`)
- Recuperação de senha
- Perfil de usuário com informações

### ✅ **Compartilhamento de Listas**
- Compartilhamento nativo (Web Share API)
- Fallback para copiar link
- Links únicos por usuário

### ✅ **Sistema de Notificações**
- Notificações em tempo real
- Badge de contagem
- Painel de notificações expansível
- Marcar como lida individualmente ou em massa

### ✅ **Histórico de Mudanças**
- Rastreamento completo de ações
- Filtros por tipo de ação e período
- Interface organizada e visual

## 🔧 **Configuração das Funcionalidades Avançadas:**

### **1. Configurar Autenticação:**
1. No Supabase Dashboard, vá em **Authentication** → **Settings**
2. Ative **Enable email confirmations** (opcional)
3. Configure **Site URL** com seu domínio

### **2. Atualizar Banco de Dados:**
1. Execute o arquivo `update-database.sql` no Supabase SQL Editor
2. Execute o arquivo `setup-advanced-features.sql` no Supabase SQL Editor
3. Isso criará todas as tabelas e políticas necessárias

### **3. Configurar RLS (Row Level Security):**
- As políticas já estão configuradas no SQL
- Cada usuário só vê seus próprios itens, notificações e histórico
- Sistema seguro e isolado por usuário

### **4. Testar Funcionalidades:**
1. Acesse `auth.html` para criar conta ou fazer login
2. Teste todas as funcionalidades na aplicação principal
3. Verifique se as notificações e histórico estão funcionando

## 📁 **Estrutura dos arquivos atualizada:**

```
wishlist/
├── index.html                    # Aplicação principal com todas as funcionalidades
├── auth.html                     # Sistema de autenticação
├── config.js                     # Configurações do Supabase
├── update-database.sql           # SQL para categorias
├── setup-advanced-features.sql  # SQL para funcionalidades avançadas
├── README.md                     # Este arquivo
└── .gitignore                    # Arquivos para ignorar no Git
```

---

**Feito com ❤️ usando Supabase + Tailwind CSS**
