select
    order_id,
    user_id,
    status,
    created_at,
    shipped_at,
    delivered_at,
    returned_at,
    num_of_item as item_count
from {{ source('thelook_raw', 'orders') }}