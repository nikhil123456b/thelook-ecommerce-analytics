with s as (
    select * from {{ ref('fct_sessions') }}
)

select 1 as stage_order, '1. Viewed product' as stage, countif(viewed_product) as sessions from s
union all
select 2, '2. Added to cart', countif(added_to_cart) from s
union all
select 3, '3. Purchased', countif(purchased) from s