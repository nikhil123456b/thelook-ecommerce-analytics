select
    id as order_item_id, 
    order_id, 
    user_id, 
    product_id, 
    status,
    created_at,
    sale_price
from {{ source('thelook_raw', 'order_items') }}