{{ config(
    materialized='table'
) }}

WITH ownership_details AS (
    SELECT
        entity_urn,
        entity_type,
        owner_user_name,
        owner_title,
        associated_domain
    FROM
        {{ ref('int_ownership_details') }}
)

SELECT
    owner_user_name,
    owner_title,
    associated_domain,
    entity_type,
    COUNT(DISTINCT entity_urn) AS entity_count
FROM
    ownership_details
GROUP BY
    owner_user_name, 
    owner_title, 
    associated_domain, 
    entity_type
ORDER BY
    entity_count DESC, 
    owner_user_name, 
    associated_domain, 
    entity_type;