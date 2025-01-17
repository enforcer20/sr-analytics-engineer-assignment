{{ config(
    materialized='table'
) }}

WITH ownership_details AS (
    SELECT
        entity_urn,
        entity_type,
        owner_user_name,
        owner_title,
        owner_name,
        department_name,
        associated_domain
    FROM
        {{ ref('int_ownership_details') }}
)

SELECT
    owner_name,
    owner_user_name,
    owner_title,
    department_name,
    associated_domain,
    entity_type,
    COUNT(DISTINCT entity_urn) AS entity_count
FROM
    ownership_details
GROUP BY
    owner_name,
    owner_user_name, 
    owner_title, 
    department_name,
    associated_domain, 
    entity_type
ORDER BY
    entity_count DESC, 
    owner_name,
    owner_user_name, 
    department_name,
    associated_domain, 
    entity_type;