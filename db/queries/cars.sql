-- name: GetFreeCars :many
SELECT * FROM cars WHERE is_reserve = FALSE;