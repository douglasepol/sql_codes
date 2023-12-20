-- Here you can use JSON or JSONB as a data type for a column.
CREATE TABLE customer_reviews (
    id SERIAL NOT NULL PRIMARY KEY,
    review JSON NOT NULL
);


INSERT INTO customer_reviews (review)
VALUES('{ "customerName": "Bob ", "items":{"rating": 4, "comment": "Great selection." }}'),
      ('{ "customerName": "Eve ", "items":{"rating": 5, "comment": "Highly recommend!" }}'),
      ('{ "customerName": "Charlie ", "items":{"rating": 1, "comment": "Not worth the price." }}'),
      ('{ "customerName": "Alice ", "items":{"rating": 5, "comment": "Excellent service!" }}');


SELECT 
    * 
FROM customer_reviews;


SELECT 
    review ->> 'customerName' AS customer_name
FROM customer_reviews;


SELECT 
    review ->> 'customerName' as customer_name,
    review -> 'items' ->> 'rating' as rating
FROM customer_reviews;


SELECT 
    review ->> 'customerName' AS customer_name,
    review -> 'items' ->> 'rating' AS rating
FROM customer_reviews
WHERE (review -> 'items' ->> 'rating')::INTEGER = 5;


SELECT 
   MIN(CAST(review -> 'items' ->> 'rating' AS INTEGER)) as min_rating,
   MAX(CAST(review -> 'items' ->> 'rating' AS INTEGER)) as max_rating,
   AVG(CAST(review -> 'items' ->> 'rating' AS INTEGER)) as avg_rating
FROM customer_reviews;


SELECT 
    *
FROM customer_reviews
WHERE review @> '{"items": {"rating": 5}}';
