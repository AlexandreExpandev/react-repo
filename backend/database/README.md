# Database Scripts

Esta pasta contém os scripts SQL para criar e popular o banco de dados do projeto demo.

## Arquivos SQL

Os arquivos são executados em ordem alfabética pelo sistema de deploy:

### 1. `01_schema.sql`
- **Objetivo**: Criar a estrutura do banco de dados
- **Conteúdo**:
  - Tabela `users` (usuários)
  - Tabela `projects` (projetos)
  - Tabela `user_sessions` (sessões de usuário)
  - Índices para performance

### 2. `02_seed_users.sql`
- **Objetivo**: Popular a tabela de usuários com dados iniciais
- **Conteúdo**: 10 usuários de exemplo (3 admins, 7 users)

### 3. `03_seed_projects.sql`
- **Objetivo**: Popular a tabela de projetos com dados iniciais
- **Conteúdo**: 10 projetos de exemplo vinculados aos usuários

### 4. `04_views_and_procedures.sql`
- **Objetivo**: Criar views e stored procedures úteis
- **Conteúdo**:
  - View `user_project_summary` (resumo de projetos por usuário)
  - View `project_details` (detalhes de projetos com info do dono)
  - Procedure `GetUserStatistics` (estatísticas de usuários)
  - Procedure `CleanupExpiredSessions` (limpeza de sessões expiradas)
  - Function `IsUserAdmin` (verifica se usuário é admin)

## Estrutura do Banco

### Tabela `users`
```sql
- id (INT, PK, IDENTITY)
- name (NVARCHAR(100))
- email (NVARCHAR(255), UNIQUE)
- role (NVARCHAR(50), DEFAULT 'user')
- created_at (DATETIME2)
- updated_at (DATETIME2)
```

### Tabela `projects`
```sql
- id (INT, PK, IDENTITY)
- name (NVARCHAR(200))
- description (NVARCHAR(MAX))
- owner_id (INT, FK para users.id)
- status (NVARCHAR(50), DEFAULT 'active')
- created_at (DATETIME2)
- updated_at (DATETIME2)
```

### Tabela `user_sessions`
```sql
- id (INT, PK, IDENTITY)
- user_id (INT, FK para users.id)
- session_token (NVARCHAR(255), UNIQUE)
- expires_at (DATETIME2)
- created_at (DATETIME2)
```

## Deploy Automático

Durante o deploy no Azure:

1. ✅ **Azure SQL Database** é criado automaticamente
2. ✅ **Scripts SQL** são executados em ordem (01, 02, 03, 04...)
3. ✅ **Dados iniciais** ficam disponíveis imediatamente
4. ✅ **Connection string** é configurada no backend automaticamente

## Dados de Exemplo

Após a execução dos scripts, teremos:
- **10 usuários** (incluindo admins e usuários regulares)
- **10 projetos** com diferentes status (active, completed, planning)
- **Views e procedures** prontas para consultas avançadas

## Uso Local

Para testar localmente com SQL Server:

```sql
-- Executar em ordem:
SQLCMD -S localhost -E -i 01_schema.sql
SQLCMD -S localhost -E -i 02_seed_users.sql
SQLCMD -S localhost -E -i 03_seed_projects.sql
SQLCMD -S localhost -E -i 04_views_and_procedures.sql
```

## Compatibilidade

- ✅ **Azure SQL Database**
- ✅ **SQL Server 2019+**
- ✅ **SQL Server Express**