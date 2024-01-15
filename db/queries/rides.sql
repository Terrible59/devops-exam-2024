-- name: GetUserRides :many
SELECT c.*, r.created_at
FROM rides AS r
INNER JOIN cars AS c
ON r.car_id = c.id
WHERE user_id = $1;