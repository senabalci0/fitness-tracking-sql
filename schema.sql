create table users(
 user_id serial primary key,
 name varchar(50) not null,
 age int,
 gender varchar(50),
 height_cm int,
 weight_kg int,
 created_at date default current_date
 );
 
 create table exercises(
 exercise_id serial primary key,
 name varchar(100) not null,
 muscle_group varchar(50),
 calories_burned_per_min int
 );
 
 create table workouts (
 workout_id serial primary key,
 user_id int references users(user_id),
 workout_date date,
 duration_min int
 );
 
 create table workout_exercises (
    id serial primary key,
    workout_id int references workouts(workout_id),
    exercise_id int references exercises(exercise_id),
    sets int,
    reps int
);

create table progress_logs (
    log_id serial primary key,
    user_id int references users(user_id),
    log_date date,
    weight_kg decimal
);