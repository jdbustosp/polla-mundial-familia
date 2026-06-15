create table if not exists public.family_predictions (
  player_index smallint primary key check (player_index between 0 and 7),
  predictions jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.family_predictions enable row level security;

grant select, insert, update
on table public.family_predictions
to anon, authenticated;

drop policy if exists "Public read family predictions"
on public.family_predictions;

create policy "Public read family predictions"
on public.family_predictions
for select
to anon, authenticated
using (true);

drop policy if exists "Public insert family predictions"
on public.family_predictions;

create policy "Public insert family predictions"
on public.family_predictions
for insert
to anon, authenticated
with check (player_index between 0 and 7);

drop policy if exists "Public update family predictions"
on public.family_predictions;

create policy "Public update family predictions"
on public.family_predictions
for update
to anon, authenticated
using (player_index between 0 and 7)
with check (player_index between 0 and 7);
