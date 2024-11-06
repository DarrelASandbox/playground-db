SELECT
user_id,
user_lastname,
user_name,
user_since
from {{var("source_schema")}}.users