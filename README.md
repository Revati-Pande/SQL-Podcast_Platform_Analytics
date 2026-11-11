# Podcast Platform Analytics | SQL Project

## Project Overview

**Podcast Platform Analytics** is a SQL-based data analysis project focused on understanding listener behaviour, podcast performance, and engagement patterns.

The objective is to explore how listeners interact with podcasts, identify popular genres and shows, analyze listening trends, and understand differences between free and premium subscribers.

Through SQL analysis, this project aims to uncover meaningful insights that can help a podcast streaming platform improve listener engagement and content strategy.

## Business Objectives

- Identify the most popular podcast genres based on listening activity.
- Analyze podcast and episode performance.
- Understand listener engagement and completion rates.
- Compare listening behaviour between free and premium subscribers.
- Identify peak listening days and monthly listening trends.
- Understand listener retention and binge-listening behaviour.
- Identify underperforming podcast shows.

## Database Structure

The project uses four relational tables:

| Table | Description |
|---|---|
| `Shows` | Contains podcast show information and genres. |
| `Episodes` | Contains episode details, including duration and show relationships. |
| `Listeners` | Contains listener information and subscription details. |
| `Listens` | Records listening activity and listener interactions. |

**Database:** MySQL

## Tools & Technologies

- **MySQL** – Data extraction, transformation, and analysis.
- **SQL** – Business analysis and insight generation.
- **Git & GitHub** – Project version control and documentation.

## SQL Concepts Applied

This project demonstrates practical applications of:

- SELECT, WHERE, ORDER BY
- GROUP BY and HAVING
- Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)
- Joins (INNER JOIN and LEFT JOIN)
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- CASE Statements
- Date and String Functions
- DISTINCT and Conditional Aggregation

## Business Questions Explored

### 1. Genre Performance
- Which podcast genres generate the highest listening hours?
- Which genres attract the most listener engagement?

### 2. Episode Performance
- Which shows have the highest episode completion rates?
- Does episode duration influence completion rates?
- Which shows have comparatively lower performance?

### 3. Listener Behaviour
- How many episodes does an average listener consume?
- Which days of the week have the highest listening activity?
- Which countries demonstrate higher listener engagement?

### 4. Subscription Analysis
- How does listening behaviour differ between free and premium subscribers?
- Which subscription group generates more listening activity?

### 5. Engagement & Retention
- What are the monthly listening trends?
- How frequently do listeners return to the platform?
- Which shows encourage binge-listening behaviour?

## Key Findings

One of the interesting observations from the analysis:

**Episode Duration vs Completion Rate**

| Episode Duration | Completion Rate |
|---|---:|
| Below 30 minutes | 57.6% |
| 30 minutes and above | 58.7% |

The difference between the two groups is relatively small, suggesting that episode duration alone may not explain listening completion behaviour.

Other analyses explore genre performance, subscriber engagement, listening patterns, and show-level performance.

## Challenges & Learnings

- Working with multiple related tables to generate meaningful business metrics.
- Writing complex SQL queries to calculate listening hours and completion rates.
- Using joins and aggregations to analyze listener behaviour.
- Applying window functions to rank podcast shows within genres.
- Validating query results to ensure accurate calculations.


## Conclusion

This project demonstrates how SQL can be used to analyze streaming platform data, understand customer engagement, evaluate content performance, and identify patterns in listener behaviour.

It highlights the importance of data-driven decision-making in improving content strategy and understanding customer preferences.




