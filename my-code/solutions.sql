-- Which titles each author has published and under which publishers?

SELECT 
    author.au_id AS "AUTHOR ID",
    author.au_lname AS "LAST NAME",
    author.au_fname AS "FIRST NAME",
    titles.title AS "TITLE",
    publishers.pub_name AS "PUBLISHER"
FROM 
    titleauthor
JOIN 
    authors ON titleauthor.au_id = author.au_id
JOIN 
    titles ON titleauthor.title_id = titles.title_id
JOIN 
    publishers ON titles.pub_id = publishers.pub_id;


-- How many titles each author has published with each publisher.

SELECT 
    authors.au_id AS "AUTHOR ID",
    authors.au_lname AS "LAST NAME",
    authors.au_fname AS "FIRST NAME",
    publishers.pub_name AS "PUBLISHER",
    COUNT(titles.title_id) AS "TITLE COUNT"
FROM 
    titleauthor
JOIN 
    authors ON titleauthor.au_id = authors.au_id
JOIN 
    titles ON titleauthor.title_id = titles.title_id
JOIN 
    publishers ON titles.pub_id = publishers.pub_id
GROUP BY 
    authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name
ORDER BY 
    authors.au_id, publishers.pub_name;
	
--Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.
	
SELECT 
    authors.au_id AS "AUTHOR ID",
    authors.au_lname AS "LAST NAME",
    authors.au_fname AS "FIRST NAME",
    COUNT(titles.title_id) AS "TOTAL"
FROM 
    titleauthor
JOIN 
    authors ON titleauthor.au_id = authors.au_id
JOIN 
    titles ON titleauthor.title_id = titles.title_id
GROUP BY 
    authors.au_id, authors.au_lname, authors.au_fname
ORDER BY 
    authors.au_id desc
limit 3;

--Now modify your solution from Challenge 3 so that the output shows all 23 authors instead of just the top 3. Note that authors who have sold 0 titles should also appear in your output (ideally showing 0 instead of NULL for TOTAL). Also, sort your results based on TOTAL in descending order.

SELECT 
    authors.au_id AS "AUTHOR ID",
    authors.au_lname AS "LAST NAME",
    authors.au_fname AS "FIRST NAME",
    COALESCE(COUNT(titleauthor.title_id), 0) AS "TOTAL"
FROM 
    authors
LEFT JOIN 
    titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY 
    authors.au_id, authors.au_lname, authors.au_fname
ORDER BY 
    "TOTAL" DESC;
