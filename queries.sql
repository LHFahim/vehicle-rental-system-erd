--  enums start  --
CREATE TYPE user_role_enum AS ENUM (
  'Admin',
  'Customer'
);

CREATE TYPE vehicle_type_enum AS ENUM (
  'car',
  'bike',
  'truck'
);

CREATE TYPE vehicle_availability_enum AS ENUM (
  'available',
  'rented',
  'maintenance'
);

CREATE TYPE booking_status_enum AS ENUM (
  'pending',
  'confirmed',
  'completed',
  'cancelled'
);
--  enums end  --






-- query 1
SELECT
  b.id AS booking_id,
  u.name AS customer_name,
  v.name AS vehicle_name,
  b.rent_start_date AS start_date,
  b.rent_end_date AS end_date,
  b.status
FROM bookings b
INNER JOIN users u
  ON b.user_id = u.id
INNER JOIN vehicles v
  ON b.vehicle_id = v.id;




-- query 2
SELECT
  v.id AS vehicle_id,
  v.name,
  v.type,
  v.model,
  v.registration_number,
  v.price_per_day AS rental_price,
  v.availability_status AS status
FROM vehicles v
WHERE NOT EXISTS (
  SELECT 1
  FROM bookings b
  WHERE b.vehicle_id = v.id
);

-- query 3
SELECT
  id AS vehicle_id,
  name,
  type,
  model,
  registration_number,
  price_per_day AS rental_price,
  availability_status AS status
FROM vehicles
WHERE availability_status = 'available'
  AND type = 'car';


-- query 4
SELECT
  v.name AS vehicle_name,
  COUNT(b.id) AS total_bookings
FROM vehicles v
INNER JOIN bookings b
  ON b.vehicle_id = v.id
GROUP BY v.name
HAVING COUNT(b.id) > 2;


