-- Show all names of people who are in the airbnb_milan db
SELECT host_name 
FROM hosts;

-- Show all names of all places
SELECT name
FROM places;

--Show all places in the Centrale neighbourhood
SELECT * 
FROM places
WHERE neighbourhood = 'CENTRALE';

-- Show all host name ending "ZO"
SELECT host_name
FROM hosts
WHERE host_name LIKE '%zo';

-- Show count of apartments in the NAVIGLI neighbourhood
SELECT COUNT(*) AS count
FROM places
WHERE neighbourhood = 'NAVIGLI';

-- Show all hosts who has a apatments in SARPI neighbourhood
SELECT DISTINCT name 
FROM hosts
JOIN places
ON hosts.id=places.id
WHERE neighbourhood = 'SARPI';

--Show all apartments with price from 50 to 100 per night
SELECT name, price 
FROM places
JOIN price
ON places.id=price.id
WHERE price BETWEEN 50 AND 100 ;

-- Show host with a longest name
SELECT host_name
FROM hosts
WHERE LENGTH(host_name) = (SELECT MAX(LENGTH(host_name)) 
FROM hosts);

-- Show repeated host names
SELECT host_name
FROM hosts
GROUP BY host_name
HAVING COUNT(host_name) >1;

--Show how many reviews has every Valentinas apartment 
SELECT host_name, id, name, number_of_reviews
FROM hosts
JOIN places
    ON hosts.id=places.id
JOIN reviews
    ON places.id = reviews.id
WHERE host_name = 'Valentina';

-- Show how many aparments has every host
SELECT id, host_name, COUNT(id) as count
FROM hosts
GROUP BY host_name
ORDER BY count DESC;

-- Show average price of apartments in the CENTRALE neighbourhood
SELECT AVG(price) as cost
FROM price
JOIN places
ON price.id=places.id
WHERE neighbourhood = 'CENTRALE';

-- Showing the most expensive apartment for 2 weeks
SELECT name, MAX(price*14) as price_two_weeks
FROM places
JOIN price
ON price.id=places.id;

--Show apartments with no last review in year 2015
SELECT p.name, r.last_review
FROM places p
JOIN reviews r
ON p.id=r.id
WHERE last_review NOT LIKE ('%2015');

--Show what percentage of hosts have apartments in neighbourhood BRERA
SELECT COUNT (DISTINCT host_name)*100/(SELECT COUNT(DISTINCT host_name) FROM hosts) as percent
FROM hosts
WHERE host_name LIKE 'A%';

-- Insert host with name Maria Mila with new host id and apartment id 

INSERT INTO hosts(host_name, host_id, id)
SELECT 
    'Maria Mila',
    MAX(host_id)+1,
    MAX(id)+1  
FROM hosts;

-- Delete Maria Mila from hosts
DELETE FROM hosts
WHERE host_name LIKE 'Maria Mila';

-- Show which hosts have the most reviews in total
SELECT host_name, SUM(number_of_reviews) total_reviews
FROM hosts
JOIN reviews
ON hosts.id=reviews.id
GROUP BY host_name
ORDER BY SUM(number_of_reviews) DESC;
 
-- Update price per night 
UPDATE price
SET price= price+5;

--Show the most popular aparments by number of review
SELECT name, number_of_reviews
FROM places
JOIN reviews
ON places.id=reviews.id
ORDER BY number_of_reviews DESC
LIMIT 1;

-- Show apartments that are not available in the year and have NULL value and change to 0
SELECT name, IFNULL(availability_365, 0) as not_available
FROM places
WHERE availability_365 = 0 OR availability_365 IS NULL;