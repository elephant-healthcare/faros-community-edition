create table "elephant_TeamRepositoryAssociation" (
  id text generated always as (pkey(team, repository)) stored primary key,
  origin text,
  "refreshedAt" timestamptz not null default now(),
  team text not null,
  repository text not null
);
alter table "elephant_TeamRepositoryAssociation" add foreign key (team) references "ims_Team"(id);
alter table "elephant_TeamRepositoryAssociation" add foreign key (repository) references "vcs_Repository"(id);

create table "tms_Team" (
  id text generated always as (pkey(source, uid)) stored primary key,
  origin text,
  "refreshedAt" timestamptz not null default now(),
  source text,
  uid text not null,
  name text not null
);

alter table "tms_Task" add column team text;
alter table "tms_Task" add foreign key (team) references "tms_Team"(id);
