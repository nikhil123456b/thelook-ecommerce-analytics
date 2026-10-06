with eligible as (
    select *
    from {{ ref('mart_cohort_retention') }}
    where cohort_month <= date_sub(
            (select max(cohort_month) from {{ ref('mart_cohort_retention') }}),
            interval 13 month
          )
      and months_since_first between 0 and 12
)

select
    months_since_first,
    sum(active_customers) as active_customers,
    round(
        sum(active_customers)
        / (select sum(active_customers) from eligible where months_since_first = 0),
        4
    ) as retention_rate
from eligible
group by months_since_first