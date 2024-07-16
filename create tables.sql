create table team(
    id bigserial primary key,
    name varchar(255) not null
);


create table user_info(
    id bigserial primary key,
    guid varchar(55) unique,
    username varchar(255) not null,
    email varchar(255) unique not null,
    password varchar(50) not null
);


create table team_user(
    id bigserial primary key,
    id_team bigint references team(id),
    id_user bigint references user_info(id),
    role varchar(25) default 'USER'
);


create table board(
    id bigserial primary key,
    name varchar(50) not null,
    id_team bigint references team(id)
);


create table status_column(
    id bigserial primary key,
    name varchar(255) not null,
    id_board bigint references board(id)
);


create table card(
    id bigserial primary key,
    title varchar(255) not null,
    label varchar(255),
    start_date date not null,
    deadline date not null,
    id_status bigint references status_column(id),
    id_board bigint references board(id)
);


create table user_card(
    id bigserial primary key,
    guid_user varchar(55) references user_info(guid),
    id_card bigint references card(id)
);


create table task(
    id bigserial primary key,
    title varchar(255) not null,
    isCompleted boolean default false,
    id_card bigint references card(id)
);


create table tags(
    id bigserial primary key,
    name varchar(100),
    id_board bigint references board(id)
);


create table card_tags(
    id bigserial primary key,
    id_card bigint references card(id),
    id_tags bigint references tags(id)
);


create table card_comment(
    id bigserial primary key,
    comment_text text,
    comment_datetime timestamp,
    id_card bigint references card(id),
    guid_user varchar(55) references user_info(guid)
);


create table friendship(
  id bigserial primary key,
  id_user1_sender bigint references user_info(id),
  id_user2_receiver bigint references user_info(id),
  status varchar(255)
);


create table team_user_notifications(
  id bigserial primary key,
  id_sender bigint references team(id),
  id_receiver bigint references user_info(id),
  status varchar(255)
);
create table configuration(
  id bigserial primary key,
  guid_user varchar(255) references user_info(guid),
  isPrivate_Team_Notifications boolean default false
);