CREATE TABLE IF NOT EXISTS public.restaurants (
  id integer primary key generated always as identity,
  user_id varchar(255) NOT NULL,
  username varchar(255) NOT NULL,
  restaurant_name text NOT NULL,
  restaurant_location text NOT NULL,
  restaurant_logo text NOT NULL,
  restaurant_lat double precision NOT NULL,
  restaurant_lng double precision NOT NULL,
  updated_at timestamp with time zone NOT NULL default now(),
  created_at timestamp with time zone NOT NULL default now()
);