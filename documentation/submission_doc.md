# Submission Documentation

## Overview
The purpose of this documentation is to allow reviewers to understand the intention behind the design of the ownership summary data models.

## Use Case
As a data engineer, I want to analyze ownership of datasets and dashboards by user names, job titles, entity counts and domain name. This report could potentially benefit our data governance team, technical support and business analysts. Identifying these details will help the product and engineering team:

1. Identify individuals responsible for critical data assets.
2. Highlight potential issues with incorrect ownership.
3. Strategize ownership transition for consistent support of data assets and dashboards.
4. Understand ownership across different job roles.
5. Troubleshoot and establish point of contact for issues with data assets and dashboards.

## Assumptions
Below are assumptions made during the design of these models.

1. Ownership relationships are assumed to be stable and do not require incremental processing. Incremental processing would have been further considered as an approach if datahub_entities_raw.csv seed file had an updated_on column.
2. Adding domain-level aggregation to show ownership distribution by business domain gives insight into the variety of datasets/dashboards being created
3. Assuming this dataset does not update often, materalizing the models as a table was the best option to give the end user the ability to query results faster
4. An owner cannot have more than one title.
5. An owner can own datasets in multiple domains.
6. Stakeholders are not interested in datasets/dashboards with no owners for cleaner output.
7. This project will have additional models that are created on multiple layers. For that reason, organizing models in a specific grouping based on business needs with their own separate yml 
file to avoid clutter.

## Model-Specific Notes

All models reside in one of three sub-directories within the models directory

1. **Staging Layer:** This layer contains sub-directories for base source tables and a normalization sub-directory for normalized raw data based off of their theme and use case.
    - cleaned_entity_domains (staging/normalization/owner_analysis)
        - Normalized domain information for datasets and dashboards. Extracts domain assignments.
        - Normalized domain data is stored here to simplify downstream joins and avoid clutter
    - cleaned_entity_owners (staging/normalization/owner_analysis)
        - Normalized ownership data for datasets and dashboards. Extracts owner relationships.
        - Normalized owner data is stored here to simplify downstream joins and avoid clutter
2. **Intermediate Layer:** This layer contains models where any enrichment or transformation occurs
    - int_ownership_details (int/owner_analysis)
        - Combines ownership, user, and domain data, providing a comprehensive dataset for exploratory analysis.
3. **Reporting Layer:** This layer contains final prepared models ready to be utilized and optimized for reporting and consumption by less technical stakeholders.
    - ownership_summary (reporting/owner_analysis)
        - Summary of entity type ownership counts by user name and domain. Aggregates data for reporting purposes.

## Opportunities for Future Improvements
1. Add dashboard or dataset URNs to get additional detail
2. Add dataset and dashboards with no owners
3. Add ability to identify when dataset/dashboard was last updated.