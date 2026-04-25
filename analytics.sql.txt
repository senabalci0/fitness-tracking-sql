
-- most active user --

select
u.name,
count(w.workout_id) as total_workouts
from users u
join workouts w on u.user_id = w.user_id
group by u.name
order by total_workouts desc;


-- total workout time --

select 
u.name,
sum(w.duration_min) as total_minutes
from users u
join workouts w on u.user_id = w.user_id
group by u.name
order by total_minutes desc;


-- most used muscle group -- 

select 
e.muscle_group,
count(*) as total_usage
from workout_exercises we
join exercises e on we.exercise_id = e.exercise_id
group by e.muscle_group
order by total_usage desc;

-- most commonly done workout --

select 
e.name,
count(*) as total_count
from workout_exercises we
join exercises e on we.exercise_id = e.exercise_id
group by e.name
order by total_count desc;


-- total calories --

select 
u.name,
sum(e.calories_burned_per_min * w.duration_min) as total_calories
from users u
join workouts w on u.user_id = w.user_id
join workout_exercises we on w.workout_id = we.workout_id
join exercises e on we.exercise_id = e.exercise_id
group by u.name
order by total_calories desc;

-- ranking -- 

select 
u.name,
sum(w.duration_min) as total_time,
rank() over(order by sum(w.duration_min) desc) as ranking
from users u
join workouts w on u.user_id = w.user_id
group by u.name;