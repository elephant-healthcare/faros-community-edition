-- GitHub teams
create table "vcs_Team" (
  id text generated always as (pkey(source, uid)) stored primary key,
  origin text,
  "refreshedAt" timestamptz not null default now(),
  source text,
  uid text not null,
  name text
);

-- Map GitHub repos to vcs_Team
create table "elephant_TeamRepositoryAssociation" (
  id text generated always as (pkey(team, repository)) stored primary key,
  origin text,
  "refreshedAt" timestamptz not null default now(),
  team text not null,
  repository text not null
);
alter table "elephant_TeamRepositoryAssociation" add foreign key (team) references "vcs_Team"(id);
alter table "elephant_TeamRepositoryAssociation" add foreign key (repository) references "vcs_Repository"(id);

-- Linear teams
create table "tms_Team" (
  id text generated always as (pkey(source, uid)) stored primary key,
  origin text,
  "refreshedAt" timestamptz not null default now(),
  source text,
  uid text not null,
  name text
);

alter table "tms_Task" add column team text;
alter table "tms_Task" add foreign key (team) references "tms_Team"(id);

-- Custom Elephant team table that connects teams from github, linear and grafana incident
-- Manually populated through Hasura
create table "elephant_Team" (
  id text generated always as (pkey(name)) stored primary key,
  name text not null,
  ims_team text,
  tms_team text,
  vcs_team text
);

alter table "elephant_Team" add foreign key (ims_team) references "ims_Team"(id);
alter table "elephant_Team" add foreign key (tms_team) references "tms_Team"(id);
alter table "elephant_Team" add foreign key (vcs_team) references "vcs_Team"(id);

