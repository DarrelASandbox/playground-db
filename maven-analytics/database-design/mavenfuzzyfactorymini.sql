USE mavenfuzzyfactorymini;

SELECT
  *
FROM
  orders_mini;

SELECT
  *
FROM
  order_items_mini
WHERE
  order_id = 9994 -- this is the foreign key, which links to the primary key in orders (order_id)
;

SELECT
  *
FROM
  order_item_refunds_mini;

SELECT
  *
FROM
  website_pageviews_non_normalized
WHERE
  website_session_id = 20;

CREATE TABLE website_pageviews_normalized
SELECT
  website_pageview_id,
  created_at,
  website_session_id,
  pageview_url
FROM
  website_pageviews_non_normalized;

SELECT
  *
FROM
  website_pageviews_normalized;

CREATE TABLE website_sessions_normalized
SELECT
  DISTINCT website_session_id,
  session_created_at,
  user_id,
  is_repeat_session,
  utm_source,
  utm_campaign,
  utm_content,
  device_type,
  http_referer
FROM
  website_pageviews_non_normalized
WHERE
  website_session_id = 20;

SELECT
  *
FROM
  website_sessions_normalized