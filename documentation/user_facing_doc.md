# User Facing Documentation

## Overview
The following documentation provides detailed information for analysts and day-to-day users to understand and use the ownership_summary model effectively. It explains the purpose, key fields and examples of how to use the model in analysis.

## Model Details
The ownership_summary model provides a sumary of ownership counts for datasets and dashboards. They are grouped by owner user name, job title and associated domain name. It helps answer some preliminay questions:

1. Which users own the most datasets and dashboards?
2. What is the distribution of ownership across different domains?

The table contains the following fields:

| Field Name        | Description                                                                          | Example            |
|-------------------|--------------------------------------------------------------------------------------|--------------------|
| owner_name        | Full name of the individual responsible for managing datasets and dashboards.        | John Doe           |
| owner_user_name   | The username of the individual responsible for managing datasets and dashboards.     | johndoe@email.com  |
| owner_title       | The job title of the individual responsible for managing datasets and dashboards.    | Analytics Engineer |
| associated_domain | The domain (e.g., Finance, Sales) associated with the owned datasets and dashboards. | E-Commerce         |
| entity_type       | The type of entity owned by the user (e.g., dataset, dashboard).                     | dataset            |
| entity_count      | The total number of entities owned by the user in the associated domain.             | 100                |

## Example Queries to Run

1. Find the top user with the most owned datasets

``` 
SELECT 
    owner_name,
    owner_user_name, 
    SUM(entity_count) AS total_datasets_owned
FROM {{ ref('ownership_summary') }}
WHERE entity_type = 'dataset'
GROUP BY owner_name, owner_user_name
ORDER BY total_datasets_owned DESC
LIMIT 1;
``` 

2. Identify domains with the most dashboards owned

``` 
SELECT 
    associated_domain, 
    SUM(entity_count) AS total_dashboards
FROM {{ ref('ownership_summary') }}
WHERE entity_type = 'dashboard'
GROUP BY associated_domain
ORDER BY total_dashboards DESC;

``` 
3. Identify unique owners

``` 
SELECT 
    distinct owner_name
FROM {{ ref('ownership_summary') }};

``` 