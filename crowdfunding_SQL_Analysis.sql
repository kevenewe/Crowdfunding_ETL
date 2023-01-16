-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cam.cf_id, count(Bac.backer_id)
FROM campaign as cam
INNER JOIN backers as Bac
on cam.cf_id = Bac.cf_id
where cam.outcome = 'live'
GROUP BY cam.cf_id
ORDER BY count(bac.backer_id) DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT cam.cf_id, count(Bac.backer_id)
FROM backers as Bac 
INNER JOIN campaign as cam
on cam.cf_id = Bac.cf_id
where cam.outcome = 'live'
GROUP BY cam.cf_id
ORDER BY count(bac.backer_id) DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

DROP TABLE live_projects;
	
CREATE TABLE live_projects (
	first_name VARCHAR,
	last_name VARCHAR,
	email VARCHAR,
	remaining_amount int);
	
INSERT INTO live_projects AS lp
	select 
		con.first_name,
		con.last_name,
		con.email,
		(camp.goal - camp.pledged)
	from contacts as con
	INNER JOIN campaign as camp
		ON con.contact_id = camp.contact_id
	where
		outcome = 'live'
	ORDER BY (camp.goal - camp.pledged) DESC

	
-- Check the table
select * FROM live_projects

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
CREATE TABLE email_backers_remaining_goal_amount (
	email VARCHAR,
	first_name VARCHAR,
	last_name VARCHAR,
	cf_id int,
	company_name VARCHAR,
	description VARCHAR,
	end_date DATE,
	Left_of_Goal int
)

INSERT INTO email_backers_remaining_goal_amount AS eb
	select 
		bac.email,
		bac.first_name,
		bac.last_name,
		bac.cf_id,
		camp.company_name,
		camp.description,
		camp.end_date,
		(camp.goal - camp.pledged)
	from backers as bac
	INNER JOIN campaign as camp
		ON bac.cf_id = camp.cf_id
	where
		outcome = 'live'
	ORDER BY bac.email DESC

-- Check the table
select * FROM email_backers_remaining_goal_amount
		