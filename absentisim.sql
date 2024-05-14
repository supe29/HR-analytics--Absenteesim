--create a join table
select * from absence_records a
left join compensation b
on a.id = b.id
left join reasons r
on a.reason_for_absence = r.number;

--- find the healthiest 
select * from absence_records
where social_drinker = 0 and social_smoker = 0
and body_mass_index <25 and 
absenteeism_time_in_hours<(select AVG(absenteeism_time_in_hours) from absence_records)

---Compensation rate increase for non-smokers/ budget euro 983,221-> 5week*8hoursday*52 weeksyear= 0.68 cent per hour (increment)
select count(*) as nonsmokers from absence_records
where Social_smoker = 0

--optimizing querry
select 
a.id,
r.reason,
month_of_absence,
body_mass_index,
case WHEN body_mass_index <18.5 then 'Underweight'
	 WHEN body_mass_index between 18.5 and 25 then 'Healthy'
	 WHEN body_mass_index between 25 and 30 then 'Overweight'
	 WHEN body_mass_index >30 then 'Obese'
	 ELSE 'Unkown' end as BMI_Category,
case WHEN month_of_absence IN (12,1,2) Then 'Winter'
	 WHEN month_of_absence IN (3,4,5) Then 'Spring'
	 WHEN month_of_absence IN (6,7,8) Then 'Summer'
	 WHEN month_of_absence IN (9,10,11) Then 'Winter'
	 ELSE 'Unkown' END as Season_Names,
month_of_absence,
day_of_the_week,
transportation_expense
from absence_records a
left join compensation b
on a.id = b.id
left join reasons r
on a.reason_for_absence = r.number;