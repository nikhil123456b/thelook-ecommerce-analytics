select
    id as user_id,
     age,
      gender,
       country,
        traffic_source,
         created_at as signed_up_at
from {{ source('thelook_raw', 'users') }}