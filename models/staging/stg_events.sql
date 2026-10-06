select
    id as event_id, user_id, session_id, sequence_number, event_type, traffic_source, created_at, event_year
from {{ source('thelook_raw', 'events_part') }}