-- Execute this script in the Supabase SQL Editor.
-- Each signed-in user can access only their own Guarda Ideias entries.

create extension if not exists pgcrypto;

create table if not exists public.ideas (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  title text not null default '',
  body text not null default '',
  topic text not null default '',
  color text not null default '#799276',
  favorite boolean not null default false,
  archived boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.ideas enable row level security;
revoke all on public.ideas from anon;
grant select, insert, update, delete on public.ideas to authenticated;

drop policy if exists "Users can read their own ideas" on public.ideas;
create policy "Users can read their own ideas"
  on public.ideas for select to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can create their own ideas" on public.ideas;
create policy "Users can create their own ideas"
  on public.ideas for insert to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own ideas" on public.ideas;
create policy "Users can update their own ideas"
  on public.ideas for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own ideas" on public.ideas;
create policy "Users can delete their own ideas"
  on public.ideas for delete to authenticated
  using ((select auth.uid()) = user_id);

