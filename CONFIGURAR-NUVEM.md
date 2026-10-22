# Configurar login e salvamento na nuvem

O Guarda Ideias usa Supabase Auth para criar contas e uma tabela Postgres com Row Level Security (RLS) para manter as anotações separadas por usuário. A chave usada no navegador é a **publishable key** (ou a antiga chave `anon`); nunca coloque uma `service_role` ou secret key neste site.

## 1. Criar o projeto

1. Crie um projeto em [supabase.com/dashboard](https://supabase.com/dashboard).
2. No projeto, abra **SQL Editor**, cole o conteúdo de `supabase-schema.sql` e execute.
3. Em **Authentication → URL Configuration**, configure:
   - **Site URL:** `https://eltonjuniorferraz-design.github.io/Mapamental/`
   - **Redirect URLs:** `https://eltonjuniorferraz-design.github.io/Mapamental/`
4. Em **Project Settings → API**, copie o **Project URL** e a **publishable key** (ou a chave `anon` se o painel só mostrar a opção antiga).

## 2. Conectar o site

No começo do script em `index.html`, substitua os valores de exemplo:

```js
const SUPABASE_URL='https://SEU-PROJETO.supabase.co';
const SUPABASE_PUBLISHABLE_KEY='COLE_SUA_CHAVE_PUBLICAVEL_AQUI';
```

Use apenas o Project URL e a publishable/anon key. Não envie nem publique qualquer chave chamada `service_role`, `secret`, senha do banco ou senha da sua conta Supabase.

## 3. Conferir autenticação

Em **Authentication → Providers → Email**, deixe o provedor de e-mail ativo. Recomenda-se manter a confirmação de e-mail habilitada. Faça uma conta de teste, confirme o e-mail e verifique se as anotações aparecem depois de entrar em outro dispositivo.

O site exporta PDF e cópias JSON para o próprio dispositivo. A tabela `ideas` permite que cada conta leia, crie, altere e exclua somente as próprias linhas.

