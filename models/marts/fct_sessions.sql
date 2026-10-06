select
    session_id,
    any_value(user_id) as user_id,
    any_value(traffic_source) as traffic_source,
    min(created_at) as session_start_at,
    count(*) as event_count,
    countif(event_type = 'product') > 0 as viewed_product,
    countif(event_type = 'cart') > 0 as added_to_cart,
    countif(event_type = 'purchase') > 0 as purchased
from {{ ref('stg_events') }}
group by session_id